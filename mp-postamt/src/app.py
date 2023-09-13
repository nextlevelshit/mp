from flask import Flask, request, jsonify
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
import os
import time
import html

app = Flask(__name__)


@app.route('/v1')
def info():
    today = time.strftime("%Y-%m-%d")
    url_map = app.url_map

    return f"<h1>mp-postamt v1.0.0 - {today}</h1>" \
           f"<pre>" + html.escape(str(url_map), False) + "</pre>"


@app.route('/v1/send/message', methods=['POST'])
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


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=2222)
