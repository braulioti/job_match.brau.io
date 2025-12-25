"""
User service
Business logic and database operations related to users.
"""

from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from werkzeug.security import generate_password_hash
import jwt

from api.config import JWT_SECRET_KEY, JWT_ALGORITHM, JWT_EXPIRATION_HOURS
from api.dtos.create_user_dto import CreateUserDTO
from api.dtos.login_user_dto import LoginUserDTO
from api.dtos.response_user_dto import ResponseUserDTO
from api.dtos.response_user_login_dto import ResponseUserLoginDTO
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

    @staticmethod
    def _update_last_login(user: User, db: Session) -> None:
        """
        Update user's last_login timestamp.

        :param user: User instance to update
        :param db: Database session
        """
        user.last_login = datetime.utcnow()
        db.commit()
        db.refresh(user)

    @staticmethod
    def _generate_jwt_payload(user: User) -> dict:
        """
        Generate JWT payload for user.

        :param user: User instance
        :return: JWT payload dictionary
        """
        return {
            "user_id": user.id,
            "email": user.email,
            "exp": datetime.utcnow() + timedelta(hours=JWT_EXPIRATION_HOURS),
            "iat": datetime.utcnow()
        }

    @staticmethod
    def _generate_jwt_token(user: User) -> str:
        """
        Generate JWT token for user.

        :param user: User instance
        :return: JWT token string
        """
        payload = UserService._generate_jwt_payload(user)
        token = jwt.encode(payload, JWT_SECRET_KEY, algorithm=JWT_ALGORITHM)
        # Ensure token is a string (PyJWT returns string in version 2.x)
        if isinstance(token, bytes):
            token = token.decode('utf-8')
        return token

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
            user = User(
                email=dto.email,
                password=hashed_password,
                hash=dto.hash,
                hash_validated=dto.hash_validated
            )
            db.add(user)
            db.commit()
            db.refresh(user)
            return user
        finally:
            db.close()

    def login(self, dto: LoginUserDTO) -> ResponseUserLoginDTO:
        """
        Authenticate user and generate JWT token.

        - Validates email and password
        - Updates last_login timestamp
        - Generates JWT token
        - Returns ResponseUserLoginDTO with token, hash and validated status

        :raises ValueError: if email or password is invalid
        """
        db: Session = self._get_session()
        try:
            # Find user by email
            user = db.query(User).filter_by(email=dto.email).first()
            if not user:
                raise ValueError("Invalid email or password.")

            # Validate password
            if not user.check_password(dto.password):
                raise ValueError("Invalid email or password.")

            # Update last_login
            self._update_last_login(user, db)

            # Generate JWT token
            token = self._generate_jwt_token(user)

            # Return response DTO
            return ResponseUserLoginDTO(token=token, user=user)
        finally:
            db.close()

    def validate_login(self, hash_validated: str) -> ResponseUserDTO:
        """
        Validate user login by hash_validated.

        - Finds user by hash_validated
        - Updates validated field to True
        - Returns ResponseUserDTO with user data

        :param hash_validated: Hash validation string (UUID v4)
        :raises ValueError: if user with hash_validated is not found
        """
        db: Session = self._get_session()
        try:
            # Find user by hash_validated
            user = db.query(User).filter_by(hash_validated=hash_validated).first()
            if not user:
                raise ValueError("Invalid validation hash.")

            # Update validated status
            user.validated = True
            db.commit()
            db.refresh(user)

            # Return response DTO
            return ResponseUserDTO(user)
        finally:
            db.close()

    def hash_login(self, hash_value: str) -> ResponseUserLoginDTO:
        """
        Authenticate user by hash and generate JWT token.

        - Finds user by hash
        - Updates last_login timestamp
        - Generates JWT token
        - Returns ResponseUserLoginDTO with token, hash and validated status

        :param hash_value: Hash string (UUID v4) for authentication
        :raises ValueError: if hash is invalid or user not found
        """
        db: Session = self._get_session()
        try:
            # Find user by hash
            user = db.query(User).filter_by(hash=hash_value).first()
            if not user:
                raise ValueError("Invalid hash.")

            # Update last_login
            self._update_last_login(user, db)

            # Generate JWT token
            token = self._generate_jwt_token(user)

            # Return response DTO
            return ResponseUserLoginDTO(token=token, user=user)
        finally:
            db.close()


# Instância única do serviço para ser usada nos controllers
user_service = UserService()

