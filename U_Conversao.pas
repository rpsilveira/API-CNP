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

unit U_Conversao;

interface

uses SysUtils;

type
  TAmbiente = (taProducao, taHomologacao);
  TTipoGTIN = (tgNenhum, tgGTIN8, tgGTIN12, tgGTIN13, tgGTIN14);
  TTipoURL = (tuNenhum, tuFoto, tuReserva, tuLinkeddata, tuYoutube, tuProduto);
  TStatusGTIN = (stNenhum, stAtivo, stCancelado, stSuspenso, stReativado);
  TTipoAgencia = (agNenhuma, agANVISA, agINMETRO, agANATEL, agMAPA);
  TTipoRequisicao = (trPOST, trPUT);

function TipoUrlToInt(pTipoURL: TTipoURL): Integer;
function TipoGtinToInt(pTipoGTIN: TTipoGTIN): Integer;
function StatusGtinToInt(pStatusGTIN: TStatusGTIN): Integer;
function AgenciaToInt(pAgencia: TTipoAgencia): Integer;
function FloatToString(pValue: Double): String;
function StringToFloat(pValue: String): Double;
function StringToDateTime(pValue: String): TDateTime;

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
    stCancelado: Result := 2;
    stSuspenso : Result := 3;
    stReativado: Result := 4;
  else
    Result := 0;
  end;
end;

function AgenciaToInt(pAgencia: TTipoAgencia): Integer;
begin
  case pAgencia of
    agANVISA : Result := 1;
    agINMETRO: Result := 2;
    agANATEL : Result := 3;
    agMAPA   : Result := 4;
  else
    Result := 0;
  end;
end;

function FloatToString(pValue: Double): String;
begin
  Result := StringReplace(FloatToStr(pValue), ',', '.', []);
end;

function StringToFloat(pValue: String): Double;
begin
  Result := StrToFloatDef(StringReplace(pValue, '.', ',', []), 0);
end;

function StringToDateTime(pValue: String): TDateTime;
var
  tmp: TDateTime;
  T: TFormatSettings;
  dt, hr: String;
begin
  T.ShortDateFormat := 'yyyy-mm-dd';
  T.DateSeparator   := '-';

  dt := Copy(pValue, 1, 10);
  hr := Copy(pValue, 12, 8);

  if TryStrToDateTime(dt +' '+ hr, tmp, T) then
    Result := tmp
  else
    Result := 0;
end;

end.
