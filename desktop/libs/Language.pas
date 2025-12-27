unit Language;

interface

uses
  System.Classes, System.SysUtils, System.IOUtils, System.Generics.Collections,
  Vcl.Dialogs;

type
  TLabelLanguages = record
    VersionTitle: string;
    UpdatingConfigFiles: string;
    DownloadingLanguageFiles: string;
    MessageExit: string;
    Error: string;
    Configurations: string;
    Tools: string;
    Project: string;
    Exit: string;
    OK: string;
    Cancel: string;
    Apply: string;
    SelectLanguage: string;
    Close: string;
    LoadingApplicationScreens: string;
    About: string;
    AboutDetails: string;
    Author: string;
    Help: string;
    NewProject: string;
    ProjectName: string;
    ProjectDetails: string;
    OpenProject: string;
    SelectProject: string;
    Login: string;
    Password: string;
    Email: string;
    ValidateAccountValid: string;
    ClickToValidate: string;
    Send: string;
    Validation: string;
    ValidationMessage: string;
    Validate: string;
    SendEmail: string;
    ValidateAccountSuccessful: string;
    ValidateAccountError: string;
    SendEmailError: string;
    SendEmailSuccess: string;
  end;

  TAvailableLanguages = record
    Language: string;
    Code: string;
  end;

function BuildLanguageLabels(LanguageCode: string): TLabelLanguages;
procedure LoadAvailableLanguages;

var
  AvailableLanguages: TList<TAvailableLanguages>;

implementation

uses Utils, Constants;

function LoadStringLine(Lines: TStringList; Key: string): string;
var
  I: Integer;
  LineKey: string;
  Line: string;
begin
  for I := 0 to Lines.Count - 1 do
  begin
    Line := Lines.Strings[I];
    LineKey := Copy(Line, 0, Pos('=', Line) - 1);
    if Key = LineKey then
    begin
      LoadStringLine := Copy(Line, Pos('=', Line) + 1, Length(Line));
      Break;
    end;
  end;
end;

procedure LoadAvailableLanguages;
var
  FileName: string;
  Files: TArray<string>;
  Folder: string;
  FileLanguage: TStringList;
  Aux: TAvailableLanguages;
begin
  FileLanguage := TStringList.Create;
  try
    AvailableLanguages := TList<TAvailableLanguages>.Create;
    Folder := Format('%s%s', [ExePath, LANGUAGE_FOLDER]);
    Files := TDirectory.GetFiles(Folder);

    for FileName in Files do
    begin
      Aux.Code := ExtractFileName(FileName);
      Aux.Code := Copy(Aux.Code, 0, Pos('.', Aux.Code) - 1);
      FileLanguage.LoadFromFile(FileName, TEncoding.UTF8);
      Aux.Language := LoadStringLine(FileLanguage, 'LANGUAGE');

      AvailableLanguages.Add(Aux);
    end;
  finally
    FileLanguage.Free;
  end;
end;

function BuildLanguageLabels(LanguageCode: string): TLabelLanguages;
var
  Aux: TLabelLanguages;
  LanguageFile: TStringList;
  FileName: string;
begin
  LanguageFile := TStringList.Create;
  try
    FileName := Format('%s%s/%s.%s',
      [ExePath, LANGUAGE_FOLDER, LanguageCode, LANGUAGE_FILE_EXT]);
    LanguageFile.LoadFromFile(FileName, TEncoding.UTF8);

    Aux.VersionTitle := LoadStringLine(LanguageFile, 'VERSION');
    Aux.DownloadingLanguageFiles := LoadStringLine(LanguageFile, 'DOWNLOADING_LANGUAGE_FILES');
    Aux.MessageExit := LoadStringLine(LanguageFile, 'MESSAGE_EXIT');
    Aux.Configurations := LoadStringLine(LanguageFile, 'CONFIGURATIONS');
    Aux.Tools := LoadStringLine(LanguageFile, 'TOOLS');
    Aux.Project := LoadStringLine(LanguageFile, 'PROJECT');
    Aux.Exit := LoadStringLine(LanguageFile, 'EXIT');
    Aux.OK := LoadStringLine(LanguageFile, 'OK');
    Aux.Cancel := LoadStringLine(LanguageFile, 'CANCEL');
    Aux.Close := LoadStringLine(LanguageFile, 'CLOSE');
    Aux.SelectLanguage := LoadStringLine(LanguageFile, 'SELECT_LANGUAGE');
    Aux.LoadingApplicationScreens := LoadStringLine(LanguageFile, 'LOADING_APPLICATION_SCREENS');
    Aux.About := LoadStringLine(LanguageFile, 'ABOUT');
    Aux.AboutDetails := LoadStringLine(LanguageFile, 'ABOUT_DETAILS');
    Aux.Author := LoadStringLine(LanguageFile, 'AUTHOR');
    Aux.Help := LoadStringLine(LanguageFile, 'HELP');
    Aux.NewProject := LoadStringLine(LanguageFile, 'NEW_PROJECT');
    Aux.ProjectName := LoadStringLine(LanguageFile, 'PROJECT_NAME');
    Aux.ProjectDetails := LoadStringLine(LanguageFile, 'PROJECT_DETAILS');
    Aux.OpenProject := LoadStringLine(LanguageFile, 'OPEN_PROJECT');
    Aux.SelectProject := LoadStringLine(LanguageFile, 'SELECT_PROJECT');
    Aux.Login := LoadStringLine(LanguageFile, 'LOGIN');
    Aux.Password := LoadStringLine(LanguageFile, 'PASSWORD');
    Aux.Email := LoadStringLine(LanguageFile, 'EMAIL');
    Aux.ValidateAccountValid := LoadStringLine(LanguageFile, 'VALIDATE_ACCOUNT_VALID');
    Aux.ClickToValidate := LoadStringLine(LanguageFile, 'CLICK_TO_VALIDATE');
    Aux.Validation := LoadStringLine(LanguageFile, 'VALIDATION');
    Aux.ValidationMessage := LoadStringLine(LanguageFile, 'VALIDATION_MESSAGE');
    Aux.Validate := LoadStringLine(LanguageFile, 'VALIDATE');
    Aux.SendEmail := LoadStringLine(LanguageFile, 'SEND_EMAIL');
    Aux.ValidateAccountSuccessful := LoadStringLine(LanguageFile, 'VALIDATE_ACCOUNT_SUCCESSFUL');
    Aux.ValidateAccountError := LoadStringLine(LanguageFile, 'VALIDATE_ACCOUNT_ERROR');
    Aux.SendEmailError := LoadStringLine(LanguageFile, 'SEND_EMAIL_ERROR');
    Aux.SendEmailSuccess := LoadStringLine(LanguageFile, 'SEND_EMAIL_SUCCESS');

    BuildLanguageLabels := Aux;
  finally
    LanguageFile.Free;
  end;
end;

end.
