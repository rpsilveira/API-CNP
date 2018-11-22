{******************************************************************************}
{ Classe para integra��o com o CNP (Cadastro Nacional de Produtos) atrav�s de  }
{ consumo de API disponibilizada para esta finalidade.                         }
{                                                                              }
{ Conforme Nota T�cnica 2017.001, da Nota Fiscal Eletr�nica:                   }
{                                                                              }
{"O Cadastro Centralizado de GTIN (CCG) � um banco de dados contendo um conjun-}
{to reduzido de informa��es dos produtos que possuem o c�digo de barras GTIN em}
{suas embalagens, e funciona de forma integrada com o CNP (Cadastro Nacional de}
{Produtos da GS1), que � o cadastro mantido pela organiza��o legalmente respon-}
{s�vel pelo licenciamento do respectivo c�digo de barras. Os produtos em circu-}
{la��o no mercado que possuem GTIN e que s�o informados nos documentos fiscais }
{eletr�nicos, NF-e e NFC-e, ter�o suas informa��es validadas no CCG, de acordo }
{com o cronograma previsto na legisla��o. Portanto, os donos das marcas dos    }
{produtos que possuem GTIN dever�o manter atualizados os dados cadastrais de   }
{seus produtos junto ao CNP (em cnp.gs1br.org/), de forma a manter atualizado o}
{Cadastro Centralizado de GTIN."
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com                              }
{ Franca-SP nov/2018                                                           }
{******************************************************************************}

unit U_API_GS1;

interface

uses Classes, SysUtils, StrUtils, DateUtils, IdHTTP, IdSSLOpenSSL, DBXJSON,
  U_Conversao;

type
  Imagem = class(TCollectionItem)
  private
    FTipoURL: TTipoURL;
    FURL: String;
    FNome: String;
    procedure SetTipoURL(const Value: TTipoURL);
    procedure SetNome(const Value: String);
    procedure SetURL(const Value: String);
  published
    property URL: String read FURL write SetURL;
    property Nome: String read FNome write SetNome;
    property TipoURL: TTipoURL read FTipoURL write SetTipoURL default tuProduto;
  end;

  CEST = class(TCollectionItem)
  private
    FCodigo: String;
    procedure SetCodigo(const Value: String);
  published
    property Codigo: String read FCodigo write SetCodigo;
  end;

  TImagens = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): Imagem;
    procedure SetItem(Index: Integer; const Value: Imagem);
  public
    function Add: Imagem;
    property Items[index: Integer]: Imagem read GetItem write SetItem;
  end;

  TCESTs = class(TOwnedCollection)
  private
    function GetItem(Index: integer): CEST;
    procedure SetItem(Index: integer; const Value: CEST);
  public
    function Add: CEST;
    property Items[index: Integer]: CEST read GetItem write SetItem;
  end;

  TConfiguracoes = class(TComponent)
  private
    FExpiration: TDateTime;
    FCNPJ_CPF: String;
    FClientID: String;
    FSecret: String;
    FToken: String;
    FPassword: String;
    FUsername: String;
    FAmbiente: TAmbiente;
    procedure SetClientID(const Value: String);
    procedure SetCNPJ_CPF(const Value: String);
    procedure SetExpiration(const Value: TDateTime);
    procedure SetPassword(const Value: String);
    procedure SetSecret(const Value: String);
    procedure SetToken(const Value: String);
    procedure SetUsername(const Value: String);
    procedure SetAmbiente(const Value: TAmbiente);
  published
    property ClientID: String read FClientID write SetClientID;
    property Secret: String read FSecret write SetSecret;
    property Token: String read FToken write SetToken;
    property Expiration: TDateTime read FExpiration write SetExpiration;
    property Username: String read FUsername write SetUsername;
    property Password: String read FPassword write SetPassword;
    property CNPJ_CPF: String read FCNPJ_CPF write SetCNPJ_CPF;
    property Ambiente: TAmbiente read FAmbiente write SetAmbiente default taHomologacao;
  end;

  TAPI_GS1 = class(TComponent)
  private
    { private declarations }
    IdHTTP: TIdHTTP;
    IdIOSocket: TIdSSLIOHandlerSocketOpenSSL;

    FStatusGTIN: TStatusGTIN;
    FPesoBruto: Double;
    FImagens: TImagens;
    FCodigoPais: String;
    FCodigoLingua: String;
    FIdAgencia: Integer;
    FTipoGTIN: TTipoGTIN;
    FSegmento: Integer;
    FDescricao: String;
    FModelo: String;
    FFamilia: Integer;
    FGTIN: String;
    FUnidadeMedida: String;
    FNCM: String;
    FSubclasse: Integer;
    FClasse: Integer;
    FNomeAgencia: String;
    FConfiguracoes: TConfiguracoes;
    FMarca: String;
    FAceiteTermo: Boolean;
    FPaisOrigem: Integer;
    FDataLancamento: TDateTime;
    FCompartilhaDados: Boolean;
    FCESTs: TCESTs;
    procedure SetAceiteTermo(const Value: Boolean);
    procedure SetClasse(const Value: Integer);
    procedure SetCodigoLingua(const Value: String);
    procedure SetCodigoPais(const Value: String);
    procedure SetCompartilhaDados(const Value: Boolean);
    procedure SetConfiguracoes(const Value: TConfiguracoes);
    procedure SetDataLancamento(const Value: TDateTime);
    procedure SetDescricao(const Value: String);
    procedure SetFamilia(const Value: Integer);
    procedure SetGTIN(const Value: String);
    procedure SetIdAgencia(const Value: Integer);
    procedure SetImagens(const Value: TImagens);
    procedure SetMarca(const Value: String);
    procedure SetModelo(const Value: String);
    procedure SetNCM(const Value: String);
    procedure SetNomeAgencia(const Value: String);
    procedure SetPaisOrigem(const Value: Integer);
    procedure SetPesoBruto(const Value: Double);
    procedure SetSegmento(const Value: Integer);
    procedure SetStatusGTIN(const Value: TStatusGTIN);
    procedure SetSubclasse(const Value: Integer);
    procedure SetTipoGTIN(const Value: TTipoGTIN);
    procedure SetUnidadeMedida(const Value: String);
    procedure SetCESTs(const Value: TCESTs);
  protected
    { protected declarations }
    function GetJson: String;
    function Send(pTipoReq: TTipoRequisicao): Boolean;
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property GTIN: String read FGTIN write SetGTIN;
    property AceiteTermo: Boolean read FAceiteTermo write SetAceiteTermo default True;
    property Descricao: String read FDescricao write SetDescricao;
    property PesoBruto: Double read FPesoBruto write SetPesoBruto;
    property UnidadeMedida: String read FUnidadeMedida write SetUnidadeMedida;
    property Imagens: TImagens read FImagens write SetImagens;
    property DataLancamento: TDateTime read FDataLancamento write SetDataLancamento;
    property StatusGTIN: TStatusGTIN read FStatusGTIN write SetStatusGTIN default stAtivo;
    property CESTs: TCESTs read FCESTs write SetCESTs;
    property Segmento: Integer read FSegmento write SetSegmento;
    property Familia: Integer read FFamilia write SetFamilia;
    property Classe: Integer read FClasse write SetClasse;
    property Subclasse: Integer read FSubclasse write SetSubclasse;
    property Marca: String read FMarca write SetMarca;
    property CodigoPais: String read FCodigoPais write SetCodigoPais;
    property CodigoLingua: String read FCodigoLingua write SetCodigoLingua;
    property PaisOrigem: Integer read FPaisOrigem write SetPaisOrigem;
    property CompartilhaDados: Boolean read FCompartilhaDados write SetCompartilhaDados default True;
    property NCM: String read FNCM write SetNCM;
    property Modelo: String read FModelo write SetModelo;
    property TipoGTIN: TTipoGTIN read FTipoGTIN write SetTipoGTIN default tgGTIN13;
    property IdAgencia: Integer read FIdAgencia write SetIdAgencia;
    property NomeAgencia: String read FNomeAgencia write SetNomeAgencia;

    function Incluir: Boolean;
    function Alterar: Boolean;
    function ObtemToken: Boolean;
  published
    { published declarations }
    property Configuracoes: TConfiguracoes read FConfiguracoes write SetConfiguracoes;
  end;

resourcestring
  URL_TOKEN = 'https://api.gs1br.org/oauth/access-token';
  URL_PRODUCAO = 'https://api.gs1br.org/product';
  URL_HOMOLOGACAO = 'https://api-hml.gs1br.org/product';
  isRequired = 'is required!';

implementation

{ TAPI_GS1 }

constructor TAPI_GS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImagens := TImagens.Create(Self, Imagem);
  FCESTs := TCESTs.Create(Self, CEST);
  FConfiguracoes := TConfiguracoes.Create(Self);
  IdHTTP := TIdHTTP.Create(Self);
  IdIOSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Self);

  IdHTTP.IOHandler := IdIOSocket;
  IdHTTP.Request.BasicAuthentication := True;
  IdHTTP.Request.ContentType  := 'application/json';
  IdHTTP.Request.CharSet      := 'UTF-8';
  IdHTTP.Response.ContentType := 'application/json';
  IdHTTP.Response.CharSet     := 'UTF-8';
end;

destructor TAPI_GS1.Destroy;
begin
  FImagens.Free;
  FCESTs.Free;
  FConfiguracoes.Free;
  IdHTTP.Free;
  IdIOSocket.Free;
  inherited;
end;

function TAPI_GS1.GetJson: String;
var
  i: Integer;
begin
  Result :=
  '{"product":{'+
  IfThen(GTIN <> '', Format('    "globalTradeItemNumber": "%s",', [GTIN]))+
  Format('    "responsibilityStatement": "%s",', [IfThen(AceiteTermo, 'S', 'N')])+
  Format('    "productDescription": "%s",', [Descricao])+
  Format('    "grossWeight": %s,', [FloatToString(PesoBruto)])+
  Format('    "grossWeightMeasurementUnitCode": "%s",', [UnidadeMedida]);

  if Imagens.Count > 0 then
  begin
    Result := Result +
    '    "images":[';

    for i := 0 to Imagens.Count -1 do
    begin
      Result := Result +
      '      {'+
      Format('        "URL": "%s",', [Imagens.Items[i].URL])+
      Format('        "Nome": "%s",', [Imagens.Items[i].Nome])+
      Format('        "CodigoTipoURL": %d', [TipoUrlToInt(Imagens.Items[i].TipoURL)])+
      '      }' + IfThen(i < Imagens.Count -1, ',');
    end;

    Result := Result +
    '],';
  end;

  if CESTs.Count > 0 then
  begin
    Result := Result +
    '    "CEST":[';

    for i := 0 to CESTs.Count -1 do
    begin
      Result := Result + Format('"%s"', [CESTs.Items[i].Codigo])+
      IfThen(i < CESTs.Count -1, ',');
    end;

    Result := Result +
    '],';
  end;

  Result := Result +
  Format('    "startAvailabilityDateTime": "%s",', [FormatDateTime('dd/mm/yyyy-hh:nn', DataLancamento)])+
  Format('    "CodigoStatusGTIN": %d,', [StatusGtinToInt(StatusGTIN)])+
  Format('    "CodeSegment": %d,', [Segmento])+
  Format('    "CodeFamily": %d,', [Familia])+
  Format('    "CodeClass": %d,', [Classe])+
  Format('    "CodeBrick": %d,', [Subclasse])+
  Format('    "brandName": "%s",', [marca])+
  Format('    "countryCode": "%s",', [CodigoPais])+
  Format('    "CodigoLingua": "%s",', [CodigoLingua])+
  Format('    "tradeItemCountryOfOrigin": %d,', [PaisOrigem])+
  Format('    "IndicadorCompartilhaDados": %d,', [Integer(CompartilhaDados)])+
  Format('    "importClassificationValue": "%s",', [NCM])+
  Format('    "modelNumber": "%s",', [Modelo])+
  Format('    "CodigoTipoGTIN": %d,', [TipoGtinToInt(TipoGTIN)])+
  '    "agency": {'+
  Format('      "id": %d,', [IdAgencia])+
  Format('      "alternateItemIdentificationId": "%s"', [NomeAgencia])+
  '    }'+
  '  }'+
  '}';
end;

function TAPI_GS1.ObtemToken: Boolean;
var
  JsonStreamRetorno, JsonStreamEnvio: TStringStream;
  JsonObj: TJSONObject;
  JsonPair: TJSONPair;
  dthr: TDateTime;
  json: String;
begin
  if Configuracoes.Username = '' then
    raise Exception.CreateFmt('Username %s', [isRequired]);
  if Configuracoes.Password = '' then
    raise Exception.CreateFmt('Password %s', [isRequired]);
  if Configuracoes.CNPJ_CPF = '' then
    raise Exception.CreateFmt('CNPJ/CPF %s', [isRequired]);
  if Configuracoes.ClientID = '' then
    raise Exception.CreateFmt('ClientID %s', [isRequired]);
  if Configuracoes.Secret = '' then
    raise Exception.CreateFmt('Secret %s', [isRequired]);

  json := '{"grant_type": "password",'+
  Format('"username" : "%s",', [Configuracoes.Username])+
  Format('"password" : "%s",', [Configuracoes.Password])+
  Format('"cpfCnpj" : "%s"}', [Configuracoes.CNPJ_CPF]);

  JsonStreamEnvio   := TStringStream.Create(json, TEncoding.UTF8);
  JsonStreamRetorno := TStringStream.Create('', TEncoding.UTF8);
  Result := False;

  try
    IdHTTP.Request.Username := Configuracoes.ClientID;
    IdHTTP.Request.Password := Configuracoes.Secret;

    try
      dthr := Now;

      IdHTTP.Post(URL_TOKEN, JsonStreamEnvio, JsonStreamRetorno);
      JsonStreamRetorno.Position := 0;

      try
        JsonObj := TJSONObject.ParseJSONValue(JsonStreamRetorno.DataString) as TJSONObject;
      except
        raise Exception.Create(JsonStreamRetorno.DataString);
      end;

      JsonPair := JsonObj.Get('access_token');

      if Assigned(JsonPair) then
        Configuracoes.Token := StringReplace(JsonPair.JsonValue.ToString, '"', '', [rfReplaceAll]);

      JsonPair := JsonObj.Get('expires_in');

      if Assigned(JsonPair) then
        Configuracoes.Expiration := IncSecond(dthr, StrToIntDef(JsonPair.JsonValue.ToString,0));

      Result := (Configuracoes.Token <> '') and (Configuracoes.Expiration > dthr);
    except
      on E: EIdHTTPProtocolException do
        raise Exception.Create(E.ErrorMessage);
    end;
  finally
    JsonStreamEnvio.Free;
    JsonStreamRetorno.Free;
  end;
end;

function TAPI_GS1.Alterar: Boolean;
begin
  Result := Send(trPUT);
end;

function TAPI_GS1.Incluir: Boolean;
begin
  Result := Send(trPOST);
end;

function TAPI_GS1.Send(pTipoReq: TTipoRequisicao): Boolean;
var
  JsonStreamRetorno, JsonStreamEnvio: TStringStream;
  JsonObj: TJSONObject;
  JsonPair: TJSONPair;
begin
  Result := False;

  JsonStreamEnvio   := TStringStream.Create(GetJson, TEncoding.UTF8);
  JsonStreamRetorno := TStringStream.Create('', TEncoding.UTF8);

  if Configuracoes.ClientID = '' then
    raise Exception.CreateFmt('ClientID %s', [isRequired]);
  if (pTipoReq = trPUT) and (GTIN = '') then
    raise Exception.CreateFmt('GTIN %s', [isRequired]);

  if (Configuracoes.Token = '') or (Configuracoes.Expiration < Now) then
    ObtemToken;

  try
    IdHTTP.Request.CustomHeaders.Clear;
    IdHTTP.Request.CustomHeaders.AddValue('client_id', Configuracoes.ClientID);
    IdHTTP.Request.CustomHeaders.AddValue('access_token', Configuracoes.Token);

    try
      case Configuracoes.Ambiente of
        taProducao :
          case pTipoReq of
            trPOST: IdHTTP.Post(URL_PRODUCAO, JsonStreamEnvio, JsonStreamRetorno);  //incluir
            trPUT : IdHTTP.Put(URL_PRODUCAO, JsonStreamEnvio, JsonStreamRetorno);   //alterar
          end;
        taHomologacao:
          case pTipoReq of
            trPOST: IdHTTP.Post(URL_HOMOLOGACAO, JsonStreamEnvio, JsonStreamRetorno);
            trPUT : IdHTTP.Put(URL_HOMOLOGACAO, JsonStreamEnvio, JsonStreamRetorno);
          end;
      end;
    except
      on E: EIdHTTPProtocolException do
        raise Exception.Create(E.ErrorMessage);
    end;

    JsonStreamRetorno.Position := 0;

    try
      JsonObj := TJSONObject.ParseJSONValue(JsonStreamRetorno.DataString) as TJSONObject;
    except
      raise Exception.Create(JsonStreamRetorno.DataString);
    end;

    if Assigned(JsonObj) then
    begin
      JsonPair := JsonObj.Get('globalTradeItemNumber');

      if Assigned(JsonPair) then
      begin
        GTIN := Trim(StringReplace(JsonPair.JsonValue.ToString, '"', '', [rfReplaceAll]));
        Result := GTIN <> '';
      end;
    end;
  finally
    JsonStreamEnvio.Free;
    JsonStreamRetorno.Free;
  end;
end;

procedure TAPI_GS1.SetAceiteTermo(const Value: Boolean);
begin
  FAceiteTermo := Value;
end;

procedure TAPI_GS1.SetCESTs(const Value: TCESTs);
begin
  FCESTs := Value;
end;

procedure TAPI_GS1.SetClasse(const Value: Integer);
begin
  FClasse := Value;
end;

procedure TAPI_GS1.SetCodigoLingua(const Value: String);
begin
  FCodigoLingua := Trim(Value);
end;

procedure TAPI_GS1.SetCodigoPais(const Value: String);
begin
  FCodigoPais := Trim(Value);
end;

procedure TAPI_GS1.SetCompartilhaDados(const Value: Boolean);
begin
  FCompartilhaDados := Value;
end;

procedure TAPI_GS1.SetConfiguracoes(const Value: TConfiguracoes);
begin
  FConfiguracoes := Value;
end;

procedure TAPI_GS1.SetDataLancamento(const Value: TDateTime);
begin
  FDataLancamento := Value;
end;

procedure TAPI_GS1.SetDescricao(const Value: String);
begin
  FDescricao := Trim(Value);
end;

procedure TAPI_GS1.SetFamilia(const Value: Integer);
begin
  FFamilia := Value;
end;

procedure TAPI_GS1.SetGTIN(const Value: String);
begin
  FGTIN := Trim(Value);
end;

procedure TAPI_GS1.SetIdAgencia(const Value: Integer);
begin
  FIdAgencia := Value;
end;

procedure TAPI_GS1.SetImagens(const Value: TImagens);
begin
  FImagens := Value;
end;

procedure TAPI_GS1.SetMarca(const Value: String);
begin
  FMarca := Trim(Value);
end;

procedure TAPI_GS1.SetModelo(const Value: String);
begin
  FModelo := Trim(Value);
end;

procedure TAPI_GS1.SetNCM(const Value: String);
begin
  FNCM := Trim(Value);
end;

procedure TAPI_GS1.SetNomeAgencia(const Value: String);
begin
  FNomeAgencia := Trim(Value);
end;

procedure TAPI_GS1.SetPaisOrigem(const Value: Integer);
begin
  FPaisOrigem := Value;
end;

procedure TAPI_GS1.SetPesoBruto(const Value: Double);
begin
  FPesoBruto := Value;
end;

procedure TAPI_GS1.SetSegmento(const Value: Integer);
begin
  FSegmento := Value;
end;

procedure TAPI_GS1.SetStatusGTIN(const Value: TStatusGTIN);
begin
  FStatusGTIN := Value;
end;

procedure TAPI_GS1.SetSubclasse(const Value: Integer);
begin
  FSubclasse := Value;
end;

procedure TAPI_GS1.SetTipoGTIN(const Value: TTipoGTIN);
begin
  FTipoGTIN := Value;
end;

procedure TAPI_GS1.SetUnidadeMedida(const Value: String);
begin
  FUnidadeMedida := Trim(Value);
end;

{ Imagem }

procedure Imagem.SetTipoURL(const Value: TTipoURL);
begin
  FTipoURL := Value;
end;

procedure Imagem.SetNome(const Value: String);
begin
  FNome := Trim(Value);
end;

procedure Imagem.SetURL(const Value: String);
begin
  FURL := Value;
end;

{ TImagens }

function TImagens.Add: Imagem;
begin
  Result := Imagem(inherited Add);
end;

function TImagens.GetItem(Index: Integer): Imagem;
begin
  Result := Imagem(inherited Items[Index]);
end;

procedure TImagens.SetItem(Index: Integer; const Value: Imagem);
begin
  Items[Index].Assign(Value);
end;

{ TConfiguracoes }

procedure TConfiguracoes.SetAmbiente(const Value: TAmbiente);
begin
  FAmbiente := Value;
end;

procedure TConfiguracoes.SetClientID(const Value: String);
begin
  FClientID := Value;
end;

procedure TConfiguracoes.SetCNPJ_CPF(const Value: String);
begin
  FCNPJ_CPF := Value;
end;

procedure TConfiguracoes.SetExpiration(const Value: TDateTime);
begin
  FExpiration := Value;
end;

procedure TConfiguracoes.SetPassword(const Value: String);
begin
  FPassword := Value;
end;

procedure TConfiguracoes.SetSecret(const Value: String);
begin
  FSecret := Value;
end;

procedure TConfiguracoes.SetToken(const Value: String);
begin
  FToken := Value;
end;

procedure TConfiguracoes.SetUsername(const Value: String);
begin
  FUsername := Value;
end;

{ TCESTs }

function TCESTs.Add: CEST;
begin
  Result := CEST(inherited Add);
end;

function TCESTs.GetItem(Index: integer): CEST;
begin
  Result := CEST(inherited Items[Index]);
end;

procedure TCESTs.SetItem(Index: integer; const Value: CEST);
begin
  Items[Index].Assign(Value);
end;

{ CEST }

procedure CEST.SetCodigo(const Value: String);
begin
  FCodigo := Trim(Value);
end;

end.