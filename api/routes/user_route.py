"""
User routes
Routes related to user management (authentication, profile, etc.).
"""

from flask import Blueprint

from api.controllers.user_controller import UserController

user_bp = Blueprint("user_routes", __name__, url_prefix="/v1/users")
user_controller = UserController()

@user_bp.route("/", methods=["POST"])
def create_user_route():
    """
    Route for user creation.

    Delegates the logic to the user controller.
    """
    return user_controller.create_user()

@user_bp.route("/login", methods=["POST"])
def login_route():
    """
    Route for user login and authentication.

    Delegates the logic to the user controller.
    """
    return user_controller.login()

@user_bp.route("/validate-login/<hash_value>", methods=["PUT"])
def validate_login_route(hash_value: str):
    """
    Route for user login validation.

    Receives hash_validated as path parameter.
    Delegates the logic to the user controller.
    """
    return user_controller.validate_login(hash_value)

@user_bp.route("/hash-login/<hash_value>", methods=["POST"])
def hash_login_route(hash_value: str):
    """
    Route for user login using hash.

    Receives hash as path parameter.
    Delegates the logic to the user controller.
    """
    return user_controller.hash_login(hash_value)

