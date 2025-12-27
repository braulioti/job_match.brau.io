unit Config;

interface

uses
  System.IniFiles, System.SysUtils;

procedure SaveConfiguration;
procedure LoadConfiguration;

type TCustomConfig = record
  Language: string;
  Version: string;
  HashAuthentication: string;
  APIServer: string;
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
    CustomConfig.Version := IniConfigFile.ReadString('APPLICATION', 'VERSION', EmptyStr);
    CustomConfig.APIServer := IniConfigFile.ReadString('APPLICATION', 'API_SERVER', EmptyStr);

    CustomConfig.Language := IniConfigFile.ReadString('USER_CONFIG', 'LANGUAGE', DEFAULT_LANGUAGE);
    CustomConfig.HashAuthentication := IniConfigFile.ReadString('USER_CONFIG', 'HASH_AUTHENTICATION', EmptyStr);
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
    IniConfigFile.WriteString('APPLICATION', 'API_SERVER', CustomConfig.APIServer);

    IniConfigFile.WriteString('USER_CONFIG', 'LANGUAGE', CustomConfig.Language);
    IniConfigFile.WriteString('USER_CONFIG', 'HASH_AUTHENTICATION', CustomConfig.HashAuthentication);
  finally
    IniConfigFile.Free;
  end;
end;

end.
