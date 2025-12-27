"""
Base Model
Base SQLAlchemy model with common fields for all models in the API.
"""

from datetime import datetime

from sqlalchemy import Column, Integer, DateTime

from api.migrations.database import Base, get_db


class BaseModel(Base):
    """Base model with common fields and database helper.

    - Inherits from the shared SQLAlchemy `Base`
    - Provides common audit fields (`id`, `created_at`, `updated_at`)
    - Exposes the database helper `bd`, which points to `get_db`
    """

    __abstract__ = True  # SQLAlchemy should not create a table for this class

    id = Column(Integer, primary_key=True, index=True)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(
        DateTime,
        default=datetime.utcnow,
        onupdate=datetime.utcnow,
        nullable=False,
    )
    bd = staticmethod(get_db)

    def to_dict(self):
        """Convert model instance to dictionary."""
        return {
            column.name: getattr(self, column.name)
            for column in self.__table__.columns
        }

    def __repr__(self):
        return f"<{self.__class__.__name__}(id={self.id})>"

