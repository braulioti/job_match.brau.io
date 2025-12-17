from flask import Blueprint, jsonify
from api.controllers.swagger_controller import get_openapi_spec, get_swagger_docs

routes_bp = Blueprint('routes', __name__)


@routes_bp.route('/health', methods=['GET'])
def health_check():
    """
    Endpoint de health check
    """
    return jsonify({"status": "healthy"}), 200


@routes_bp.route('/openapi', methods=['GET'])
def openapi_spec():
    """
    Retorna o arquivo OpenAPI em YAML.

    Delegado para o controller de Swagger.
    """
    return get_openapi_spec()


@routes_bp.route('/docs', methods=['GET'])
def swagger_docs():
    """
    Renderiza o Swagger UI.

    Delegado para o controller de Swagger.
    """
    return get_swagger_docs()
