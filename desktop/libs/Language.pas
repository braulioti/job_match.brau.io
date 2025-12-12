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

    BuildLanguageLabels := Aux;
  finally
    LanguageFile.Free;
  end;
end;

end.
