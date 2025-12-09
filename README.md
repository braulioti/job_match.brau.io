# <div align="center"><a href="https://brau.io"><img src="docs/images/job_match_logo.png" alt="Job Match" width="70%"></a></div>

## Job Match - 1.0.0

[![X: @_brau_io](https://img.shields.io/badge/contact-@_brau_io-blue.svg?style=flat)](https://x.com/_brau_io)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/53ac0a0cb0f5464d89eea04cf39bc43f)](https://app.codacy.com/gh/braulioti/job_match.brau.io/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)](https://www.python.org/)
[![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)](https://sqlite.org/)
[![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/en/stable/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Swagger](https://img.shields.io/badge/-Swagger-%23Clojure?style=for-the-badge&logo=swagger&logoColor=white)](https://swagger.io/)
[![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Licence](https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge)](./LICENSE)

This project aims to provide a tool where job vacancies and resumes will be informed.
For candidates, it will be an important tool to inform how they should better prepare for market opportunities.
For companies, it is possible to use AI to filter the best candidates for each vacancy and see the match percentage between the vacancy and the candidate's resume.

Job Match is created and maintained by [Bráulio Figueiredo](https://brau.io).
New project updates can be followed through X:
[@_brau_io](https://x.com/_brau_io).

## Table of Contents

- [Project Structure](#project-structure)
- [Technologies](#technologies)
- [Installation](#installation)
- [Desktop Version](#desktop-version)
    - [Build the version](#build-the-version)
    - [Files and folders that need to be distributed](#files-and-folders-that-need-to-be-distributed)
    - [Server file settings](#server-file-settings)
- [Backend API Project](#backend-api-project)
    - [Health Check Endpoint](#health-check-endpoint)
    - [API v1](#api-v1)
    - [Environment variables configuration](#environment-variables-configuration)
    - [Troubleshooting - Docling on Windows](#troubleshooting---docling-on-windows)
    - [API Documentation - Swagger](#api-documentation---swagger)
- [Versioning](#versioning)
- [Author](#author)

## Project Structure

```
job_match.brau.io/
├── api/                      # Backend API (Flask)
├── backend/                  # Additional backend (if applicable)
├── desktop/                   # Desktop Application (Delphi)
├── frontend/                  # Frontend (Angular Application)
├── continuous-integration/    # CI/CD configurations
├── installer/                 # Installation scripts
├── docs/                      # Project documentation
├── README.md                  # Main documentation
├── CHANGELOG.md               # Change history
├── CONTRIBUTING.md            # Contribution guide
└── LICENSE                    # Project license
```

## Technologies

- Python 3.11 or higher (recommended for full and continuous support for Google AI libraries)
    - Python 3.10 also works, but support will be discontinued in 2026
- SQLite (Desktop Application)
- Flask 3.0.0 or higher
- Docker Engine 20.10 or higher
- Docker Compose 2.0 or higher
- Swagger Open API 3.0
- PostgreSQL 13 or higher
- Flask-Migrate (Alembic)
- Dockling

## Versioning

Job Match uses "Semantic Versioning" guidelines whenever possible.
Updates are numbered as follows:

`<major>.<minor>.<patch>`

Built on the following guidelines:

* Breaking compatibility with the previous version will be updated in "major"
* New implementations and features in "minor"
* Bug fixes in "patch"

For more information about SemVer, please visit http://semver.org.

## Author
- Email: braulio@braulioti.com.br
- X: https://x.com/_brau_io
- GitHub: https://github.com/braulioti
- Website: http://brau.io

