"""
Database configuration and management for PostgreSQL using SQLAlchemy
"""
from urllib.parse import quote_plus
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from api.config import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD

# Build database URL with URL-encoded password to handle special characters
encoded_password = quote_plus(DB_PASSWORD) if DB_PASSWORD else ""
DATABASE_URL = f"postgresql://{DB_USER}:{encoded_password}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# Create SQLAlchemy engine
engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True,  # Verify connections before using them
    pool_size=10,  # Number of connections to maintain
    max_overflow=20,  # Maximum number of connections beyond pool_size
    echo=False  # Set to True for SQL query logging
)

# Create SessionLocal class for database sessions
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create Base class for declarative models
Base = declarative_base()


def get_db():
    """
    Dependency function to get database session.
    Use this in FastAPI/Flask route dependencies.
    
    Usage:
        @app.route('/endpoint')
        def my_endpoint():
            db = get_db()
            try:
                # Use db session
                pass
            finally:
                db.close()
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def init_db():
    """
    Initialize database by creating all tables.
    This should be called after all models are imported.
    """
    Base.metadata.create_all(bind=engine)


def get_engine():
    """
    Get the SQLAlchemy engine instance.
    Useful for Alembic migrations.
    """
    return engine


def init_database():
    """
    Initialize database connection and run migrations.
    This function should be called at application startup.
    """
    from alembic import command
    from alembic.config import Config
    import os
    
    try:
        # Get the migrations directory path
        migrations_dir = os.path.dirname(os.path.abspath(__file__))
        alembic_ini_path = os.path.join(migrations_dir, 'alembic.ini')
        
        # Create Alembic config
        if os.path.exists(alembic_ini_path):
            alembic_cfg = Config(alembic_ini_path)
        else:
            # Create config programmatically if alembic.ini doesn't exist
            alembic_cfg = Config()
            alembic_cfg.set_main_option('script_location', migrations_dir)
        
        # Set the database URL
        alembic_cfg.set_main_option('sqlalchemy.url', DATABASE_URL)
        
        # Run migrations to upgrade database to latest version
        print("  Running database migrations...")
        command.upgrade(alembic_cfg, "head")
        print("  ✓ Database migrations completed successfully!")
        
    except FileNotFoundError:
        # If alembic.ini doesn't exist, create tables directly from models
        print("  Alembic configuration not found. Creating tables from models...")
        init_db()
        print("  ✓ Database tables created successfully!")
    except Exception as e:
        print(f"  ⚠ Warning: Could not run migrations: {str(e)}")
        print("  Attempting to create tables directly from models...")
        try:
            init_db()
            print("  ✓ Database tables created successfully!")
        except Exception as db_error:
            print(f"  ✗ Error: Could not initialize database: {str(db_error)}")
            raise

