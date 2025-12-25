"""
EmailMessageDTO
DTO for email message data.
"""

from typing import List, Optional


class EmailMessageDTO:
    """
    Data Transfer Object for email message data.
    
    Contains all information needed to build and send an email message.
    """

    to: str | List[str]
    subject: str
    body: str
    html_body: Optional[str]
    cc: Optional[str | List[str]]
    bcc: Optional[str | List[str]]
    attachments: Optional[List[str]]

    def __init__(
        self,
        to: str | List[str],
        subject: str,
        body: str,
        html_body: Optional[str] = None,
        cc: Optional[str | List[str]] = None,
        bcc: Optional[str | List[str]] = None,
        attachments: Optional[List[str]] = None
    ) -> None:
        """
        Initialize EmailMessageDTO with email data.

        :param to: Recipient email address(es) - string or list of strings
        :param subject: Email subject
        :param body: Plain text email body
        :param html_body: Optional HTML email body
        :param cc: Optional CC recipient(s) - string or list of strings
        :param bcc: Optional BCC recipient(s) - string or list of strings
        :param attachments: Optional list of file paths to attach
        """
        self.to = to
        self.subject = subject
        self.body = body
        self.html_body = html_body
        self.cc = cc
        self.bcc = bcc
        self.attachments = attachments

