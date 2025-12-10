object MDIChild: TMDIChild
  Left = 197
  Top = 117
  Caption = 'MDI Child'
  ClientHeight = 169
  ClientWidth = 274
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  OnClose = FormClose
  TextHeight = 15
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 274
    Height = 169
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    WordWrap = False
  end
end
