object dtmMainDataModule: TdtmMainDataModule
  Height = 480
  Width = 640
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
end
