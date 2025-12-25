from flask import request, jsonify

from api.dtos.create_user_dto import CreateUserDTO
from api.dtos.login_user_dto import LoginUserDTO
from api.dtos.response_user_dto import ResponseUserDTO
from api.services.user_service import UserService


class UserController:
    """
    Controller responsável por operações relacionadas ao usuário.
    """

    service: UserService

    def __init__(self) -> None:
        self.service = UserService()

    def create_user(self):
        """
        Handle user creation.

        Expects a JSON body with:
          - email: str
          - password: str
        """
        data = request.get_json(silent=True) or {}

        try:
            dto = CreateUserDTO(data)
            user = self.service.create_user(dto)
            return jsonify(ResponseUserDTO(user).to_dict()), 201
        except ValueError as e:
            return jsonify({"error": str(e)}), 400
        except Exception as e:
            return (
                jsonify(
                    {"error": "Internal server error", "message": str(e)}
                ),
                500,
            )

    def login(self):
        """
        Handle user login and authentication.

        Expects a JSON body with:
          - email: str
          - password: str

        Returns JWT token, user hash and validated status.
        """
        data = request.get_json(silent=True) or {}

        try:
            dto = LoginUserDTO(data)
            response = self.service.login(dto)
            return jsonify(response.to_dict()), 200
        except ValueError as e:
            return jsonify({"error": str(e)}), 401
        except Exception as e:
            return (
                jsonify(
                    {"error": "Internal server error", "message": str(e)}
                ),
                500,
            )

    def validate_login(self, hash_validated: str):
        """
        Handle user login validation.

        Receives hash_validated as path parameter.

        Returns ResponseUserDTO with validated user data.
        """
        try:
            response = self.service.validate_login(hash_validated)
            return jsonify(response.to_dict()), 200
        except ValueError as e:
            return jsonify({"error": str(e)}), 404
        except Exception as e:
            return (
                jsonify(
                    {"error": "Internal server error", "message": str(e)}
                ),
                500,
            )

    def hash_login(self, hash_value: str):
        """
        Handle user login using hash.

        Receives hash as path parameter.

        Returns JWT token, user hash and validated status.
        """
        try:
            response = self.service.hash_login(hash_value)
            return jsonify(response.to_dict()), 200
        except ValueError as e:
            return jsonify({"error": str(e)}), 401
        except Exception as e:
            return (
                jsonify(
                    {"error": "Internal server error", "message": str(e)}
                ),
                500,
            )

