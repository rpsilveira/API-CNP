object F_Principal: TF_Principal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 
    'Exemplo de integra'#231#227'o com a API do CNP - Cadastro Nacional de Pr' +
    'odutos'
  ClientHeight = 533
  ClientWidth = 1274
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
    Left = 55
    Top = 67
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = 'client ID:'
  end
  object Label2: TLabel
    Left = 64
    Top = 94
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'secret:'
    Transparent = True
  end
  object Label3: TLabel
    Left = 47
    Top = 121
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = 'username:'
  end
  object Label4: TLabel
    Left = 48
    Top = 148
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'password:'
  end
  object Label5: TLabel
    Left = 46
    Top = 175
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'CNPJ/CPF:'
  end
  object Label6: TLabel
    Left = 70
    Top = 202
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'GTIN:'
  end
  object Label7: TLabel
    Left = 412
    Top = 202
    Width = 233
    Height = 13
    Caption = '(deixe em branco para gerar o GTIN na inclus'#227'o)'
  end
  object Label8: TLabel
    Left = 412
    Top = 67
    Width = 217
    Height = 13
    Cursor = crHandPoint
    Caption = '(acesse https://apicnp.gs1br.org para obter)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label8Click
  end
  object Label9: TLabel
    Left = 412
    Top = 94
    Width = 217
    Height = 13
    Cursor = crHandPoint
    Caption = '(acesse https://apicnp.gs1br.org para obter)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label8Click
  end
  object Label10: TLabel
    Left = 67
    Top = 454
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'token:'
  end
  object Label11: TLabel
    Left = 17
    Top = 481
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = 'token v'#225'lido at'#233':'
  end
  object Label12: TLabel
    Left = 412
    Top = 454
    Width = 264
    Height = 13
    Caption = '(caso n'#227'o seja informado, um novo token ser'#225' gerado)'
  end
  object Label13: TLabel
    Left = 412
    Top = 481
    Width = 216
    Height = 13
    Caption = '(cada token gerado tem validade de 4 horas)'
  end
  object Label14: TLabel
    Left = 104
    Top = 404
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
  object Label38: TLabel
    Left = 50
    Top = 40
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'ambiente:'
  end
  object edtClientID: TEdit
    Left = 104
    Top = 64
    Width = 300
    Height = 21
    MaxLength = 36
    TabOrder = 1
  end
  object edtSecret: TEdit
    Left = 104
    Top = 91
    Width = 300
    Height = 21
    MaxLength = 36
    TabOrder = 2
  end
  object edtUsername: TEdit
    Left = 104
    Top = 118
    Width = 300
    Height = 21
    TabOrder = 3
  end
  object edtPassword: TEdit
    Left = 104
    Top = 145
    Width = 300
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtCnpjCpf: TEdit
    Left = 104
    Top = 172
    Width = 300
    Height = 21
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 5
  end
  object edtGTIN: TEdit
    Left = 104
    Top = 199
    Width = 300
    Height = 21
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 6
  end
  object edtToken: TEdit
    Left = 104
    Top = 451
    Width = 300
    Height = 21
    MaxLength = 36
    TabOrder = 10
  end
  object edtExpiration: TEdit
    Left = 104
    Top = 478
    Width = 300
    Height = 21
    TabOrder = 11
  end
  object Panel1: TPanel
    Left = 696
    Top = 8
    Width = 563
    Height = 486
    TabOrder = 12
    object Label15: TLabel
      Left = 25
      Top = 46
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'descri'#231#227'o:'
    end
    object Label16: TLabel
      Left = 18
      Top = 73
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'peso bruto:'
    end
    object Label17: TLabel
      Left = 32
      Top = 100
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'unidade:'
    end
    object Label18: TLabel
      Left = 15
      Top = 127
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = 'lan'#231'amento:'
    end
    object Label19: TLabel
      Left = 17
      Top = 154
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = '*segmento:'
    end
    object Label20: TLabel
      Left = 34
      Top = 181
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = '*fam'#237'lia:'
    end
    object Label21: TLabel
      Left = 35
      Top = 208
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = '*classe:'
    end
    object Label22: TLabel
      Left = 14
      Top = 235
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = '*sub-classe:'
    end
    object Label23: TLabel
      Left = 41
      Top = 262
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'marca:'
    end
    object Label24: TLabel
      Left = 298
      Top = 46
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = '**c'#243'd. pa'#237's:'
    end
    object Label25: TLabel
      Left = 289
      Top = 73
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = '**c'#243'd. l'#237'ngua:'
    end
    object Label26: TLabel
      Left = 287
      Top = 100
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = '**pa'#237's origem:'
    end
    object Label27: TLabel
      Left = 331
      Top = 127
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'NCM:'
    end
    object Label28: TLabel
      Left = 319
      Top = 154
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = 'modelo:'
    end
    object Label29: TLabel
      Left = 296
      Top = 181
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'status GTIN:'
    end
    object Label30: TLabel
      Left = 308
      Top = 208
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'tipo GTIN:'
    end
    object Label31: TLabel
      Left = 316
      Top = 235
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'ag'#234'ncia:'
    end
    object Label32: TLabel
      Left = 287
      Top = 262
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = 'nome ag'#234'ncia:'
    end
    object Label33: TLabel
      Left = 45
      Top = 289
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEST:'
    end
    object Label34: TLabel
      Left = 314
      Top = 289
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'imagens:'
    end
    object Label35: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 555
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Dados do produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 100
    end
    object Label36: TLabel
      Left = 17
      Top = 443
      Width = 287
      Height = 11
      Cursor = crHandPoint
      Caption = 
        '* de acordo com o GPC (https://www.gs1.org/services/gpc-browser)' +
        ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic, fsUnderline]
      ParentFont = False
      OnClick = Label36Click
    end
    object Label37: TLabel
      Left = 17
      Top = 460
      Width = 306
      Height = 11
      Cursor = crHandPoint
      Caption = 
        '** consulte a se'#231#227'o de anexos (https://apicnp.gs1br.org/api-port' +
        'al/node/7) '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic, fsUnderline]
      ParentFont = False
      OnClick = Label37Click
    end
    object edtDescricao: TEdit
      Left = 80
      Top = 43
      Width = 180
      Height = 21
      TabOrder = 0
      Text = 'descri'#231#227'o do produto'
    end
    object edtPeso: TEdit
      Left = 80
      Top = 70
      Width = 180
      Height = 21
      TabOrder = 1
      Text = '1,234'
    end
    object edtUnidade: TEdit
      Left = 80
      Top = 97
      Width = 180
      Height = 21
      MaxLength = 3
      TabOrder = 2
      Text = 'L'
    end
    object edtLancamento: TEdit
      Left = 80
      Top = 124
      Width = 180
      Height = 21
      TabOrder = 3
      Text = '01/01/2019 12:00'
    end
    object edtSegmento: TEdit
      Left = 80
      Top = 151
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 4
      Text = '63000000'
    end
    object edtFamilia: TEdit
      Left = 80
      Top = 178
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 5
      Text = '63010000'
    end
    object edtClasse: TEdit
      Left = 80
      Top = 205
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 6
      Text = '63010300'
    end
    object edtSubclasse: TEdit
      Left = 80
      Top = 232
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 7
      Text = '10001077'
    end
    object edtMarca: TEdit
      Left = 80
      Top = 259
      Width = 180
      Height = 21
      TabOrder = 8
      Text = 'marca do produto'
    end
    object edtCodPais: TEdit
      Left = 363
      Top = 43
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 10
      Text = '076'
    end
    object edtCodLingua: TEdit
      Left = 363
      Top = 70
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 11
      Text = '348'
    end
    object edtPaisOrigem: TEdit
      Left = 363
      Top = 97
      Width = 180
      Height = 21
      NumbersOnly = True
      TabOrder = 12
      Text = '76'
    end
    object edtNCM: TEdit
      Left = 363
      Top = 124
      Width = 180
      Height = 21
      TabOrder = 13
      Text = '3815.12.10'
    end
    object edtModelo: TEdit
      Left = 363
      Top = 151
      Width = 180
      Height = 21
      TabOrder = 14
      Text = 'modelo do produto'
    end
    object cbxStatusGTIN: TComboBox
      Left = 363
      Top = 178
      Width = 180
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 15
      Text = 'Ativo'
      Items.Strings = (
        'Nenhum'
        'Ativo'
        'Cancelado'
        'Suspenso'
        'Reativado')
    end
    object cbxTipoGTIN: TComboBox
      Left = 363
      Top = 205
      Width = 180
      Height = 21
      Style = csDropDownList
      ItemIndex = 3
      TabOrder = 16
      Text = 'GTIN-13'
      Items.Strings = (
        'Nenhum'
        'GTIN-8'
        'GTIN-12'
        'GTIN-13'
        'GTIN-14')
    end
    object cbxAgencia: TComboBox
      Left = 363
      Top = 232
      Width = 180
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 17
      Text = 'Nenhuma'
      Items.Strings = (
        'Nenhuma'
        'ANVISA'
        'INMETRO'
        'ANATEL'
        'MAPA')
    end
    object edtAgencia: TEdit
      Left = 363
      Top = 259
      Width = 180
      Height = 21
      TabOrder = 18
    end
    object memImagens: TMemo
      Left = 363
      Top = 286
      Width = 180
      Height = 130
      Lines.Strings = (
        'url imagem 1'
        'url imagem 2'
        'url imagem 3')
      ScrollBars = ssBoth
      TabOrder = 19
    end
    object memCEST: TMemo
      Left = 80
      Top = 286
      Width = 180
      Height = 130
      Lines.Strings = (
        '20.042.00'
        '01.047.00')
      ScrollBars = ssVertical
      TabOrder = 9
    end
  end
  object Button1: TButton
    Left = 104
    Top = 250
    Width = 80
    Height = 30
    Caption = 'Incluir'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 214
    Top = 250
    Width = 80
    Height = 30
    Caption = 'Alterar'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 324
    Top = 250
    Width = 80
    Height = 30
    Caption = 'Consultar'
    TabOrder = 9
    OnClick = Button3Click
  end
  object cbxAmbiente: TComboBox
    Left = 104
    Top = 37
    Width = 300
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 0
    Text = 'Homologa'#231#227'o'
    Items.Strings = (
      'Produ'#231#227'o'
      'Homologa'#231#227'o')
  end
end
