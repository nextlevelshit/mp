import html
import time
from enum import Enum
from flask import Flask, request, send_file, jsonify
from prometheus_flask_exporter import PrometheusMetrics
import subprocess
import tempfile
import os
import json
import yaml
from typing import List, NamedTuple

app = Flask(__name__, static_folder=None)

metrics = PrometheusMetrics(app, defaults_prefix="mp_inkasso")

# Define a counter for successful PDF generation
pdf_generation_counter = metrics.counter(
	'mp_inkasso_pdf_generation_total',
	'Total number of PDFs generated',
	labels={'endpoint': lambda: request.endpoint}
)


class Template(Enum):
	INVOICE = "/app/data/templates/invoice-scrlttr2.tex"
	INVOICE_EXAMPLE = "/app/data/templates/invoice-scrlttr2.example.tex"
	SHIPPING = "/app/data/templates/shipping.tex"
	ORDER_CONFIRMATION = "/app/data/templates/order-confirmation.tex"


class SenderAddress(NamedTuple):
	companyname: str
	name: str
	street: str
	city: str
	email: str
	url: str


class RecipientAddress(NamedTuple):
	name: str
	address: List[str]


class Services(NamedTuple):
	description: str
	price: float
	details: List[str]


class Details(NamedTuple):
	subject: str
	date: str
	me: SenderAddress
	to: RecipientAddress
	invoice_nr: str
	author: str
	city: str
	VAT: int
	service: List[Services]
	closingnote: str


def normalize(string: str):
	return (
		string
		.lower()
		.replace('ö', 'oe')
		.replace('ä', 'ae')
		.replace('ß', 'ss')
		.replace('ü', 'ue')
		.replace(',', '')
		.replace('.', '')
		.replace(' ', '')
	)


def generate_pdf(template_path: Template, details_json: Details):
	try:
		print("Starting to generate PDF...")
		details_dict = json.loads(json.dumps(details_json))
		details_yaml = yaml.dump(details_dict)
		date = time.strftime("%Y%m%d")
		# @todo
		# today = time.strftime("%Y%m%d")
		# if details_dict["date"] == "\\today":
		#     date = today
		# else:
		#     # pprint(details_dict)
		#     print(details_dict["date"])
		#     date = (datetime
		#             # .strptime("12.02.2000", "%d.%m.%Y")
		#             .strptime(details_dict["date"], "%d. %B %Y")
		#             .strftime("%Y%m%d"))
		#     print(date)

		with tempfile.TemporaryDirectory() as temp_dir:
			# Write the details JSON to a YAML file
			details_yaml_path = os.path.join(temp_dir, 'details.md')
			details_example_path = os.path.join("/", "app", "data", 'details.md')
			# pprint(details_yaml_path)
			with open(details_yaml_path, 'w') as yaml_file:
				yaml_file.write("---\n")
				yaml_file.write("letterhead: /app/data/templates/RE.pdf\n")
				yaml_file.write(details_yaml)
				yaml_file.write("...\n")
				yaml_file.write(details_dict["body"])

			normalized_recipient = normalize(details_dict["to"]["name"])
			output_base_path = os.path.join("/", "app", "data", "output", f'{date}-pdf-{normalized_recipient}')
			output_example_path = os.path.join("/", "app", "data", "output", "example.pdf")

			if os.path.exists(output_base_path + '.pdf'):
				counter = 1
				while os.path.exists(f'{output_base_path}-{counter}.pdf'):
					counter += 1
				output_path = f'{output_base_path}-{counter}.pdf'
			else:
				output_path = output_base_path + '.pdf'

			subprocess.run([
				'make',
				'-e',
				'-B',
				f'src={details_yaml_path}',
				f'template={template_path.value}',
				f'output={output_path}'
			])

			# pdf_generation_counter.inc()

			return output_path
	except Exception as e:
		# Increment the failed PDF generation counter
		# pdf_generation_failure_counter.inc()
		return str(e), 400


@app.route('/v1/')
@metrics.do_not_track()
def info():
	today = time.strftime("%Y-%m-%d")
	url_map = app.url_map
	return f"<h1>mp-inkasso v1.0.0 - {today}</h1><pre>" + html.escape(str(url_map), False) + "</pre>"


@app.route('/v1/invoice', methods=['POST'])
@pdf_generation_counter
def generate_invoice():
	try:
		details_json = request.json
		template = Template.INVOICE
		pdf_content = generate_pdf(template, details_json)
		if pdf_content:
			# print(pdf_content)
			# return send_file(pdf_content, download_name="Rechnung.pdf", mimetype="application/pdf")
			return send_file(pdf_content, mimetype='application/pdf')
		else:
			return "PDF generation failed", 500
	except Exception as e:
		return str(e), 400


@app.route('/v1/shipping', methods=['POST'])
@pdf_generation_counter
def generate_shipping():
	try:
		details_json = request.json
		template = Template.INVOICE
		pdf_content = generate_pdf(template, details_json)
		if pdf_content:
			return send_file(pdf_content, mimetype='application/pdf')
		else:
			return "PDF generation failed", 500
	except Exception as e:
		return str(e), 400


@app.route('/v1/order-confirmation', methods=['POST'])
@pdf_generation_counter
def generate_order_confirmation():
	try:
		details_json: Details = request.json
		template = Template.ORDER_CONFIRMATION
		pdf_content = generate_pdf(template, details_json)
		if pdf_content:
			return send_file(pdf_content, mimetype='application/pdf')
		else:
			return "PDF generation failed", 500
	except Exception as e:
		return str(e), 400


@app.route('/v1/delete/pdf', methods=['DELETE'])
def delete_pdf():
	try:
		subprocess.run([
			'make',
			'-e',
			'clean'
		])
		return "Cleaned up PDF files in /app/data/output directory.", 204
	except Exception as e:
		return f"Failed to clean PDF files: {str(e)}", 500


@app.route('/v1/delete/all', methods=['DELETE'])
def delete_all():
	try:
		subprocess.run([
			'make',
			'-e',
			'cleanall'
		])
		return "Cleaned up ALL files in /app/data/output directory.", 204
	except Exception as e:
		return f"Failed to clean all files: {str(e)}", 500


@app.route('/health', methods=['GET'])
def health_check():
	# TODO: Add health check logic
	return jsonify({'status': 'ok'})


if __name__ == '__main__':
	app.run(host='0.0.0.0', port=1111, debug=False)
