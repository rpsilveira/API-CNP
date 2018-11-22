object F_Principal: TF_Principal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Integra'#231#227'o com a API do CNP - Cadastro Nacional de Produtos'
  ClientHeight = 539
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 60
    Top = 32
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = 'client ID:'
  end
  object Label2: TLabel
    Left = 69
    Top = 59
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'secret:'
    Transparent = True
  end
  object Label3: TLabel
    Left = 52
    Top = 86
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = 'username:'
  end
  object Label4: TLabel
    Left = 53
    Top = 113
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'password:'
  end
  object Label5: TLabel
    Left = 51
    Top = 140
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'CNPJ/CPF:'
  end
  object Label6: TLabel
    Left = 75
    Top = 167
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'GTIN:'
  end
  object Label7: TLabel
    Left = 417
    Top = 167
    Width = 231
    Height = 13
    Caption = '*deixe em branco para gerar o GTIN na inclus'#227'o'
  end
  object Label8: TLabel
    Left = 417
    Top = 32
    Width = 215
    Height = 13
    Cursor = crHandPoint
    Caption = '*acesse https://apicnp.gs1br.org para obter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label8Click
  end
  object Label9: TLabel
    Left = 417
    Top = 59
    Width = 215
    Height = 13
    Cursor = crHandPoint
    Caption = '*acesse https://apicnp.gs1br.org para obter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label8Click
  end
  object Label10: TLabel
    Left = 72
    Top = 455
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'token:'
  end
  object Label11: TLabel
    Left = 22
    Top = 482
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = 'token v'#225'lido at'#233':'
  end
  object Label12: TLabel
    Left = 417
    Top = 455
    Width = 262
    Height = 13
    Caption = '*caso n'#227'o seja informado, um novo token ser'#225' gerado'
  end
  object Label13: TLabel
    Left = 417
    Top = 482
    Width = 214
    Height = 13
    Caption = '*cada token gerado tem validade de 4 horas'
  end
  object Label14: TLabel
    Left = 109
    Top = 405
    Width = 517
    Height = 26
    Alignment = taCenter
    Caption = 
      'Para evitar de gerar um novo token a cada requisi'#231#227'o (n'#227'o recome' +
      'nd'#225'vel), '#13#10'armazene o token e a data de expira'#231#227'o no banco de da' +
      'dos e utilize nas requisi'#231#245'es futuras'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object edtClientID: TEdit
    Left = 109
    Top = 29
    Width = 300
    Height = 21
    MaxLength = 36
    TabOrder = 0
  end
  object edtSecret: TEdit
    Left = 109
    Top = 56
    Width = 300
    Height = 21
    MaxLength = 36
    TabOrder = 1
  end
  object edtUsername: TEdit
    Left = 109
    Top = 83
    Width = 300
    Height = 21
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 109
    Top = 110
    Width = 300
    Height = 21
    TabOrder = 3
  end
  object edtCnpjCpf: TEdit
    Left = 109
    Top = 137
    Width = 300
    Height = 21
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 4
  end
  object btnEnvia: TButton
    Left = 109
    Top = 318
    Width = 300
    Height = 35
    Caption = 'Enviar'
    TabOrder = 8
    OnClick = btnEnviaClick
  end
  object edtGTIN: TEdit
    Left = 109
    Top = 164
    Width = 300
    Height = 21
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 5
  end
  object rgOperacao: TRadioGroup
    Left = 109
    Top = 255
    Width = 300
    Height = 41
    Caption = ' opera'#231#227'o '
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Inclus'#227'o'
      'Altera'#231#227'o')
    TabOrder = 7
  end
  object rgGTIN: TRadioGroup
    Left = 109
    Top = 199
    Width = 300
    Height = 41
    Caption = ' tipo '
    Columns = 4
    ItemIndex = 2
    Items.Strings = (
      'GTIN-8'
      'GTIN-12'
      'GTIN-13'
      'GTIN-14')
    TabOrder = 6
  end
  object edtToken: TEdit
    Left = 109
    Top = 452
    Width = 300
    Height = 21
    MaxLength = 36
    TabOrder = 9
  end
  object edtExpiration: TEdit
    Left = 109
    Top = 479
    Width = 300
    Height = 21
    TabOrder = 10
  end
end
