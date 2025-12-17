from flask import request, render_template

from api.services.swagger_service import load_openapi_spec


def get_openapi_spec():
    """
    Controller para retornar o arquivo OpenAPI em YAML.

    Query params:
      - language: en-US (default) ou pt-BR
    """
    language = request.args.get("language", "en-US")
    return load_openapi_spec(language)


def get_swagger_docs():
    """
    Controller para renderizar o Swagger UI.

    Query params:
      - language: en-US (default) ou pt-BR
    """
    language = request.args.get("language", "en-US")
    return render_template("swagger.html", language=language)



