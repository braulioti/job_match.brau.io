"""
File Model
Model for storing file information using SQLAlchemy ORM.
"""

from sqlalchemy import Column, String, Integer, Text, ForeignKey
from sqlalchemy.orm import Session, relationship

from api.models.base_model import BaseModel
from api.migrations.database import SessionLocal


class File(BaseModel):
    """File model for storing file information."""

    __tablename__ = "file"

    user_id = Column(
        Integer,
        ForeignKey("user.id"),
        nullable=False,
        comment="Foreign key to user table",
    )
    original_file_name = Column(
        String(200),
        nullable=False,
        comment="Original name of the uploaded file",
    )
    hash = Column(
        String(40),
        nullable=False,
        unique=True,
        comment="Hash for generate file name",
    )
    checksum = Column(
        String(64),
        nullable=False,
        unique=True,
        comment="Checksum to validate if file already exists",
    )
    extension = Column(
        String(15),
        nullable=True,
        comment="File extension (e.g., .pdf, .docx)",
    )
    content = Column(
        Text,
        nullable=True,
        comment="Full text content converted to TXT",
    )

    # Relationship with User
    user = relationship("User", backref="files")

    def to_dict(self) -> dict:
        """Convert model to dictionary."""
        return {
            "id": self.id,
            "user_id": self.user_id,
            "original_file_name": self.original_file_name,
            "hash": self.hash,
            "checksum": self.checksum,
            "extension": self.extension,
            "content": self.content,
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
    def find_by_id(file_id: int):
        """Find file by ID."""
        db: Session = File._get_session()
        try:
            return db.query(File).filter_by(id=file_id).first()
        finally:
            db.close()

    @staticmethod
    def find_by_hash(hash_value: str):
        """Find file by hash."""
        db: Session = File._get_session()
        try:
            return db.query(File).filter_by(hash=hash_value).first()
        finally:
            db.close()

    @staticmethod
    def find_by_checksum(checksum_value: str):
        """Find file by checksum."""
        db: Session = File._get_session()
        try:
            return db.query(File).filter_by(checksum=checksum_value).first()
        finally:
            db.close()

    @staticmethod
    def find_by_user_id(user_id: int):
        """Find all files by user ID."""
        db: Session = File._get_session()
        try:
            return db.query(File).filter_by(user_id=user_id).all()
        finally:
            db.close()

    @staticmethod
    def find_by_user_id_and_checksum(user_id: int, checksum_value: str):
        """Find file by user ID and checksum."""
        db: Session = File._get_session()
        try:
            return db.query(File).filter_by(
                user_id=user_id, checksum=checksum_value
            ).first()
        finally:
            db.close()

    def __repr__(self) -> str:
        return f"<File(id={self.id}, original_file_name={self.original_file_name}, user_id={self.user_id})>"

