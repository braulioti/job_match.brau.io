unit unMainDataModule;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Phys.SQLiteWrapper.Stat, Data.DB,
  FireDAC.Comp.Client;

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
  end;

var
  dtmMainDataModule: TdtmMainDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Config, Utils;

{$R *.dfm}

procedure TdtmMainDataModule.DataModuleCreate(Sender: TObject);
begin
  fdcDriverLink.VendorLib := Format('%s/dll/sqlite3.dll', [Utils.ExePath]);
  fdcDatabase.Params.Database := Format('%s/database.match', [Utils.ExePath]);
  fdcDatabase.Connected := true;
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
