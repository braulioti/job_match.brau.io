"""
CreateUserDTO
DTO for creating a new user.
"""

from typing import Dict, Any
from uuid import uuid4

from api.helpers.validate_helper import validate_email, validate_password


class CreateUserDTO:
    """
    Data Transfer Object for user creation.

    The constructor receives a raw data dict and performs validation.
    """

    email: str
    password: str
    hash: str
    hash_validated: str

    def __init__(self, data: Dict[str, Any]) -> None:
        """
        Initialize and validate DTO fields from raw data.

        :param data: Raw data dictionary (e.g., from request JSON).
        :raises ValueError: if any required field is missing or invalid.
        """
        # Validate and normalize email & password using shared helpers
        self.email = validate_email(data.get("email"))
        self.password = validate_password(data.get("password"))

        # Generate UUID v4 hash for the new user
        self.hash = str(uuid4())
        self.hash_validated = str(uuid4())


