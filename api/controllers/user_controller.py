from flask import request, jsonify

from api.dtos.create_user_dto import CreateUserDTO
from api.dtos.response_user_dto import ResponseUserDTO
from api.services.user_service import user_service, UserService


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

