"""
WSGI entry point for Gunicorn
"""
from app import app, print_startup_message
from config import APP_NAME, APP_VERSION, API_HOST, API_PORT

# Print startup message immediately when module loads
print_startup_message()
print("  Initializing Gunicorn server...")
print("=" * 152 + "\n")

# Export the application
application = app

# Gunicorn hook - called when server is ready
def when_ready(server):
    """Called just after the server is started"""
    print(f"\n{'=' * 152}")
    print(f"  {APP_NAME} v{APP_VERSION} is ready!")
    print(f"  Server running on http://{API_HOST}:{API_PORT}")
    print(f"  Workers: {server.num_workers}")
    print("  Threads per worker: 2")
    print("  Access logs: enabled")
    print(f"{'=' * 152}\n")

