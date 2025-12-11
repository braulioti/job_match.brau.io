unit Config;

interface

uses
  System.IniFiles, System.SysUtils;

procedure SaveConfiguration;
procedure LoadConfiguration;

type TCustomConfig = record
  Language: string;
  Version: string;
end;

var
  CustomConfig: TCustomConfig;

implementation

uses
  Constants, Utils;

procedure LoadConfiguration;
var
  IniConfigFile: TIniFile;
begin
  IniConfigFile := TIniFile.Create(Format('%s%s', [ExePath, CONFIG_FILE]));
  try
    CustomConfig.Language := IniConfigFile.ReadString('USER_CONFIG', 'LANGUAGE', DEFAULT_LANGUAGE);
    CustomConfig.Version := IniConfigFile.ReadString('APPLICATION', 'VERSION', EmptyStr);
  finally
    IniConfigFile.Free;
  end;
end;

procedure SaveConfiguration;
var
  IniConfigFile: TIniFile;
begin
  IniConfigFile := TIniFile.Create(Format('%s%s', [ExePath, CONFIG_FILE]));
  try
    IniConfigFile.WriteString('USER_CONFIG', 'LANGUAGE', CustomConfig.Language);
  finally
    IniConfigFile.Free;
  end;
end;

end.
