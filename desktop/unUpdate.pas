unit unUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.IniFiles;

type
  TfrmUpdate = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}

uses
  Utils, Constants;

procedure TfrmUpdate.FormCreate(Sender: TObject);
var
  IniConfigFile: TIniFile;
  IniVersionFile: TIniFile;
  LocalVersion: string;
  RemoteVersion: string;
begin
  IniConfigFile := TIniFile.Create(Format('%s%s', [ExePath, CONFIG_FILE]));
  try
    DownloadFile(DEFAULT_VERSION_URI, DEFAULT_VERSION_FILE);
    IniVersionFile := TIniFile.Create(Format('%s%s', [ExePath, DEFAULT_VERSION_FILE]));

    try
      LocalVersion := IniConfigFile.ReadString('APPLICATION', 'VERSION', EmptyStr);
      RemoteVersion := IniVersionFile.ReadString('APPLICATION', 'VERSION', EmptyStr);
    finally
      if LocalVersion <> RemoteVersion then
      begin
        IniConfigFile.WriteString('APPLICATION', 'VERSION', RemoteVersion);
      end;
      IniVersionFile.Free;
    end;

  finally
    IniConfigFile.Free;
  end;
end;

end.
