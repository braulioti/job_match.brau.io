unit unMainDataModule;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Phys.SQLiteWrapper.Stat, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param;

type
  TdtmMainDataModule = class(TDataModule)
    restClient: TRESTClient;
    restRequest: TRESTRequest;
    restResponse: TRESTResponse;
    fdcDatabase: TFDConnection;
    fdcDriverLink: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ValidatedMail(Hash: string): boolean;
    function ResendValidateMail(Hash: string): boolean;
    procedure ProcessMigrations;
  end;

var
  dtmMainDataModule: TdtmMainDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Config, Utils, Constants;

{$R *.dfm}

procedure TdtmMainDataModule.DataModuleCreate(Sender: TObject);
begin
  fdcDriverLink.VendorLib := Format('%s/dll/sqlite3.dll', [Utils.ExePath]);
  fdcDatabase.Params.Database := Format('%s/database.match', [Utils.ExePath]);
  fdcDatabase.Connected := true;
end;

procedure TdtmMainDataModule.ProcessMigrations;
var
  Query: TFDQuery;
  Version: Integer;
begin
  Version := 0;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := fdcDatabase;
    Query.SQL.Clear;
    Query.SQL.Add('CREATE TABLE IF NOT EXISTS parameter (  ');
    Query.SQL.Add('   id INTEGER PRIMARY KEY AUTOINCREMENT,');
    Query.SQL.Add('   param_name VARCHAR(100) NOT NULL,    ');
    Query.SQL.Add('   param_value VARCHAR(255) NOT NULL);  ');
    Query.ExecSQL;
    Query.Close;

    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT param_value FROM parameter WHERE param_name = :param_name;');
    Query.Params.ParamByName('param_name').Value := PARAM_VERSION_NAME;
    Query.Open;

    if Query.RecordCount > 0 then
    begin
      Version := StrToInt(Query.FieldByName('param_value').AsString);      
      Query.Close;
    end
    else 
    begin                                                                  
      Query.Close;
      
      Query.SQL.Clear;    
      Query.Params.Clear;
      Query.SQL.Add('INSERT INTO parameter (param_name, param_value) VALUES (:param_name, :param_value);');
      Query.Params.ParamByName('param_name').Value := PARAM_VERSION_NAME;
      Query.Params.ParamByName('param_value').Value := IntToStr(Version);
      Query.ExecSQL;
      Query.Close;
    end;

    // Create Project Type Table
    if Version <= 0 then
    begin
      Version := Version + 1;

      Query.SQL.Clear;
      Query.SQL.Add('CREATE TABLE IF NOT EXISTS project_type ( ');
      Query.SQL.Add('   id INTEGER PRIMARY KEY AUTOINCREMENT,  ');
      Query.SQL.Add('   code VARCHAR(100) NOT NULL);           ');
      Query.ExecSQL;
      Query.Close; 
      
      Query.SQL.Clear;    
      Query.Params.Clear;
      Query.SQL.Add('UPDATE parameter SET param_value = :param_value WHERE param_name = :param_name;');
      Query.Params.ParamByName('param_name').Value := PARAM_VERSION_NAME;
      Query.Params.ParamByName('param_value').Value := IntToStr(Version);
      Query.ExecSQL;
      Query.Close;
    end;
    
  finally
    Query.Free;
  end;
end;

function TdtmMainDataModule.ResendValidateMail(Hash: string): boolean;
var
  URI: string;
begin
  Result := False;

  if Hash = EmptyStr then
    Exit;

  URI := Format('%s/v1/users/resend-validate-email/%s', [CustomConfig.APIServer, Hash]);

  restClient.BaseURL := URI;
  restRequest.Method := rmPOST;
  restRequest.Body.ClearBody;
  restRequest.Params.Clear;

  restRequest.Execute;

  Result := restResponse.StatusCode = 200;
end;

function TdtmMainDataModule.ValidatedMail(Hash: string): boolean;
var
  URI: string;
  JsonResponse: TJSONObject;
begin
  Result := False;

  if Hash = EmptyStr then
    Exit;

  URI := Format('%s/v1/users/hash-login/%s', [CustomConfig.APIServer, Hash]);

  restClient.BaseURL := URI;
  restRequest.Method := rmPOST;
  restRequest.Body.ClearBody;
  restRequest.Params.Clear;

  restRequest.Execute;

  JsonResponse := TJSONObject.ParseJSONValue(restResponse.Content) as TJSONObject;
  try
    if restResponse.StatusCode = 200 then
      Result := JsonResponse.GetValue('validated').Value = 'true';
  finally
    JsonResponse.Free;
  end;
end;

end.
