unit unUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.IniFiles, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TfrmUpdate = class(TForm)
    imgProductLogo: TImage;
    lblVersion: TLabel;
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
  Utils, Constants, Language;

var
  LanguageLabels: TLabelLanguages;

procedure TfrmUpdate.FormCreate(Sender: TObject);
var
  IniConfigFile: TIniFile;
  IniVersionFile: TIniFile;
  LocalVersion: string;
  RemoteVersion: string;
begin
  IniConfigFile := TIniFile.Create(Format('%s%s', [ExePath, CONFIG_FILE]));
  LanguageLabels := BuildLanguageLabels;
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

      frmUpdate.Caption := Format('%s - %s', [APPLICATION_NAME, LocalVersion]);
      lblVersion.Caption := Format('%s: %s', [LanguageLabels.Version, LocalVersion]);

      IniVersionFile.Free;
    end;

  finally
    IniConfigFile.Free;
  end;
end;

end.
