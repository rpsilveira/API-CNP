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

unit U_Conversao;

interface

uses SysUtils;

type
  TAmbiente = (taProducao, taHomologacao);
  TTipoGTIN = (tgGTIN8, tgGTIN12, tgGTIN13, tgGTIN14);
  TTipoURL = (tuFoto, tuReserva, tuLinkeddata, tuYoutube, tuProduto);
  TStatusGTIN = (stAtivo, stCancealdo, stSuspenso, stReativado);
  TTipoRequisicao = (trPOST, trPUT);

function TipoUrlToInt(pTipoURL: TTipoURL): Integer;
function TipoGtinToInt(pTipoGTIN: TTipoGTIN): Integer;
function StatusGtinToInt(pStatusGTIN: TStatusGTIN): Integer;
function FloatToString(pValue: Double): String;

implementation

function TipoUrlToInt(pTipoURL: TTipoURL): Integer;
begin
  case pTipoURL of
    tuFoto      : Result := 1;
    tuReserva   : Result := 2;
    tuLinkeddata: Result := 3;
    tuYoutube   : Result := 4;
    tuProduto   : Result := 5;
  else
    Result := 0;
  end;
end;

function TipoGtinToInt(pTipoGTIN: TTipoGTIN): Integer;
begin
  case pTipoGTIN of
    tgGTIN8 : Result := 1;
    tgGTIN12: Result := 2;
    tgGTIN13: Result := 3;
    tgGTIN14: Result := 4;
  else
    Result := 0;
  end;
end;

function StatusGtinToInt(pStatusGTIN: TStatusGTIN): Integer;
begin
  case pStatusGTIN of
    stAtivo    : Result := 1;
    stCancealdo: Result := 2;
    stSuspenso : Result := 3;
    stReativado: Result := 4;
  else
    Result := 0;
  end;
end;

function FloatToString(pValue: Double): String;
begin
  Result := StringReplace(FloatToStr(pValue), ',', '.', []);
end;

end.
