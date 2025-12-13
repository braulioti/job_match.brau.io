from flask import Blueprint, jsonify

routes_bp = Blueprint('routes', __name__)

@routes_bp.route('/health', methods=['GET'])
def health_check():
    """
    Endpoint de health check
    """
    return jsonify({"status": "healthy"}), 200

