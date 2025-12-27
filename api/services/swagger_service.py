import os
from flask import jsonify, Response


class SwaggerService:
    """
    Service responsável por carregar a documentação OpenAPI (Swagger).
    """

    @staticmethod
    def load_openapi_spec(language: str) -> Response:
        """
        Carrega o arquivo OpenAPI (Swagger) em YAML conforme o idioma.

        :param language: Código de idioma, ex: 'en-US' (default) ou 'pt-BR'
        :return: Flask Response com o YAML ou JSON de erro
        """
        lang_normalized = (language or "en-US").replace("_", "-").lower()

        if lang_normalized in ("pt-br", "pt"):
            filename = "pt_BR.yaml"
        else:
            filename = "en_US.yaml"

        base_dir = os.path.dirname(os.path.dirname(__file__))  # pasta api/
        swagger_path = os.path.join(base_dir, "swagger", filename)

        if not os.path.exists(swagger_path):
            return (
                jsonify(
                    {
                        "error": "swagger_file_not_found",
                        "message": f"Swagger file '{filename}' not found.",
                    }
                ),
                500,
            )

        try:
            with open(swagger_path, "r", encoding="utf-8") as f:
                content = f.read()
        except Exception as e:
            return (
                jsonify(
                    {
                        "error": "swagger_file_error",
                        "message": str(e),
                    }
                ),
                500,
            )

        return Response(content, mimetype="application/x-yaml")


# Instância única do serviço para ser reutilizada pelos controllers
swagger_service = SwaggerService()

