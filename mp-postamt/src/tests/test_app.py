import unittest
from flask import Flask
from flask.testing import FlaskClient
from unittest.mock import patch, MagicMock
from app import app

class TestApp(unittest.TestCase):
    def setUp(self):
        app.testing = True
        self.app = app.test_client()

    def test_info_endpoint(self):
        response = self.app.get('/v1')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"mp-postamt v1.0.0", response.data)

    @patch('smtplib.SMTP')
    def test_send_message_endpoint_success(self, mock_smtp):
        mock_smtp_instance = MagicMock()
        mock_smtp.return_value = mock_smtp_instance

        with app.app_context():
            response = self.app.post('/v1/send/message', json={
                'subject': 'Test Subject',
                'message': 'Test Message',
                'to_email': 'test@example.com'
            })

        self.assertEqual(response.status_code, 200)
        mock_smtp_instance.starttls.assert_called_once()
        mock_smtp_instance.login.assert_called_once()
        mock_smtp_instance.sendmail.assert_called_once()
        mock_smtp_instance.quit.assert_called_once()

    @patch('smtplib.SMTP')
    def test_send_message_endpoint_failure(self, mock_smtp):
        mock_smtp_instance = MagicMock()
        mock_smtp_instance.login.side_effect = smtplib.SMTPAuthenticationError("Authentication failed")
        mock_smtp.return_value = mock_smtp_instance

        with app.app_context():
            response = self.app.post('/v1/send/message', json={
                'subject': 'Test Subject',
                'message': 'Test Message',
                'to_email': 'test@example.com'
            })

        self.assertEqual(response.status_code, 500)
        mock_smtp_instance.starttls.assert_called_once()
        mock_smtp_instance.login.assert_called_once()
        mock_smtp_instance.sendmail.assert_not_called()
        mock_smtp_instance.quit.assert_called_once()

    @patch('smtplib.SMTP')
    def test_send_pdf_endpoint_success(self, mock_smtp):
        mock_smtp_instance = MagicMock()
        mock_smtp.return_value = mock_smtp_instance

        with app.app_context():
            response = self.app.post('/v1/send/pdf', data={
                'subject': 'Test Subject',
                'message': 'Test Message',
                'to_email': 'test@example.com',
            }, content_type='multipart/form-data', files={'pdf_blob': ('document.pdf', b'PDF_CONTENT')})

        self.assertEqual(response.status_code, 200)
        mock_smtp_instance.starttls.assert_called_once()
        mock_smtp_instance.login.assert_called_once()
        mock_smtp_instance.sendmail.assert_called_once()
        mock_smtp_instance.quit.assert_called_once()

    @patch('smtplib.SMTP')
    def test_send_pdf_endpoint_failure(self, mock_smtp):
        mock_smtp_instance = MagicMock()
        mock_smtp_instance.login.side_effect = smtplib.SMTPAuthenticationError("Authentication failed")
        mock_smtp.return_value = mock_smtp_instance

        with app.app_context():
            response = self.app.post('/v1/send/pdf', data={
                'subject': 'Test Subject',
                'message': 'Test Message',
                'to_email': 'test@example.com',
            }, content_type='multipart/form-data', files={'pdf_blob': ('document.pdf', b'PDF_CONTENT')})

        self.assertEqual(response.status_code, 500)
        mock_smtp_instance.starttls.assert_called_once()
        mock_smtp_instance.login.assert_called_once()
        mock_smtp_instance.sendmail.assert_not_called()
        mock_smtp_instance.quit.assert_called_once()

if __name__ == '__main__':
    unittest.main()
