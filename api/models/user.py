"""
User Model
Model for storing user information using SQLAlchemy ORM.
"""

from datetime import datetime

from sqlalchemy import Column, String, DateTime
from sqlalchemy.orm import Session
from werkzeug.security import check_password_hash

from api.models.base_model import BaseModel
from api.migrations.database import SessionLocal


class User(BaseModel):
    """User model for storing user information."""

    __tablename__ = "user"

    email = Column(
        String(255),
        nullable=False,
        unique=True,
        comment="User email address",
    )
    password = Column(
        String(255),
        nullable=False,
        comment="Hashed password",
    )
    hash = Column(
        String(36),
        nullable=True,
        unique=True,
        comment="UUID v4 hash for authentication",
    )
    last_login = Column(
        DateTime,
        nullable=True,
        comment="Date and time of last login",
    )

    def check_password(self, password: str) -> bool:
        """Check if password is correct."""
        return check_password_hash(self.password, password)

    def update_last_login(self) -> None:
        """Update last login timestamp and persist to database."""
        self.last_login = datetime.utcnow()
        db: Session = SessionLocal()
        try:
            db.add(self)
            db.commit()
            db.refresh(self)
        finally:
            db.close()

    def to_dict(self) -> dict:
        """Convert model to dictionary."""
        return {
            "id": self.id,
            "email": self.email,
            "hash": self.hash,
            "last_login": self.last_login.isoformat() if self.last_login else None,
            "created_at": self.created_at.isoformat()
            if self.created_at
            else None,
            "updated_at": self.updated_at.isoformat()
            if self.updated_at
            else None,
        }

    @staticmethod
    def _get_session() -> Session:
        """Helper to obtain a new database session."""
        return SessionLocal()

    @staticmethod
    def find_by_email(email: str):
        """Find user by email."""
        db: Session = User._get_session()
        try:
            return db.query(User).filter_by(email=email).first()
        finally:
            db.close()

    @staticmethod
    def find_by_id(user_id: int):
        """Find user by ID."""
        db: Session = User._get_session()
        try:
            return db.query(User).filter_by(id=user_id).first()
        finally:
            db.close()

    @staticmethod
    def find_by_hash(hash_value: str):
        """Find user by hash."""
        db: Session = User._get_session()
        try:
            return db.query(User).filter_by(hash=hash_value).first()
        finally:
            db.close()

    def __repr__(self) -> str:
        return f"<User(id={self.id}, email={self.email})>"



