"""
Email Helper for sending emails via SMTP (any email provider)
"""
import smtplib
import ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email import encoders
from typing import List, Optional
import os

from api.dtos.email_message_dto import EmailMessageDTO


class EmailHelper:
    """
    Helper class for sending emails via SMTP (Gmail or other providers)
    
    Usage:
        helper = EmailHelper()
        helper.send_email(
            to="recipient@example.com",
            subject="Test Email",
            body="This is a test email"
        )
    """
    
    # Default SMTP Configuration
    SMTP_SERVER = "smtp.gmail.com"
    SMTP_PORT = 587
    
    def __init__(
        self,
        sender_email: Optional[str] = None,
        sender_password: Optional[str] = None,
        smtp_server: Optional[str] = None,
        smtp_port: Optional[int] = None
    ):
        """
        Initialize EmailHelper
        
        Args:
            sender_email: Email address (defaults to SMTP_USER from config or env)
            sender_password: Email password (defaults to SMTP_PASSWORD from config or env)
            smtp_server: SMTP server address (defaults to SMTP_HOST from config or env)
            smtp_port: SMTP server port (defaults to SMTP_PORT from config or env)
        """
        self.sender_email = self._resolve_sender_email(sender_email)
        self.sender_password = self._resolve_sender_password(sender_password)
        self.SMTP_SERVER = self._resolve_smtp_server(smtp_server)
        self.SMTP_PORT = self._resolve_smtp_port(smtp_port)
        
        self._validate_required_fields()
    
    @staticmethod
    def _resolve_sender_email(provided_email: Optional[str]) -> Optional[str]:
        """Resolve sender email from provided value, config, or environment."""
        if provided_email:
            return provided_email
        from api.config import SMTP_USER
        return SMTP_USER or os.getenv('SMTP_USER')
    
    @staticmethod
    def _resolve_sender_password(provided_password: Optional[str]) -> Optional[str]:
        """Resolve sender password from provided value, config, or environment."""
        if provided_password:
            return provided_password
        from api.config import SMTP_PASSWORD
        return SMTP_PASSWORD or os.getenv('SMTP_PASSWORD')
    
    @staticmethod
    def _resolve_smtp_server(provided_server: Optional[str]) -> str:
        """Resolve SMTP server from provided value, config, environment, or default."""
        if provided_server:
            return provided_server
        from api.config import SMTP_HOST
        return SMTP_HOST or os.getenv('SMTP_HOST') or 'smtp.gmail.com'
    
    @staticmethod
    def _resolve_smtp_port(provided_port: Optional[int]) -> int:
        """Resolve SMTP port from provided value, config, environment, or default."""
        if provided_port:
            return provided_port
        from api.config import SMTP_PORT
        return SMTP_PORT or int(os.getenv('SMTP_PORT', '587'))
    
    def _validate_required_fields(self) -> None:
        """Validate that required fields are set."""
        if not self.sender_email:
            raise ValueError("Email sender address is required. Set SMTP_USER in config.py or environment variable.")
        
        if not self.sender_password:
            raise ValueError("Email password is required. Set SMTP_PASSWORD in config.py or environment variable.")
    
    def _build_message(
        self,
        dto: EmailMessageDTO
    ) -> tuple[MIMEMultipart, List[str]]:
        """
        Build email message with recipients, body, and attachments.
        
        Args:
            dto: EmailMessageDTO containing all email message data
            
        Returns:
            tuple: (MIMEMultipart message, List of recipient email addresses)
        """
        # Create message
        if dto.html_body:
            message = MIMEMultipart("alternative")
        else:
            message = MIMEMultipart()
        
        message["From"] = self.sender_email
        message["Subject"] = dto.subject
        
        # Handle recipients
        to = dto.to
        if isinstance(to, str):
            to = [to]
        message["To"] = ", ".join(to)
        
        cc = dto.cc
        if cc:
            if isinstance(cc, str):
                cc = [cc]
            message["Cc"] = ", ".join(cc)
        
        # Add all recipients for SMTP
        recipients = to.copy()
        if cc:
            recipients.extend(cc)
        bcc = dto.bcc
        if bcc:
            if isinstance(bcc, str):
                bcc = [bcc]
            recipients.extend(bcc)
        
        # Add body
        if dto.html_body:
            # Create plain text and HTML parts
            text_part = MIMEText(dto.body, "plain")
            html_part = MIMEText(dto.html_body, "html")
            message.attach(text_part)
            message.attach(html_part)
        else:
            text_part = MIMEText(dto.body, "plain")
            message.attach(text_part)
        
        # Add attachments
        if dto.attachments:
            for file_path in dto.attachments:
                if os.path.exists(file_path):
                    with open(file_path, "rb") as attachment:
                        part = MIMEBase("application", "octet-stream")
                        part.set_payload(attachment.read())
                    
                    encoders.encode_base64(part)
                    filename = os.path.basename(file_path)
                    part.add_header(
                        "Content-Disposition",
                        f"attachment; filename= {filename}",
                    )
                    message.attach(part)
        
        return message, recipients
    
    def send_email(
        self,
        to: str | List[str],
        subject: str,
        body: str,
        html_body: Optional[str] = None,
        cc: Optional[str | List[str]] = None,
        bcc: Optional[str | List[str]] = None,
        attachments: Optional[List[str]] = None
    ) -> bool:
        """
        Send an email via SMTP
        
        Args:
            to: Recipient email address(es) - string or list of strings
            subject: Email subject
            body: Plain text email body
            html_body: Optional HTML email body (if provided, email will be multipart)
            cc: Optional CC recipient(s) - string or list of strings
            bcc: Optional BCC recipient(s) - string or list of strings
            attachments: Optional list of file paths to attach
            
        Returns:
            bool: True if email was sent successfully, False otherwise
            
        Raises:
            Exception: If email sending fails
        """
        try:
            dto = EmailMessageDTO(
                to=to,
                subject=subject,
                body=body,
                html_body=html_body,
                cc=cc,
                bcc=bcc,
                attachments=attachments
            )
            message, recipients = self._build_message(dto)
            
            # Create secure connection and send email
            # Port 465 uses SSL directly, port 587 uses STARTTLS
            context = ssl.create_default_context()
            # Some SMTP servers may require check_hostname=False
            context.check_hostname = False
            context.verify_mode = ssl.CERT_NONE
            
            # Set timeout to avoid hanging
            timeout = 30
            
            if self.SMTP_PORT == 465:
                # Use SMTP_SSL for port 465 (SSL)
                server = smtplib.SMTP_SSL(self.SMTP_SERVER, self.SMTP_PORT, context=context, timeout=timeout)
                try:
                    server.login(self.sender_email, self.sender_password)
                    # Use send_message for better error handling
                    failed_recipients = server.send_message(message, from_addr=self.sender_email, to_addrs=recipients)
                    if failed_recipients:
                        raise Exception(f"Failed to send email to: {failed_recipients}")
                finally:
                    server.quit()
            else:
                # Use SMTP with STARTTLS for port 587 (TLS)
                server = smtplib.SMTP(self.SMTP_SERVER, self.SMTP_PORT, timeout=timeout)
                try:
                    server.starttls(context=context)
                    server.login(self.sender_email, self.sender_password)
                    # Use send_message for better error handling
                    failed_recipients = server.send_message(message, from_addr=self.sender_email, to_addrs=recipients)
                    if failed_recipients:
                        raise Exception(f"Failed to send email to: {failed_recipients}")
                finally:
                    server.quit()
            
            return True
            
        except smtplib.SMTPException as e:
            raise Exception(f"SMTP error occurred: {str(e)}")
        except Exception as e:
            raise Exception(f"Failed to send email: {str(e)}")
    
    def send_html_email(
        self,
        to: str | List[str],
        subject: str,
        html_content: str,
        plain_text_fallback: Optional[str] = None,
        cc: Optional[str | List[str]] = None,
        bcc: Optional[str | List[str]] = None,
        attachments: Optional[List[str]] = None
    ) -> bool:
        """
        Send an HTML email with optional plain text fallback
        
        Args:
            to: Recipient email address(es)
            subject: Email subject
            html_content: HTML email content
            plain_text_fallback: Optional plain text version
            cc: Optional CC recipient(s)
            bcc: Optional BCC recipient(s)
            attachments: Optional list of file paths to attach
            
        Returns:
            bool: True if email was sent successfully
        """
        return self.send_email(
            to=to,
            subject=subject,
            body=plain_text_fallback or "Please view this email in an HTML-compatible email client.",
            html_body=html_content,
            cc=cc,
            bcc=bcc,
            attachments=attachments
        )


# Convenience function for quick email sending
def send_email(
    to: str | List[str],
    subject: str,
    body: str,
    html_body: Optional[str] = None,
    **kwargs
) -> bool:
    """
    Convenience function to send email quickly
    
    Usage:
        send_email(
            to="user@example.com",
            subject="Welcome",
            body="Welcome to Job Match!"
        )
    """
    helper = EmailHelper()
    return helper.send_email(to=to, subject=subject, body=body, html_body=html_body, **kwargs)

