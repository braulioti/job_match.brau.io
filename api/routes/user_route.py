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

