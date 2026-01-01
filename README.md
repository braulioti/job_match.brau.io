# <div align="center"><a href="https://brau.io"><img src="docs/images/job_match_logo.png" alt="Job Match" width="70%"></a></div>

## Job Match - 1.0.0

[![X: @_brau_io](https://img.shields.io/badge/contact-@_brau_io-blue.svg?style=flat)](https://x.com/_brau_io)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/53ac0a0cb0f5464d89eea04cf39bc43f)](https://app.codacy.com/gh/braulioti/job_match.brau.io/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Delphi](https://img.shields.io/badge/Delphi-d92a30?style=for-the-badge&logo=delphi&logoColor=white)](https://www.embarcadero.com//)
[![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/en/stable/)
[![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)](https://sqlite.org/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Swagger](https://img.shields.io/badge/-Swagger-%23Clojure?style=for-the-badge&logo=swagger&logoColor=white)](https://swagger.io/)
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
- [Languages](#languages)
- [Frontend Desktop Project](#frontend-desktop-project)
    - [Database Versioning](#database-versioning)
- [Backend API Project](#backend-api-project)
    - [Installation](#installation)
    - [Execution](#execution)
    - [Health Check Endpoint](#health-check-endpoint)
- [Troubleshooting](#troubleshooting)
- [Running the Docker Container](#running-the-docker-container)
    - [Using Docker directly](#using-docker-directly)
    - [Using Docker Compose](#using-docker-compose)
- [Versioning](#versioning)
- [Author](#author)

## Project Structure

```
job_match.brau.io/
├── api/                       # Backend API (Flask)
├── desktop/                   # Desktop Application (Delphi)
├── frontend/                  # Frontend (Angular Application)
├── continuous-integration/    # CI/CD configurations
│   ├── .dockerignore          # Files ignored by Docker
│   ├── Dockerfile             # Docker image definition for the Flask API
│   └── docker-compose.yml     # Docker Compose configuration for deployment
├── installer/                 # Installation scripts
├── languages/                 # Language files
├── docs/                      # Project documentation
├── README.md                  # Main documentation
├── CHANGELOG.md               # Change history
├── CONTRIBUTING.md            # Contribution guide
├── TROUBLESHOOTING.md         # Troubleshooting guide
└── LICENSE                    # Project license
```

## Technologies

- Python 3.12
- SQLite (Desktop Application)
- Flask 3.0.0 or higher
- Docker Engine 20.10 or higher
- Docker Compose 2.0 or higher
- Swagger Open API 3.0
- PostgreSQL 13 or higher
- Flask-Migrate (Alembic)
- Dockling
- Embarcadero Delphi 12 - Community Edition

## Languages

To add a translation file to the project, add a line with the language code in `languages/available_languages` and create a language file with the `.txt` extension in the `languages/` folder. 

The translated content should have a constant before the "=" and the translation after it. Example: `EXIT=Exit`. To facilitate understanding of the file, the values are being organized in alphabetical order.

Whenever you add a new language file in the `languages/` folder, it is recommended to also create the corresponding Swagger documentation file for that language inside `api/swagger`, following the same locale naming pattern (for example: `en_US.yaml`, `pt_BR.yaml`).

## Frontend Desktop Project

### Database Versioning

The database versioning is done using the parameters table with the VERSION parameter as a reference to control the versions of database scripts. The database file is `database.match`, which is automatically generated and can be opened using SQLite.

## Backend API Project

### Installation

1. Create a virtual environment:
```bash
python -m venv venv
```

2. Activate the virtual environment:
```bash
# Windows PowerShell
.\venv\Scripts\Activate.ps1

# Windows CMD
.\venv\Scripts\activate.bat

# Linux/Mac
source venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Configure the environment file:
```bash
# Windows PowerShell
Copy-Item api\env.example api\.env

# Windows CMD / Linux / Mac
cp api/env.example api/.env
```
Edit the `api/.env` file and update the environment variables according to your configuration.

### Execution

To run the API:

```bash
python app.py
```

### Health Check Endpoint
- **GET** `/health`
  - Returns the API status

### Swagger Documentation

- **Default access**:  
  - Open your browser and access: `http://localhost:5000/docs`  
  - By default, the documentation is rendered in **English** (`en-US`).

- **Language selection (optional query parameter)**:  
  - You can choose the documentation language using the optional `language` query parameter:  
    - `http://localhost:5000/docs?language=en-US`  
    - `http://localhost:5000/docs?language=pt-BR`  
  - The same parameter is also supported on the raw OpenAPI endpoint:  
    - `http://localhost:5000/openapi?language=en-US`  
    - `http://localhost:5000/openapi?language=pt-BR`

- **Available languages**:  
  - The list of available OpenAPI documentation languages and their files is maintained in the folder `api/swagger`.  
  - Each language corresponds to a YAML file following the pattern `<locale>.yaml` / `<locale>.yml` (for example: `en_US.yaml`, `pt_BR.yaml`).

## Troubleshooting

[Click here](TROUBLESHOOTING.md) for solutions to the main compilation and deployment problems you may encounter while working with this project.

## Running the Docker Container

### Using Docker directly:

```bash
docker run -d \
  --name job-match-api \
  -p 5000:5000 \
  --restart unless-stopped \
  job-match-api:latest
```

### Using Docker Compose:

```bash
# From the project root
docker-compose -f continuous-integration/docker-compose.yml up -d
```

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

