"""
Configuration file for the Job Match API
"""
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Application Information
APP_NAME = os.getenv("APP_NAME", "Job Match API")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
APP_DESCRIPTION = os.getenv("APP_DESCRIPTION", "API for evaluating resumes and job vacancies using AI")
APP_AUTHOR = os.getenv("APP_AUTHOR", "Bráulio Figueiredo")
APP_AUTHOR_EMAIL = os.getenv("APP_AUTHOR_EMAIL", "jobmatch@brau.io")
APP_AUTHOR_WEBSITE = os.getenv("APP_AUTHOR_WEBSITE", "https://brau.io")

# API Configuration
API_HOST = os.getenv("API_HOST", "192.168.0.1")
API_PORT = int(os.getenv("API_PORT", "5000"))
API_DEBUG = os.getenv("API_DEBUG", "True").lower() in ("true", "1", "yes")

# SMTP Email Configuration
SMTP_HOST = os.getenv("SMTP_HOST", "")
SMTP_PORT = int(os.getenv("SMTP_PORT", "465"))
SMTP_USER = os.getenv("SMTP_USER", "")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "")


