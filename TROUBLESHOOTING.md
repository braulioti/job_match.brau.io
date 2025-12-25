# Troubleshooting

## About this file

This file contains solutions to the main compilation and deployment problems you may encounter while working with this project.

## Delphi Build Errors

### EHTTPProtocolException

An error may occur when trying to run the application in Delphi: `EHTTPProtocolException` that terminates the application. To avoid this error, the exception must be added in **Tools / Options**. Within this window, access **Debugger / Embarcadero Debuggers / Language Exceptions** and add `EHTTPProtocolException` as shown in the image below.

![EHTTPProtocolException Configuration](docs/images/troubleshooting/EHTTPProtocolException.png)
