import html
import time
from enum import Enum
from flask import Flask, request, send_file, jsonify
from prometheus_flask_exporter import PrometheusMetrics
import subprocess
import tempfile
import os
import re
import json
import yaml
from typing import List, NamedTuple
import logging
from datetime import datetime

#
# # Robust Logging Setup
# class RobustFormatter(logging.Formatter):
# 	def __init__(self, prefix='makefile-pandoc'):
# 		super().__init__(
# 			fmt=f'[%(asctime)s.%(msecs)03d] {prefix}:%(levelname).1s: %(message)s',
# 			datefmt='%Y-%m-%d %H:%M:%S'
# 		)
# 		self.prefix = prefix
#
# 	def formatTime(self, record, datefmt=None):
# 		try:
# 			ct = datetime.fromtimestamp(record.created)
# 			if datefmt:
# 				s = ct.strftime(datefmt)
# 			else:
# 				s = ct.strftime("%Y-%m-%d %H:%M:%S")
# 			return s
# 		except Exception as e:
# 			return f"<Error formatting time: {str(e)}>"
#
# 	def format(self, record):
# 		try:
# 			s = super().format(record)
# 			return s.replace(f"{self.prefix}:I:", f"{self.prefix}:i:")  # Convert 'I' to 'i' for info level
# 		except Exception as e:
# 			return f"<Error formatting log: {str(e)}>"
#
#
# class RequestFormatter(logging.Formatter):
# 	def __init__(self):
# 		super().__init__(fmt='[%(asctime)s.%(msecs)03d] makefile-pandoc:%(levelname).1s: %(message)s',
# 						 datefmt='%Y-%m-%d %H:%M:%S')
#
# 	def format(self, record):
# 		s = super().format(record)
# 		s = s.replace("makefile-pandoc:I:", "makefile-pandoc:i:")
# 		if "GET" in s or "POST" in s or "DELETE" in s or "HEAD" in s:
# 			s = s.replace("makefile-pandoc:", "flask:")
# 		return s
#
#
# def setup_logging(level=logging.INFO):
# 	root_logger = logging.getLogger()
# 	root_logger.setLevel(level)
#
# 	# Remove any existing handlers
# 	for handler in root_logger.handlers[:]:
# 		root_logger.removeHandler(handler)
#
# 	# Handler for our custom logs
# 	custom_handler = logging.StreamHandler()
# 	custom_handler.setFormatter(RobustFormatter())
# 	root_logger.addHandler(custom_handler)
#
# 	# Handler for Flask logs
# 	flask_handler = logging.StreamHandler()
# 	flask_handler.setFormatter(RequestFormatter())
# 	flask_logger = logging.getLogger('werkzeug')
# 	flask_logger.handlers = []
# 	flask_logger.addHandler(flask_handler)
# 	flask_logger.setLevel(logging.INFO)
#
# 	return root_logger
#
#
# # Setup logger
# logger = setup_logging()
#
# app = Flask(__name__, static_folder=None)
#
# metrics = PrometheusMetrics(app, defaults_prefix="mp_inkasso")

class FilterRemoveDate(logging.Filter):
    # '192.168.0.102 - - [30/Jun/2024 01:14:03] "%s" %s %s' -> '192.168.0.102 - "%s" %s %s'
    pattern: re.Pattern = re.compile(r' - \[.+?]')

    def filter(self, record: logging.LogRecord) -> bool:
        record.msg = self.pattern.sub('', record.msg)
        return True

class FilterReplaceWerkzeug(logging.Filter):
    # 'werkzeug:' -> 'app:flask:'
    pattern: re.Pattern = re.compile(r'werkzeug:')

    def filter(self, record: logging.LogRecord) -> bool:
        record.msg = self.pattern.sub('app:flask:', record.msg)
        return True

class FilterReplaceLowercaseI(logging.Filter):
    # 'I:' -> 'i:'
    pattern: re.Pattern = re.compile(r'I:')

    def filter(self, record: logging.LogRecord) -> bool:
        record.msg = self.pattern.sub('i:', record.msg)
        return True

# Setup logger
logging.basicConfig(
	level=logging.DEBUG,
	format='%(asctime)s.%(msecs)03dZ %(name)s:%(levelname).1s: %(message)s',
	datefmt='%Y-%m-%d %H:%M:%S'
)

logger = logging.getLogger('app')
logger_werkzeug = logging.getLogger('werkzeug')
logger_werkzeug.addFilter(FilterRemoveDate())
logger_werkzeug.addFilter(FilterReplaceWerkzeug())
logger_werkzeug.addFilter(FilterReplaceLowercaseI())

app = Flask(__name__, static_folder=None)

metrics = PrometheusMetrics(app, defaults_prefix="mp_inkasso")

# Define a counter for successful pdf generation
pdf_generation_counter = metrics.counter(
	'mp_inkasso_pdf_generation_total',
	'Total number of pdfs generated',
	labels={'endpoint': lambda: request.endpoint}
)


class Template(Enum):
	INVOICE = "/app/data/templates/invoice-scrlttr2.tex"
	INVOICE_EXAMPLE = "/app/data/templates/invoice-scrlttr2.example.tex"
	SHIPPING = "/app/data/templates/shipping-note-scrlttr2.tex"
	ORDER_CONFIRMATION = "/app/data/templates/order-confirmation.tex"
	LETTERHEAD = "/app/data/templates/RE.pdf"
	DETAILS = ""

template_to_label = {
    Template.INVOICE: "invoice",
    Template.SHIPPING: "shipping",
    Template.ORDER_CONFIRMATION: "order_confirmation"
}

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
		logger = logging.getLogger('app:generate-pdf')
		logger.info("Generating pdf")
		logger.debug(details_json)
		details_dict = json.loads(json.dumps(details_json))
		details_yaml = yaml.dump(details_dict)
		date = time.strftime("%Y%m%d")
		label = template_to_label[template_path]

		with tempfile.TemporaryDirectory() as temp_dir:
			# Write the details JSON to a YAML file
			details_yaml_path = os.path.join(temp_dir, 'details.md')

			with open(details_yaml_path, 'w') as yaml_file:
				yaml_file.write("---\n")
				yaml_file.write("letterhead: /app/data/templates/RE.pdf\n")
				yaml_file.write(details_yaml)
				yaml_file.write("...\n")
				yaml_file.write(details_dict["body"])

			normalized_recipient = normalize(details_dict["to"]["name"] or details_dict["to"]["address"][0])
			output_base_path = os.path.join("/", "app", "data", "output", f'{date}-{label}-{normalized_recipient}')

			logger.debug(normalized_recipient)

			counter = 0
			if os.path.exists(output_base_path + '.pdf'):
				counter = 1
				while os.path.exists(f'{output_base_path}-{counter}.pdf'):
					counter += 1
				output_path = f'{output_base_path}-{counter}.pdf'
			else:
				output_path = output_base_path + '.pdf'

			logger.debug(f"Starting Pandoc")
			logger.debug(f"Source YAML: {details_yaml_path}")
			logger.debug(f"Template: {template_path.value}")
			logger.debug(f"Output pdf: {output_path}")

			result = subprocess.run([
				'make',
				'-e',
				'-B',
				f'src={details_yaml_path}',
				f'template={template_path.value}',
				f'output={output_path}'
			])

			if result.returncode != 0:
				logger.error(f"Pdf generation failed: {result.stderr}")
				return None

			logger.info("Pdf generated successfully")
			return output_path

	except Exception as e:
		logger.error(f"Error generating pdf: {str(e)}")
		return None


@app.route('/v1/')
@metrics.do_not_track()
def info():
	today = time.strftime("%Y-%m-%d")
	url_map = app.url_map
	return f"<h1>mp-inkasso v1.0.0 - {today}</h1><pre>" + html.escape(str(url_map), False) + "</pre>"


@app.route('/v1/invoice', methods=['POST'])
@pdf_generation_counter
def generate_invoice():
	logger = logging.getLogger('app:generate-invoice')
	try:
		details_json = request.json
		logger.debug("Generating invoice")
		logger.debug(details_json)
		template = Template.INVOICE
		pdf_content = generate_pdf(template, details_json)
		if pdf_content:
			logger.info(f"Sending invoice pdf: {pdf_content}")
			return send_file(pdf_content, mimetype='application/pdf')
		else:
			logger.error("Sending pdf failed")
			return jsonify({"status": "failed"}), 500
	except Exception as e:
		logger.error(f"Error in generate_invoice: {str(e)}")
		return jsonify({"status": "failed"}), 500


@app.route('/v1/shipping', methods=['POST'])
@pdf_generation_counter
def generate_shipping():
	logger = logging.getLogger('app:generate-shipping-note')
	try:
		details_json = request.json
		logger.debug("Generating shipping note")
		logger.debug(details_json)
		template = Template.SHIPPING
		pdf_content = generate_pdf(template, details_json)
		logger.info(pdf_content)
		if pdf_content:
			logger.info(f"Sending shipping pdf: {pdf_content}")
			return send_file(pdf_content, mimetype='application/pdf')
		else:
			logger.error("Sending pdf failed, generated pdf is empty")
			return jsonify({"status": "failed"}), 500
	except Exception as e:
		logger.error(f"Error in generate_shipping: {str(e)}")
		return jsonify({"status": "failed"}), 500


@app.route('/v1/order-confirmation', methods=['POST'])
@pdf_generation_counter
def generate_order_confirmation():
	logger = logging.getLogger('app:generate-order-confirmation')
	try:
		details_json = request.json
		template = Template.ORDER_CONFIRMATION
		pdf_content = generate_pdf(template, details_json)
		if pdf_content:
			logger.info(f"Sending order confirmation pdf: {pdf_content}")
			return send_file(pdf_content, mimetype='application/pdf')
		else:
			logger.error("pdf generation failed")
			return "pdf generation failed", 500
	except Exception as e:
		logger.error(f"Error in generate_order_confirmation: {str(e)}")
		return str(e), 400


@app.route('/v1/delete/pdf', methods=['DELETE'])
def delete_pdf():
	logger = logging.getLogger('app:delete-pdf')
	try:
		subprocess.run([
			'make',
			'-e',
			'clean'
		])
		logger.info("Cleaned up pdf files in /app/data/output directory.")
		return jsonify({"status": "success"}), 204
	except Exception as e:
		logger.error(f"Failed to clean pdf files: {str(e)}")
		return jsonify({"status": "failed"}), 500


@app.route('/v1/delete/all', methods=['DELETE'])
def delete_all():
	logger = logging.getLogger('app:delete-all-pdf')
	try:
		subprocess.run([
			'make',
			'-e',
			'cleanall'
		])
		logger.info("Cleaned up ALL files in /app/data/output directory.")
		return jsonify({"status": "success"}), 204
	except Exception as e:
		logger.error(f"Failed to clean all files: {str(e)}")
		return jsonify({"status": "failed"}), 500


@app.route('/health', methods=['GET'])
def health_check():
	# TODO: Add health check logic
	logger.debug("Health check performed")
	return jsonify({'status': 'ok'})


if __name__ == '__main__':
	app.run(host='0.0.0.0', port=1111, debug=False)
