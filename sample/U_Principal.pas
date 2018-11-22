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

unit U_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi;

type
  TF_Principal = class(TForm)
    Label1: TLabel;
    edtClientID: TEdit;
    Label2: TLabel;
    edtSecret: TEdit;
    edtUsername: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    Label4: TLabel;
    edtCnpjCpf: TEdit;
    Label5: TLabel;
    btnEnvia: TButton;
    edtGTIN: TEdit;
    Label6: TLabel;
    rgOperacao: TRadioGroup;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    rgGTIN: TRadioGroup;
    edtToken: TEdit;
    Label10: TLabel;
    edtExpiration: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure btnEnviaClick(Sender: TObject);
    procedure Label8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;

implementation

{$R *.dfm}

uses U_API_GS1, U_Conversao;

procedure TF_Principal.btnEnviaClick(Sender: TObject);
var
  api: TAPI_GS1;
  ok: Boolean;
begin
  api := TAPI_GS1.Create(Self);

  api.Configuracoes.ClientID := edtClientID.Text;  //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Secret   := edtSecret.Text;    //acesse https://apicnp.gs1br.org para obter
  api.Configuracoes.Username := edtUsername.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.Password := edtPassword.Text;  //mesmo informado ao se cadastrar no site
  api.Configuracoes.CNPJ_CPF := edtCnpjCpf.Text;
  api.Configuracoes.Ambiente := taHomologacao;     //ap�s realizados os testes, alterar p/ taProducao

  //Caso o token esteja vazio ou expirado, ser� gerado um novo automaticamente.
  //Salve o �ltimo token gerado e sua data de expira��o no banco de dados.
  //Preencha os dados salvos nas 2 properties abaixo:
  api.Configuracoes.Token := edtToken.Text;
  if edtExpiration.Text <> '' then
    api.Configuracoes.Expiration := StrToDateTime(edtExpiration.Text);

  case rgGTIN.ItemIndex of
    0: api.TipoGTIN := tgGTIN8;
    1: api.TipoGTIN := tgGTIN12;
    2: api.TipoGTIN := tgGTIN13;
    3: api.TipoGTIN := tgGTIN14;
  end;

  api.GTIN             := edtGTIN.Text;  //deixe em branco para gerar um novo
  api.AceiteTermo      := True;
  api.Descricao        := 'descri��o do produto';
  api.PesoBruto        := 1.234;
  api.UnidadeMedida    := 'L';
  api.DataLancamento   := StrToDateTime('01/01/2019 12:00');
  api.StatusGTIN       := stAtivo;
  api.Segmento         := 63000000;  //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Familia          := 63010000;  //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Classe           := 63010300;  //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Subclasse        := 10001077;  //de acordo com o GPC (https://www.gs1.org/services/gpc-browser)
  api.Marca            := 'marca do produto';
  api.Modelo           := 'modelo do produto';
  api.CodigoPais       := '076';  //Brasil
  api.CodigoLingua     := '348';  //Portugu�s
  api.PaisOrigem       := 76;  //Brasil
  api.CompartilhaDados := True;
  api.NCM              := '3815.12.10';  //Nomenclatura Comum do Mercosul
  api.IdAgencia        := 1;  //1-ANVISA, 2-INMETRO, 3-ANATEL, 4-MAPA
  api.NomeAgencia      := 'ANVISA';  //nome da ag�ncia reguladora

  api.CESTs.Add.Codigo := '20.042.00';  //C�digo Especificador da Substitui��o Tribut�ria, pode haver at� 3 por produto
  api.CESTs.Add.Codigo := '01.047.00';

  //adicione quantas imagens desejar
  with api.Imagens.Add do
  begin
    URL := 'url da imagem 1';
    Nome := 'nome da imagem 1';
    TipoURL := tuProduto;
  end;

  with api.Imagens.Add do
  begin
    URL := 'url da imagem 2';
    Nome := 'nome da imagem 2';
    TipoURL := tuProduto;
  end;

  if rgOperacao.ItemIndex = 0 then
    ok := api.Incluir()
  else
    ok := api.Alterar();

  if ok then
    ShowMessage('Opera��o realizada com sucesso!');

  edtGTIN.Text       := api.GTIN;  //ap�s inserido, a property � preenchida com o novo GTIN gerado
  edtToken.Text      := api.Configuracoes.Token;  //armazene o token e a data de expira��o no banco de dados, para usar em requisi��es futuras
  edtExpiration.Text := DateTimeToStr(api.Configuracoes.Expiration);  //o token � gerado com validade de 4 horas

  api.Free;
end;

procedure TF_Principal.Label8Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://apicnp.gs1br.org', nil, nil, SW_SHOWNORMAL);
end;

end.
