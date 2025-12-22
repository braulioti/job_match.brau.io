"""
ResponseUserLoginDTO
DTO for returning authorization data.
"""

from typing import Dict, Any

from api.models.user import User


class ResponseUserLoginDTO:
    """
    Data Transfer Object for user authorization.

    The constructor receives Bearer token and user data from a User model instance.
    """

    token: str
    hash: str
    validated: bool

    def __init__(self, token: str, user: User) -> None:
        """
        Initialize DTO from a generated token and userdata from a User model instance.
        """
        self.token = token
        self.hash = user.hash
        self.validated = user.validated

    def to_dict(self) -> Dict[str, Any]:
        """
        Convert DTO data to a serializable dictionary.
        """
        return {
            "token": self.token,
            "hash": self.hash,
            "validated": self.validated
        }

