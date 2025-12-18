from flask import request, render_template

from api.services.swagger_service import swagger_service, SwaggerService


class SwaggerController:
    """
    Controller responsável por orquestrar as ações relacionadas
    à documentação Swagger / OpenAPI.
    """

    service: SwaggerService

    def __init__(self) -> None:
        self.service = SwaggerService()

    def get_openapi_spec(self):
        """
        Retorna o arquivo OpenAPI em YAML.

        Query params:
          - language: en-US (default) ou pt-BR
        """
        language = request.args.get("language", "en-US")
        return self.service.load_openapi_spec(language)

    @staticmethod
    def get_swagger_docs():
        """
        Renderiza o Swagger UI.

        Query params:
          - language: en-US (default) ou pt-BR
        """
        language = request.args.get("language", "en-US")
        return render_template("swagger.html", language=language)
