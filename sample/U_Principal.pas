{******************************************************************************}
{ Classe para integração com o CNP (Cadastro Nacional de Produtos) através de  }
{ consumo de API disponibilizada para esta finalidade.                         }
{                                                                              }
{ Conforme Nota Técnica 2017.001, da Nota Fiscal Eletrônica:                   }
{                                                                              }
{"O Cadastro Centralizado de GTIN (CCG) é um banco de dados contendo um conjun-}
{to reduzido de informações dos produtos que possuem o código de barras GTIN em}
{suas embalagens, e funciona de forma integrada com o CNP (Cadastro Nacional de}
{Produtos da GS1), que é o cadastro mantido pela organização legalmente respon-}
{sável pelo licenciamento do respectivo código de barras. Os produtos em circu-}
{lação no mercado que possuem GTIN e que são informados nos documentos fiscais }
{eletrônicos, NF-e e NFC-e, terão suas informações validadas no CCG, de acordo }
{com o cronograma previsto na legislação. Portanto, os donos das marcas dos    }
{produtos que possuem GTIN deverão manter atualizados os dados cadastrais de   }
{seus produtos junto ao CNP (em cnp.gs1br.org/), de forma a manter atualizado o}
{Cadastro Centralizado de GTIN."
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com                              }
{ Franca-SP nov/2018                                                           }
{******************************************************************************}

unit U_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi,
  Vcl.ComCtrls, Vcl.Grids, U_API_GS1, U_Conversao;

type
  TF_Principal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtClientID: TEdit;
    edtSecret: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtCnpjCpf: TEdit;
    edtGTIN: TEdit;
    edtToken: TEdit;
    edtExpiration: TEdit;
    Panel1: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtDescricao: TEdit;
    edtPeso: TEdit;
    edtUnidade: TEdit;
    edtLancamento: TEdit;
    edtSegmento: TEdit;
    edtFamilia: TEdit;
    edtClasse: TEdit;
    edtSubclasse: TEdit;
    edtMarca: TEdit;
    edtCodPais: TEdit;
    edtCodLingua: TEdit;
    edtPaisOrigem: TEdit;
    edtNCM: TEdit;
    edtModelo: TEdit;
    cbxStatusGTIN: TComboBox;
    cbxTipoGTIN: TComboBox;
    cbxAgencia: TComboBox;
    edtAgencia: TEdit;
    memImagens: TMemo;
    memCEST: TMemo;
    Label35: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    cbxAmbiente: TComboBox;
    procedure Label8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Label36Click(Sender: TObject);
    procedure Label37Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;
  api: TAPI_GS1;

implementation

{$R *.dfm}

procedure TF_Principal.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  api.Configuracoes.ClientID := edtClientID.Text;  //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Secret   := edtSecret.Text;    //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Username := edtUsername.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.Password := edtPassword.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.CNPJ_CPF := edtCnpjCpf.Text;

  case cbxAmbiente.ItemIndex of
    0: api.Configuracoes.Ambiente := taProducao;
    1: api.Configuracoes.Ambiente := taHomologacao;
  end;

  //Caso o token esteja vazio ou expirado, será gerado um novo automaticamente.
  //Salve o último token gerado e sua data de expiração no banco de dados.
  //Preencha os dados salvos nas 2 properties abaixo:
  api.Configuracoes.Token := edtToken.Text;
  if edtExpiration.Text <> '' then
    api.Configuracoes.Expiration := StrToDateTime(edtExpiration.Text);

  case cbxTipoGTIN.ItemIndex of
    1: api.TipoGTIN := tgGTIN8;
    2: api.TipoGTIN := tgGTIN12;
    3: api.TipoGTIN := tgGTIN13;
    4: api.TipoGTIN := tgGTIN14;
  end;

  api.GTIN             := edtGTIN.Text;  //deixe em branco para gerar um novo
  api.AceiteTermo      := True;
  api.Descricao        := edtDescricao.Text;
  api.PesoBruto        := StrToFloatDef(edtPeso.Text, 0);
  api.UnidadeMedida    := edtUnidade.Text;
  api.DataLancamento   := StrToDateTimeDef(edtLancamento.Text, Now);
  api.StatusGTIN       := TStatusGTIN(cbxStatusGTIN.ItemIndex);
  api.Segmento         := StrToIntDef(edtSegmento.Text, 0);   //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Familia          := StrToIntDef(edtFamilia.Text, 0);    //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Classe           := StrToIntDef(edtClasse.Text, 0);     //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Subclasse        := StrToIntDef(edtSubclasse.Text, 0);  //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Marca            := edtMarca.Text;
  api.Modelo           := edtModelo.Text;
  api.CodigoPais       := edtCodPais.Text;
  api.CodigoLingua     := edtCodLingua.Text;
  api.PaisOrigem       := StrToIntDef(edtPaisOrigem.Text, 0);
  api.CompartilhaDados := True;
  api.NCM              := edtNCM.Text;  //Nomenclatura Comum do Mercosul
  api.Agencia          := TTipoAgencia(cbxAgencia.ItemIndex);
  api.NomeAgencia      := edtAgencia.Text;  //nome da agência reguladora

  for i := 0 to memCEST.Lines.Count -1 do
    if memCEST.Lines[i] <> '' then
      api.CESTs.Add.Codigo := memCEST.Lines[i];  //Código Especificador da Substituição Tributária, pode haver até 3 por produto

  for i := 0 to memImagens.Lines.Count -1 do
    if memImagens.Lines[i] <> '' then
      with api.Imagens.Add do  //adicione quantas imagens desejar
      begin
        URL     := memImagens.Lines[i];
        Nome    := Format('imagem %d', [i+1]);
        TipoURL := tuProduto;
      end;

  if api.Incluir then
  begin
    edtGTIN.Text := api.GTIN;  //após inserido, a property é preenchida com o novo GTIN gerado
    ShowMessage('Operação realizada com sucesso!');
  end;

  edtToken.Text      := api.Configuracoes.Token;  //armazene o token e a data de expiração no banco de dados, para usar em requisições futuras
  edtExpiration.Text := DateTimeToStr(api.Configuracoes.Expiration);  //o token é gerado com validade de 4 horas
end;

procedure TF_Principal.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  api.Configuracoes.ClientID := edtClientID.Text;  //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Secret   := edtSecret.Text;    //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Username := edtUsername.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.Password := edtPassword.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.CNPJ_CPF := edtCnpjCpf.Text;

  case cbxAmbiente.ItemIndex of
    0: api.Configuracoes.Ambiente := taProducao;
    1: api.Configuracoes.Ambiente := taHomologacao;
  end;

  //Caso o token esteja vazio ou expirado, será gerado um novo automaticamente.
  //Salve o último token gerado e sua data de expiração no banco de dados.
  //Preencha os dados salvos nas 2 properties abaixo:
  api.Configuracoes.Token := edtToken.Text;
  if edtExpiration.Text <> '' then
    api.Configuracoes.Expiration := StrToDateTime(edtExpiration.Text);

  case cbxTipoGTIN.ItemIndex of
    1: api.TipoGTIN := tgGTIN8;
    2: api.TipoGTIN := tgGTIN12;
    3: api.TipoGTIN := tgGTIN13;
    4: api.TipoGTIN := tgGTIN14;
  end;

  api.GTIN             := edtGTIN.Text;
  api.AceiteTermo      := True;
  api.Descricao        := edtDescricao.Text;
  api.PesoBruto        := StrToFloatDef(edtPeso.Text, 0);
  api.UnidadeMedida    := edtUnidade.Text;
  api.DataLancamento   := StrToDateTimeDef(edtLancamento.Text, Now);
  api.StatusGTIN       := TStatusGTIN(cbxStatusGTIN.ItemIndex);
  api.Segmento         := StrToIntDef(edtSegmento.Text, 0);   //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Familia          := StrToIntDef(edtFamilia.Text, 0);    //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Classe           := StrToIntDef(edtClasse.Text, 0);     //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Subclasse        := StrToIntDef(edtSubclasse.Text, 0);  //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Marca            := edtMarca.Text;
  api.Modelo           := edtModelo.Text;
  api.CodigoPais       := edtCodPais.Text;
  api.CodigoLingua     := edtCodLingua.Text;
  api.PaisOrigem       := StrToIntDef(edtPaisOrigem.Text, 0);
  api.CompartilhaDados := True;
  api.NCM              := edtNCM.Text;  //Nomenclatura Comum do Mercosul
  api.Agencia          := TTipoAgencia(cbxAgencia.ItemIndex);
  api.NomeAgencia      := edtAgencia.Text;  //nome da agência reguladora

  for i := 0 to memCEST.Lines.Count -1 do
    if memCEST.Lines[i] <> '' then
      api.CESTs.Add.Codigo := memCEST.Lines[i];  //Código Especificador da Substituição Tributária, pode haver até 3 por produto

  for i := 0 to memImagens.Lines.Count -1 do
    if memImagens.Lines[i] <> '' then
      with api.Imagens.Add do  //adicione quantas imagens desejar
      begin
        URL     := memImagens.Lines[i];
        Nome    := Format('imagem %d', [i+1]);
        TipoURL := tuProduto;
      end;

  if api.Alterar then
    ShowMessage('Operação realizada com sucesso!');

  edtToken.Text      := api.Configuracoes.Token;  //armazene o token e a data de expiração no banco de dados, para usar em requisições futuras
  edtExpiration.Text := DateTimeToStr(api.Configuracoes.Expiration);  //o token é gerado com validade de 4 horas
end;

procedure TF_Principal.Button3Click(Sender: TObject);
var
  i: Integer;
begin
  api.Configuracoes.ClientID := edtClientID.Text;  //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Secret   := edtSecret.Text;    //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Username := edtUsername.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.Password := edtPassword.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.CNPJ_CPF := edtCnpjCpf.Text;

  case cbxAmbiente.ItemIndex of
    0: api.Configuracoes.Ambiente := taProducao;
    1: api.Configuracoes.Ambiente := taHomologacao;
  end;

  //Caso o token esteja vazio ou expirado, será gerado um novo automaticamente.
  //Salve o último token gerado e sua data de expiração no banco de dados.
  //Preencha os dados salvos nas 2 properties abaixo:
  api.Configuracoes.Token := edtToken.Text;
  if edtExpiration.Text <> '' then
    api.Configuracoes.Expiration := StrToDateTime(edtExpiration.Text);

  api.GTIN := edtGTIN.Text;

  if api.Consultar then
  begin
    edtDescricao.Text       := api.Descricao;
    edtPeso.Text            := FloatToStr(api.PesoBruto);
    edtUnidade.Text         := api.UnidadeMedida;
    edtLancamento.Text      := DateTimeToStr(api.DataLancamento);
    edtSegmento.Text        := IntToStr(api.Segmento);
    edtFamilia.Text         := IntToStr(api.Familia);
    edtClasse.Text          := IntToStr(api.Classe);
    edtSubclasse.Text       := IntToStr(api.Subclasse);
    edtMarca.Text           := api.Marca;
    edtCodPais.Text         := api.CodigoPais;
    edtCodLingua.Text       := api.CodigoLingua;
    edtPaisOrigem.Text      := IntToStr(api.PaisOrigem);
    edtNCM.Text             := api.NCM;
    edtModelo.Text          := api.Modelo;
    cbxStatusGTIN.ItemIndex := StatusGtinToInt(api.StatusGTIN);
    cbxTipoGTIN.ItemIndex   := TipoGtinToInt(api.TipoGTIN);
    cbxAgencia.ItemIndex    := AgenciaToInt(api.Agencia);
    edtAgencia.Text         := api.NomeAgencia;

    memCEST.Clear;
    for i := 0 to api.CESTs.Count -1 do
      memCEST.Lines.Add(api.CESTs.Items[i].Codigo);

    memImagens.Clear;
    for i := 0 to api.Imagens.Count -1 do
      memImagens.Lines.Add(api.Imagens.Items[i].URL);

    ShowMessage('Operação realizada com sucesso!');
  end;

  edtToken.Text      := api.Configuracoes.Token;  //armazene o token e a data de expiração no banco de dados, para usar em requisições futuras
  edtExpiration.Text := DateTimeToStr(api.Configuracoes.Expiration);  //o token é gerado com validade de 4 horas
end;

procedure TF_Principal.Label36Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.gs1.org/services/gpc-browser', nil, nil, SW_SHOWNORMAL);
end;

procedure TF_Principal.Label37Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://apicnp.gs1br.org/api-portal/node/7', nil, nil, SW_SHOWNORMAL);
end;

procedure TF_Principal.Label8Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://apicnp.gs1br.org', nil, nil, SW_SHOWNORMAL);
end;

initialization
  api := TAPI_GS1.Create(nil);

finalization
  api.Free;

end.
