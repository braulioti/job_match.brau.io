unit unUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.IniFiles, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls,
  Vcl.ComCtrls, System.UITypes;

type
  TfrmUpdate = class(TForm)
    imgProductLogo: TImage;
    lblVersion: TLabel;
    pgbProgressBar: TProgressBar;
    lblProgressBar: TLabel;
    tmrUpdateVersion: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrUpdateVersionTimer(Sender: TObject);
  private
    procedure DownloadLanguageFiles;
    procedure LoadLabels;
    procedure UpdateProgressBar(NewLabelValue: string);
    procedure SyncConfigurationFile;
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}

uses
  Utils, Constants, Language;

var
  LanguageLabels: TLabelLanguages;
  Language: string;
  Version: string;
  LanguageURI: string;

procedure TfrmUpdate.DownloadLanguageFiles;
var
  AvailableLanguages: TStringList;
  AvailableFileListPath: string;
  LanguageFilePath: string;
  LanguageFileURI: string;
  Line: string;
  I: Integer;
begin
  AvailableLanguages := TStringList.Create;
  try
    try
      DownloadFile(LanguageURI, LANGUAGE_LIST_FILE);
      CreateFolderInApplicationPath(LANGUAGE_FOLDER);
      AvailableFileListPath := Format('%s%s', [ExePath, LANGUAGE_LIST_FILE]);
      AvailableLanguages.LoadFromFile(AvailableFileListPath);

      for I := 0 to AvailableLanguages.Count - 1 do
      begin
        Line := Trim(AvailableLanguages.Strings[I]);
        LanguageFilePath := Format('%s%s/%s.%s', [ExePath, LANGUAGE_FOLDER, Line, LANGUAGE_FILE_EXT]);
        LanguageFileURI := Format('%s/%s.%s', [DEFAULT_LANGUAGE_URI, Line, LANGUAGE_FILE_EXT]);
        DownloadFile(LanguageFileURI, LanguageFilePath);
      end;

      LanguageLabels := BuildLanguageLabels(Language);
    except
      on E: Exception do
        MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
    end;
  finally
    AvailableLanguages.Free;
  end;
end;

procedure TfrmUpdate.FormCreate(Sender: TObject);
var
  IniConfigFile: TIniFile;
begin
  Language := DEFAULT_LANGUAGE;
  LanguageLabels.VersionTitle := DEFAULT_LABEL_VERSION;
  LanguageLabels.Error := DEFAULT_ERROR_TITLE;

  frmUpdate.Caption := APPLICATION_NAME;
  lblVersion.Caption := LanguageLabels.VersionTitle;

  IniConfigFile := TIniFile.Create(Format('%s%s', [ExePath, CONFIG_FILE]));
  try
    Language := IniConfigFile.ReadString('USER_CONFIG', 'LANGUAGE', DEFAULT_LANGUAGE);
    LoadLabels;

    tmrUpdateVersion.Enabled := True;
  finally
    IniConfigFile.Free;
  end;
end;

procedure TfrmUpdate.LoadLabels;
begin
  frmUpdate.Caption := Format('%s - %s', [APPLICATION_NAME, Version]);
  lblVersion.Caption := Format('%s: %s', [LanguageLabels.VersionTitle, Version]);
end;

procedure TfrmUpdate.SyncConfigurationFile;
var
  IniConfigFile: TIniFile;
  IniVersionFile: TIniFile;
  LocalVersion: string;
  RemoteVersion: string;
begin
  IniConfigFile := TIniFile.Create(Format('%s%s', [ExePath, CONFIG_FILE]));
  try
    IniVersionFile := TIniFile.Create(Format('%s%s', [ExePath, DEFAULT_VERSION_FILE]));

    try
      LocalVersion := IniConfigFile.ReadString('APPLICATION', 'VERSION', EmptyStr);

      RemoteVersion := IniVersionFile.ReadString('APPLICATION', 'VERSION', EmptyStr);
      LanguageURI := IniVersionFile.ReadString('REMOTE_FILES', 'LANGUAGE_URI', EmptyStr);
    finally
      if LocalVersion <> RemoteVersion then
      begin
        IniConfigFile.WriteString('APPLICATION', 'VERSION', RemoteVersion);
        IniConfigFile.WriteString('REMOTE_FILES', 'LANGUAGE_URI', LanguageURI);

        LocalVersion := RemoteVersion;
      end
      else
      begin
        LanguageURI := IniConfigFile.ReadString('REMOTE_FILES', 'LANGUAGE_URI', EmptyStr);
      end;
      Version := LocalVersion;

      IniVersionFile.Free;
    end;

  finally
    IniConfigFile.Free;
  end;
end;

procedure TfrmUpdate.tmrUpdateVersionTimer(Sender: TObject);
begin
  tmrUpdateVersion.Enabled := False;
  try
    pgbProgressBar.Max := 3;
    try
      UpdateProgressBar(LanguageLabels.UpdatingConfigFiles);
      DownloadFile(DEFAULT_VERSION_URI, DEFAULT_VERSION_FILE);
      SyncConfigurationFile;

      UpdateProgressBar(LanguageLabels.DownloadingLanguageFiles);
      DownloadLanguageFiles;
    except
      on E: Exception do
        MessageDlg(E.Message, TMsgDlgType.mtError, [mbOK], 0);
    end;
  finally
    // Progress Bar Finished
    Application.Terminate;
  end;
end;

procedure TfrmUpdate.UpdateProgressBar(NewLabelValue: string);
begin
  pgbProgressBar.Position := pgbProgressBar.Position + 1;
  lblProgressBar.Caption := NewLabelValue;
  lblProgressBar.Repaint;
  lblProgressBar.Refresh;
end;

end.
