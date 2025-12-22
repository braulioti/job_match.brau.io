"""
ResponseUserDTO
DTO for returning user data in API responses.
"""

from typing import Dict, Any

from api.models.user import User


class ResponseUserDTO:
    """
    Data Transfer Object for user creation.

    The constructor receives a raw data dict and performs validation.
    """

    id: int
    email: str
    hash: str
    hash_validated: str
    created_at: str | None = None

    def __init__(self, user: User) -> None:
        """
        Initialize DTO from a User model instance.
        """
        self.id = user.id
        self.email = user.email
        self.hash = user.hash
        self.created_at = (
            user.created_at.isoformat() if getattr(user, "created_at", None) else None
        )
        self.hash_validated = user.hash_validated

    def to_dict(self) -> Dict[str, Any]:
        """
        Convert DTO data to a serializable dictionary.
        """
        return {
            "id": self.id,
            "createdAt": self.created_at if self.created_at else None,
            "email": self.email,
            "hash": self.hash,
            "hashValidated": self.hash_validated
        }

