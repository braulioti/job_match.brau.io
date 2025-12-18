"""
User service
Business logic and database operations related to users.
"""

from sqlalchemy.orm import Session
from werkzeug.security import generate_password_hash

from api.dtos.create_user_dto import CreateUserDTO
from api.migrations.database import SessionLocal
from api.models.user import User

class UserService:
    """
    Service responsável pelas operações de usuário.
    """

    @staticmethod
    def _get_session() -> Session:
        """Internal helper to obtain a new database session."""
        return SessionLocal()

    def create_user(self, dto: CreateUserDTO) -> User:
        """
        Create a new user with a hashed password.

        - First checks if the email already exists in the database.
          If it does, raises a ValueError.
        """
        db: Session = self._get_session()
        try:
            # Check if email already exists
            existing = db.query(User).filter_by(email=dto.email).first()
            if existing:
                raise ValueError("User with this email already exists.")

            hashed_password = generate_password_hash(dto.password)
            user = User(email=dto.email, password=hashed_password, hash=dto.hash)
            db.add(user)
            db.commit()
            db.refresh(user)
            return user
        finally:
            db.close()


# Instância única do serviço para ser usada nos controllers
user_service = UserService()

