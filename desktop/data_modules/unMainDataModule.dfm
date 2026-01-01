object dtmMainDataModule: TdtmMainDataModule
  OnCreate = DataModuleCreate
  Height = 240
  Width = 393
  object restClient: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 48
    Top = 24
  end
  object restRequest: TRESTRequest
    Client = restClient
    Params = <>
    Response = restResponse
    SynchronizedEvents = False
    Left = 224
    Top = 24
  end
  object restResponse: TRESTResponse
    Left = 136
    Top = 24
  end
  object fdcDatabase: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 128
  end
  object fdcDriverLink: TFDPhysSQLiteDriverLink
    Left = 144
    Top = 128
  end
end
