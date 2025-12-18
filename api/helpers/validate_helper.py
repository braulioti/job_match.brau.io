"""
Validation helper functions.

Centralizes common validation rules used across the API.
"""

import re
from typing import Any


def validate_email(email: Any) -> str:
    """
    Validate an email string and return the normalized value.

    :param email: Raw email value (any type, will be cast to str).
    :return: Trimmed email string if valid.
    :raises ValueError: If the email is missing or invalid.
    """
    raw_email = (str(email or "")).strip()

    if not raw_email:
        raise ValueError("Email is required.")

    # Basic email validation (simple regex, not exhaustive RFC)
    email_regex = r"^[^@\s]+@[^@\s]+\.[^@\s]+$"
    if not re.match(email_regex, raw_email):
        raise ValueError("Invalid email format.")

    return raw_email


def validate_password(password: Any) -> str:
    """
    Validate a password string with the following rules:
      - Minimum length of 8 characters
      - Must contain at least one letter
      - Must contain at least one digit
      - Must contain at least one special character

    :param password: Raw password value (any type, will be cast to str).
    :return: The original password string if valid.
    :raises ValueError: If the password does not meet the requirements.
    """
    raw_password = str(password or "")

    if len(raw_password) < 8:
        raise ValueError("Password must be at least 8 characters long.")

    if not re.search(r"[A-Za-z]", raw_password):
        raise ValueError("Password must contain at least one letter.")

    if not re.search(r"\d", raw_password):
        raise ValueError("Password must contain at least one number.")

    # Common special characters; adjust as needed for your rules
    if not re.search(r"[!@#$%^&*(),.?\":{}|<>_\-+=;'/\\\[\]]", raw_password):
        raise ValueError("Password must contain at least one special character.")

    return raw_password

