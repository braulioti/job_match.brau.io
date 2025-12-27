## [Version 1.0.0-RC1](https://github.com/braulioti/job_match.brau.io/tree/release/1.0.0-RC1) - XX/XX/XXXX

### Feature
- Created the version update screen that will allow downloading the latest version.
- Added icons and images to the desktop project.
- Project Structure section has been updated to include the languages folder.
- Created the basic structure of the desktop project.
- Created the configuration dialog to allow the user to change the application settings.
- Added splash screen and multi-language support to the desktop application.
- Created the about dialog to show the application information on the desktop.
- Created the new project dialog to allow the user to create a new project.
- Created the open project dialog to allow the user to open an existing project.
- Created a basic flask application to project backend.
- Created a Docker Image and Docker Compose file for Continuous Integration 
- Create a SendMail Service in the backend API
- Adjusted the config.py file in the API to load configuration from .env file
- Integrated PostgreSQL database with SQLAlchemy and Alembic migrations in the API
- Added user registration endpoint `POST /v1/users` in the backend API.
- Added migration to include `validated` (boolean) and `hash_validated` (UUID v4) fields in the user table.
- Implemented user login endpoint `POST /v1/users/login` with JWT (JSON Web Token) authentication.
- Added JWT configuration support (secret key, algorithm, expiration hours) in the API configuration.
- Updated user model to include validation status fields.
- Created LoginUserDTO and ResponseUserLoginDTO for authentication flow.
- Implemented user login validation endpoint `GET /v1/users/validate-login/{hash_value}` to validate user login using validation hash, returning an HTML confirmation page.
- Implemented automatic validation email sending after user registration with validation link.
- Implemented login screen in the desktop application
- Implemented account validation in the desktop application
- Implemented user authentication by hash endpoint `POST /v1/users/hash-login/{hash_value}` for authentication using hash.

### Deprecated

### Fix

### Documentation
- The project images have been defined and the basic documentation created.
- LICENSE file with MIT license has been created.
- CONTRIBUTING.md file has been added with instructions on how to contribute to the project.
- README.md has been updated with information about folder structure and technologies used in the project.
- Added Swagger-based API documentation with multilingual support (en-US and pt-BR) available via /docs.
- Updated Swagger documentation to include the new user registration endpoint `POST /v1/users`.
- Updated Swagger documentation to include the new user login endpoint `POST /v1/users/login` with JWT authentication.
- Updated Swagger documentation to include the new user login validation endpoint `GET /v1/users/validate-login/{hash_value}` that returns HTML confirmation page.
- Updated Swagger documentation to include the new user authentication by hash endpoint `POST /v1/users/hash-login/{hash}`.
- Standardized Swagger schema names to match DTO classes (CreateUserDTO, LoginUserDTO, ResponseUserDTO, ResponseUserLoginDTO).
- Created TROUBLESHOOTING.md file with solutions to main compilation and deployment problems.
