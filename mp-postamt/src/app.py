from flask import Flask, request, jsonify
from prometheus_flask_exporter import PrometheusMetrics
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
import os
import time
import html

app = Flask(__name__)

# Wrap the Flask app with PrometheusMetrics
metrics = PrometheusMetrics(app, defaults_prefix="mp_postamt")

email_sent_counter = metrics.counter(
    'mp_postamt_email_sent_total',
    'Total number of emails sent'
)

pdf_sent_counter = metrics.counter(
    'mp_postamt_pdf_sent_total',
    'Total number of pdfs sent'
)

@app.route('/v1')
@metrics.do_not_track()
def info():
    today = time.strftime("%Y-%m-%d")
    url_map = app.url_map

    return f"<h1>mp-postamt v1.0.0 - {today}</h1>" \
           f"<pre>" + html.escape(str(url_map), False) + "</pre>"


@app.route('/v1/send/message', methods=['POST'])
@email_sent_counter
def send_message():
    data = request.json
    subject = data.get('subject')
    message = data.get('message')
    to_email = data.get('to_email')

    # SMTP Configuration
    smtp_server = os.environ.get('SMTP_RELAY_HOST')
    smtp_port = int(os.environ.get('SMTP_RELAY_PORT'))
    smtp_username = os.environ.get('SMTP_RELAY_USERNAME')
    smtp_password = os.environ.get('SMTP_RELAY_PASSWORD')

    try:
        smtp = smtplib.SMTP(smtp_server, smtp_port)
        smtp.starttls()
        smtp.login(smtp_username, smtp_password)

        msg = MIMEMultipart()
        msg['From'] = smtp_username
        msg['To'] = to_email
        msg['Subject'] = subject

        msg.attach(MIMEText(message, 'plain'))

        smtp.sendmail(smtp_username, to_email, msg.as_string())
        smtp.quit()

        return jsonify({"message": "Email sent successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/v1/send/pdf', methods=['POST'])
@pdf_sent_counter
def send_pdf():
    data = request.form  # Assuming form data is used to send the PDF blob
    subject = data.get('subject')
    message = data.get('message')
    to_email = data.get('to_email')
    pdf_blob = request.files.get('pdf_blob')  # assuming 'pdf_blob' is the name of the file input field

    # SMTP Configuration
    smtp_server = os.environ.get('SMTP_RELAY_HOST')
    smtp_port = int(os.environ.get('SMTP_RELAY_PORT'))
    smtp_username = os.environ.get('SMTP_RELAY_USERNAME')
    smtp_password = os.environ.get('SMTP_RELAY_PASSWORD')

    try:
        smtp = smtplib.SMTP(smtp_server, smtp_port)
        smtp.starttls()
        smtp.login(smtp_username, smtp_password)

        msg = MIMEMultipart()
        msg['From'] = smtp_username
        msg['To'] = to_email
        msg['Subject'] = subject

        # Attach text message
        msg.attach(MIMEText(message, 'plain'))

        # Attach PDF
        pdf_attachment = MIMEApplication(pdf_blob.read(), _subtype="pdf")
        pdf_attachment.add_header('Content-Disposition', 'attachment', filename='document.pdf')
        msg.attach(pdf_attachment)

        smtp.sendmail(smtp_username, to_email, msg.as_string())
        smtp.quit()

        return jsonify({"message": "Email sent successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=2222, debug=False)
