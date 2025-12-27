import sys
import os
from flask import Flask, jsonify
from routes import routes_bp, user_bp
from config import (
    APP_NAME,
    APP_VERSION,
    APP_DESCRIPTION,
    APP_AUTHOR,
    APP_AUTHOR_EMAIL,
    APP_AUTHOR_WEBSITE,
    API_HOST,
    API_PORT,
    API_DEBUG,
)

app = Flask(__name__)

# Initialize database and run migrations
from migrations.database import init_database

# Registrar as rotas
app.register_blueprint(routes_bp)
app.register_blueprint(user_bp)

# Debug: List all registered routes
if API_DEBUG:
    @app.route('/routes', methods=['GET'])
    def list_routes():
        """Debug endpoint to list all registered routes"""
        routes = []
        for rule in app.url_map.iter_rules():
            routes.append({
                'endpoint': rule.endpoint,
                'methods': list(rule.methods),
                'path': str(rule)
            })
        return jsonify({'routes': routes}), 200

def load_ascii_logo():
    """Load template logo from file"""
    try:
        logo_path = os.path.join(os.path.dirname(__file__), 'templates', 'ascii_logo.txt')
        with open(logo_path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return ""
    except Exception as e:
        print(f"Erro ao carregar logo: {e}")
        return ""

def print_startup_message():
    # ASCII Art Logo
    logo = load_ascii_logo()
    if logo:
        print(logo)

    print("\n" + "=" * 152)
    print(f"  {APP_NAME} v{APP_VERSION}")
    print("=" * 152)
    print(f"  Description: {APP_DESCRIPTION}")
    print(f"  Author: {APP_AUTHOR}")
    print(f"  Email: {APP_AUTHOR_EMAIL}")
    print(f"  Website: {APP_AUTHOR_WEBSITE}")
    print("=" * 152)
    print(f"  Starting server on http://{API_HOST}:{API_PORT}")
    print(f"  Debug mode: {'ON' if API_DEBUG else 'OFF'}")
    print("=" * 152 + "\n")


if __name__ == '__main__':
    print_startup_message()
    try:
        # Initialize database and run migrations
        init_database()
        print()
        
        # Start the Flask application
        app.run(debug=API_DEBUG, host=API_HOST, port=API_PORT)
    except KeyboardInterrupt:
        print("\n\n" + "=" * 70)
        print("  Server stopped by user")
        print("=" * 70 + "\n")
        sys.exit(0)
    except Exception as e:
        print(f"\n  ✗ Error starting application: {str(e)}")
        sys.exit(1)

