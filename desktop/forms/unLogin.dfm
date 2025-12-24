object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 229
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
  object lblEmail: TLabel
    Left = 22
    Top = 24
    Width = 42
    Height = 15
    Caption = 'lblEmail'
  end
  object lblPassword: TLabel
    Left = 22
    Top = 88
    Width = 42
    Height = 15
    Caption = 'lblEmail'
  end
  object edtEmail: TEdit
    Left = 22
    Top = 45
    Width = 257
    Height = 23
    TabOrder = 0
  end
  object btnOK: TBitBtn
    Left = 52
    Top = 168
    Width = 89
    Height = 33
    Caption = 'OK'
    Default = True
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 164
    Top = 168
    Width = 89
    Height = 33
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 22
    Top = 109
    Width = 257
    Height = 23
    PasswordChar = '*'
    TabOrder = 3
  end
end
