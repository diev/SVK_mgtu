{************************************************************}
{                                                            }
{       Модуль для работы со скриптами и  API вербы          }
{       Copyright (с) 2010 РСХБ                              }
{               отдел/сектор                                 }
{                                                            }
{  Разработчик: Акулов Е.В.                                  }
{  Модифицирован: 15 июля 2011                               }
{                                                            }
{************************************************************}

unit unit_Verba;

interface

uses
   SysUtils, Forms, Dialogs, ShellApi, classes;

type

  T16Bit = integer;

  TVerba = class

    constructor Create;
    function checkKey(k_dev:string):string;
    function Load_key_(num:string):string;
    procedure Clear;
    procedure setKey(i:integer);
    function EnCrypt(f: string;num_k:integer;ser:string;fkey:integer):string;
    function Sign(f: string;num_k:integer;ser:string):string;
    function ResetKey_(num_k:string):string;
    function DeCrypt(f:string):string;
    function DelSign_(f:string):string;
    destructor Destroy; override;

    private
    fKEY:integer;
    errcode:integer;
    EMAIL,OTD:String;
    function error(err_cod:integer):string;
  end;

var
  Vrb:TVerba;

implementation

uses WBoth, Unit1;
{******************************************************************************
  Description: constructor
  Тип: Внутренняя
*******************************************************************************}
constructor TVerba.Create;
begin
  fKEY:=0;
  EMAIL:='';
  OTD :='';

//  if (PUB3 <> '') and (SEC3 <> '') then begin
//    CryptoInit(pAnsiChar(SEC3),pAnsiChar(PUB3));
//    SignInit(pAnsiChar(SEC3),pAnsiChar(PUB3));
//  end;
end;
{******************************************************************************
  Description: Load_key
  Тип: Внешняя
*******************************************************************************}
function TVerba.Load_key_(num:string):string;
begin
if num = '1' then begin
  try
    if (PUB1 <> '') and (SEC1 <> '') then begin
      CryptoInit(pAnsiChar(SEC1),pAnsiChar(PUB1));
      SignInit(pAnsiChar(SEC1),pAnsiChar(PUB1));
    end;
    errcode:=InitKey(pointer(KEY_DEV1),PChar(''));
    if errcode=NO_ERROR then Result:='Ключи с ключевого носителя ' + KEY_DEV1 +'загружены в драйвер Asyncr'
    else Result:=error(errcode);
  except on E: Exception do
    Result:='Ошибка загрузки ключей функцией InitKey(pointer(key_dev),pAnsiChar(''))';
  end;
end;
if num='2' then begin
  try
    if (PUB2 <> '') and (SEC2 <> '') then begin
      CryptoInit(pAnsiChar(SEC2),pAnsiChar(PUB2));
      SignInit(pAnsiChar(SEC2),pAnsiChar(PUB2));
    end;
    errcode:=InitKey(pointer(KEY_DEV2),PChar(''));
      if errcode=NO_ERROR then Result:='Ключи с ключевого носителя ' + KEY_DEV2 +'загружены в драйвер Asyncr'
    else Result:=error(errcode);
  except on E: Exception do
    Result:='Ошибка загрузки ключей функцией InitKey(pointer(key_dev),pAnsiChar(''))';
  end;
end;
if num='3' then begin
  try
    errcode:=InitKey(pointer(KEY_DEV3),PChar(''));
      if errcode=NO_ERROR then Result:='Ключи с ключевого носителя ' + KEY_DEV3 + 'загружены в драйвер Asyncr'
    else Result:=error(errcode);
  except on E: Exception do
    Result:='Ошибка загрузки ключей функцией InitKey(pointer(key_dev),pAnsiChar(''))';
  end;
end;
end;
{******************************************************************************
  Описание: проверка ЭЦП, расшифровка и снятие ЭЦП
  Тип: Внешняя
  Комментарий:
*******************************************************************************}
function TVerba.DeCrypt(f: string):string;
//var s : array[0..PUB_ID_LENGTH] of Char;
begin
{     fKEY:=0;
     errcode:=GetFileSenderID(pAnsiChar(f),PChar(@s));
     if  errcode<>NO_ERROR then result:=error(errcode)
     else fKEY:=strtoint(GetCryptoNumberStr(s));}

    errcode:=DeCryptFile(pAnsiChar(f), pAnsiChar(f),NUM_KEY2);
    if errcode<>NO_ERROR then result:=error(errcode);
    if errcode=NO_ERROR then Result:='Расшифрован '+f;
    DelSign_(f);
end;
{******************************************************************************
   Description: Sign
   Тип: Внешняя
*******************************************************************************}
function TVerba.Sign(f: string;num_k:integer;ser:string):string;
var
  ecp: string;
begin
  ecp:=inttostr(num_k)+ser+'01';
  try
    errcode:=SignFile(pAnsiChar(f),pAnsiChar(f),pAnsiChar(ecp));
    if errcode=NO_ERROR then Result:='Файл '+f+' подписан ЭЦП ' + ecp
    else Result:=error(errcode);
  except
    Result:='Ошибка наложения ЭЦП';
  end;
end;
{******************************************************************************
   Description: EnCrypt
   Тип: Внешняя
*******************************************************************************}
function TVerba.EnCrypt(f: string;num_k:integer;ser:string;fkey:integer):string;
begin
  if fKEY<>0 then begin
  try
    errcode:=EnCryptFile(pAnsiChar(f), pAnsiChar(f),num_k,@fKEY,pAnsiChar(ser));
    if errcode=NO_ERROR then Result:='Файл '+f+' зашифрован ключом ' + inttostr(num_k)
    else Result:=error(errcode);
  except
    Result:='Ошибка EnCrypt';
  end;
  end else Result:='не указан получатель';
end;
{******************************************************************************
   Description: getter fKEY
   Тип: Внешняя
*******************************************************************************}
procedure TVerba.setKey(i: integer);
begin
  fKEY:=i;
end;
{******************************************************************************
   Описание: Деструктор
   Тип: Внутренняя
*******************************************************************************}
destructor TVerba.Destroy;
begin
  inherited;
end;
{******************************************************************************
   Описание: Очистка
   Тип: Внешняя
*******************************************************************************}
procedure TVerba.Clear;
begin
  fKEY:=0;
  EMAIL:='';
  OTD :='';
end;
{******************************************************************************
   Description: error
   Тип: Внешняя
*******************************************************************************}
function TVerba.error(err_cod: integer):string;
begin
  case err_cod of
    E_DEVICE:      Result:='Ошибка при обращении к сменному ключевому устройству';
    E_REDEFINE:    Result:='Попытка перезаписи ключа в драйвер ASYNCR';
    E_KEY_NOT_SET: Result:='Ошибка при загрузке ключа в драйвер ASYNCR';
    else Result:=GetVerbaErrorStr(err_cod);
  end;
end;


function TVerba.ResetKey_(num_k:string): string;
begin
    errcode:=ResetKey(pAnsiChar(num_k));
    CryptoDone;
    SignDone;
    if errcode=NO_ERROR then Result:='Ключ ' + num_k + ' выгружен'
    else Result:=error(errcode);
end;

function TVerba.checkKey(k_dev:string): string;
begin
Result:='sign ' + GetIdFromDriver('S') + ' encrypt ' + GetIdFromDriver('E'); // достает всегда из 0 слота
  //GetIdFromDev(k_dev,'S') + ' ' + GetIdFromDev(k_dev,'E');
end;


function TVerba.DelSign_(f: string): string;
begin
    errcode:=DelSign(pAnsiChar(f),-1);
    if errcode=NO_ERROR then Result:='Снято ЭЦП с '+f;
    if errcode<>NO_ERROR then Result:=error(errcode);
end;

end.

