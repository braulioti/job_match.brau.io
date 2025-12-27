object frmValidateAccount: TfrmValidateAccount
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Validate Account'
  ClientHeight = 204
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object lblValidateAccount: TLabel
    Left = 17
    Top = 32
    Width = 347
    Height = 89
    Alignment = taCenter
    AutoSize = False
    WordWrap = True
  end
  object btnSendEmail: TBitBtn
    Left = 35
    Top = 144
    Width = 89
    Height = 33
    Caption = 'Send E-mail'
    Default = True
    NumGlyphs = 2
    TabOrder = 0
    OnClick = btnSendEmailClick
  end
  object btnValidate: TBitBtn
    Left = 147
    Top = 144
    Width = 89
    Height = 33
    Caption = 'Validate'
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnValidateClick
  end
  object btnClose: TBitBtn
    Left = 257
    Top = 144
    Width = 89
    Height = 33
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
  end
end
