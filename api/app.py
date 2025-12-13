import sys
from flask import Flask
from routes.routes import routes_bp
from config import (
    APP_NAME, APP_VERSION, APP_DESCRIPTION, APP_AUTHOR,
    APP_AUTHOR_EMAIL, APP_AUTHOR_WEBSITE,
    API_HOST, API_PORT, API_DEBUG
)

app = Flask(__name__)

# Registrar as rotas
app.register_blueprint(routes_bp)

def print_startup_message():
    """Exibe mensagens informativas sobre a aplicação ao iniciar"""
    # ASCII Art Logo
    print("                   XXXXXXX     ;;;;;;;;                                                                                                                 ")
    print("                XXXXXXXXXXXXX;;;;;;;;;;;;;                                                                                                              ")
    print("              XXXXXXXXXXXXXXXXX;;;;;;;;;;;;;                                                                                                            ")
    print("            XXXXXXXXXXXXXXXXXXXXx;;;;;;;;;;;;                                                                                                           ")
    print("          XXXXXXXXXXXXXXXXXXXXXXXX+;;;;;;;;;;;;                                                                                                         ")
    print("         XXXXXXXXXXXXXXXXXXXXXXXXXX;;;;;;;;;;;;;;                             XXX                                                     ;;;;              ")
    print("       XXXXXXXXXXXXXXXXXXXXXXXXXXX    ;;;;;;;;;;;;;       XXXXXXX             XXX         ;;;;       ;;;;            ;;;;             ;;;;              ")
    print("      XXXXXXXXXXXXXXXXXXXXXXXXXX$     ;;;;;;;;;;;;;           XXX     XXXX    XXX XXXX    ;;;;;     ;;;;;  ;;;;;;   ;;;;;;;   ;;;;;;  ;;;;;;;;;         ")
    print("     XXXXXXXXXXXXXXXX   $XXXXXX     ;;;;;;;;;;;;;;;;          XXX  $XXXXXXXXX XXXXXXXXXX  ;;;;;;   ;;;;;; ;;;;;;;;; ;;;;;;; ;;;;;;;;; ;;;;;;;;;;        ")
    print("     XXXXXXXXXXXXXX+      $X$     ;;;;;;;;;;;;;;;;;;          XXX XXX$    XXX XXX     XXX ;;; ;;;;;;;;;;;   ;;;;;;;  ;;;;  ;;;;       ;;;;   ;;;;       ")
    print("     XXXXXXXXXXXXXX;;;          ;;;;;;;;;;;;;;;;;;;;          XXX XXXX    XXX XXX    $XXX ;;;  ;;;;  ;;;; ;;;   ;;;  ;;;;  ;;;;       ;;;;   ;;;;       ")
    print("      XXXXXXXXXXXXX;;;;;       ;;;;;;;;;;;;;;;;;;;;      XXXXXXXX  $XXXXXXXX  XXXXXXXXXX  ;;;   ;;   ;;;; ;;;;;;;;;  ;;;;;; ;;;;;;;;; ;;;;   ;;;;       ")
    print("      $XXXXXXXXXXXX+;;;;;    ;;;;;;;;;;;;;;;;;;;;;        XXXXX$     XXX$X    XXX XXX$    ;;;         ;;    ;;;  ;;    ;;;;    ;;;;    ;;     ;;        ")
    print("        XXXXXXXXXXXXx;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                                                                                       ")
    print("          XXXXXXXXXXXXx;;;;;;;;;;;;;;;;;;;;;;;;                                                                                                         ")
    print("            XXXXXXXXXXXX+;;;;;;;;;;;;;;;;;;;;                                                                                                           ")
    print("             XXXXXXXXXXXXX+;;;;;;;;;;;;;;;;                                                                                                             ")
    print("               $XXXXXXXXXXXX;;;;;;;;;;;;;                                                                                                               ")
    print("                  XXXXXXXX     ;;;;;;;                                                                                                                  ")
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
        app.run(debug=API_DEBUG, host=API_HOST, port=API_PORT)
    except KeyboardInterrupt:
        print("\n\n" + "=" * 70)
        print("  Server stopped by user")
        print("=" * 70 + "\n")
        sys.exit(0)

