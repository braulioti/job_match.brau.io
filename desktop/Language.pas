unit Language;

interface

uses
  System.Classes, System.SysUtils;

type
  TLabelLanguages = record
    VersionTitle: string;
    UpdatingConfigFiles: string;
    DownloadingLanguageFiles: string;
    MessageExit: string;
    Error: string;
    Configuration: string;
    Tools: string;
    Project: string;
    Exit: string;
    OK: string;
    Cancel: string;
    Apply: string;
  end;

function BuildLanguageLabels(LanguageCode: string): TLabelLanguages;

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
    end;
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
    LanguageFile.LoadFromFile(FileName);

    Aux.VersionTitle := LoadStringLine(LanguageFile, 'VERSION');
    Aux.DownloadingLanguageFiles := LoadStringLine(LanguageFile, 'DOWNLOADING_LANGUAGE_FILES');
    Aux.MessageExit := LoadStringLine(LanguageFile, 'MESSAGE_EXIT');
    Aux.Configuration := LoadStringLine(LanguageFile, 'CONFIGURATION');
    Aux.Tools := LoadStringLine(LanguageFile, 'TOOLS');
    Aux.Project := LoadStringLine(LanguageFile, 'PROJECT');
    Aux.Exit := LoadStringLine(LanguageFile, 'EXIT');
    Aux.OK := LoadStringLine(LanguageFile, 'OK');
    Aux.Cancel := LoadStringLine(LanguageFile, 'CANCEL');
    Aux.Apply := LoadStringLine(LanguageFile, 'APPLY');

    BuildLanguageLabels := Aux;
  finally
    LanguageFile.Free;
  end;
end;

end.
