unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, shellapi,
  Dialogs,inifiles, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    CheckBox1: TCheckBox;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox1: TListBox;
    Button9: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerINFO_InTimer(Sender: TObject);
    procedure TimerKliko_InTimer(Sender: TObject);
    function archive(fl,target:string):string;
    function movefile_(fl,target:string):string;
    function run(fl,eval:string):string;
    procedure Log(mes: string);
    procedure message_list(ms:string);
    function  checkloadkey:boolean;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    INFO_IN,INFO_OUT,INFO_ARHIV,
    KLIKO_IN_ARHIV,KLIKO_OUT_ARHIV,UTA_KLIKO_IN, UTA_KLIKO_OUT,KLIKO_NET_IN,
    ARJ_364P_OUT,_364P_OUT_ARHIV,SCRIPT_364P,
    ARJ_311P_OUT,_311P_OUT_ARHIV,SCRIPT_311P,
    PATH_LOGI,
    DEN:string;
    LOGI:Boolean;BUTTON1_EVAL,BUTTON2_EVAL,BUTTON3_EVAL,BUTTON4_EVAL:string;
//    TimerKliko_in:TTimer;
  public
  end;

var
  Form1: TForm1;
    SEC1,PUB1,SERIA1,SEC2,PUB2,SERIA2,txt_verba_o_dll,
    SEC3,PUB3,SERIA3,Abonents_list,key_dev1,key_dev2,key_dev3:string;
    NUM_KEY1,NUM_KEY2,NUM_KEY3,kliko,fts:integer;

implementation

uses unit_Verba;

{$R *.dfm}
{**********************************************************************
    description: FormCreate
************************************************************************}
procedure TForm1.FormCreate(Sender: TObject);
var
 inf:TIniFile;
 TimerINFO_In:TTimer;
begin
  form1.Caption:=form1.Caption+' 1.7.1 от 20/01/2016 ';
  TimerINFO_In:=TTimer.Create(self);
  TimerINFO_In.OnTimer:=TimerINFO_InTimer;

//  TimerKliko_in:=TTimer.Create(self);
//  TimerKliko_in.OnTimer:=TimerKliko_InTimer;

  inf:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'sp.ini');

  INFO_IN         :=inf.ReadString('DIRECTORY','INFO_IN','');
  INFO_OUT        :=inf.ReadString('DIRECTORY','INFO_OUT','');
  INFO_ARHIV      :=inf.ReadString('DIRECTORY','INFO_ARHIV','');

  UTA_KLIKO_IN    :=inf.ReadString('DIRECTORY','UTA_KLIKO_IN','');  // квитанции
  UTA_KLIKO_OUT   :=inf.ReadString('DIRECTORY','UTA_KLIKO_OUT','');
  KLIKO_OUT_ARHIV :=inf.ReadString('DIRECTORY','KLIKO_OUT_ARHIV','');//архив незашифрованных
  KLIKO_IN_ARHIV  :=inf.ReadString('DIRECTORY','KLIKO_IN_ARHIV',''); // архив квитанций
  KLIKO_NET_IN    :=inf.ReadString('DIRECTORY','KLIKO_NET_IN','');

  ARJ_364P_OUT    :=inf.ReadString('DIRECTORY','ARJ_364P_OUT','');
  _364P_OUT_ARHIV :=inf.ReadString('DIRECTORY','_364P_OUT_ARHIV',''); //архив незашифрованных
  SCRIPT_364P     :=inf.ReadString('DIRECTORY','SCRIPT_364P','');

  ARJ_311P_OUT    :=inf.ReadString('DIRECTORY','ARJ_311P_OUT','');
  _311P_OUT_ARHIV :=inf.ReadString('DIRECTORY','_311P_OUT_ARHIV','');//архив незашифрованных
  SCRIPT_311P     :=inf.ReadString('DIRECTORY','SCRIPT_311P','');

  PATH_LOGI       :=inf.ReadString('DIRECTORY','PATH_LOGI','');
  LOGI            :=inf.ReadBool('COMMON','LOGI',false);  CheckBox1.Checked:=LOGI;
  TimerINFO_In.Interval:=inf.ReadInteger('COMMON','TIME_IN',30)*1000;{по умолчанию 30 сек.}

  BUTTON1_EVAL   :=inf.ReadString('COMMON','BUTTON1_EVAL','');
  BUTTON2_EVAL   :=inf.ReadString('COMMON','BUTTON2_EVAL','');
  BUTTON3_EVAL   :=inf.ReadString('COMMON','BUTTON3_EVAL','');
  BUTTON4_EVAL   :=inf.ReadString('COMMON','BUTTON4_EVAL','');

// verba ========================================================

  NUM_KEY1       :=inf.ReadInteger('verba','NUM_KEY1',0);//NUM_KEY
  PUB1           :=inf.ReadString('verba','Pub1','');
  SEC1           :=inf.ReadString('verba','sec1','');
  SERIA1         :=inf.ReadString('verba','Seria1','');
  KEY_DEV1       :=inf.ReadString('verba','key_dev1','');

  NUM_KEY2       :=inf.ReadInteger('verba','NUM_KEY2',0);//NUM_KEY
  PUB2           :=inf.ReadString('verba','Pub2','');
  SEC2           :=inf.ReadString('verba','sec2','');
  SERIA2         :=inf.ReadString('verba','Seria2','');
  KEY_DEV2       :=inf.ReadString('verba','key_dev2','');

  NUM_KEY3       :=inf.ReadInteger('verba','NUM_KEY3',0);//NUM_KEY
  PUB3           :=inf.ReadString('verba','Pub3','');
  SEC3           :=inf.ReadString('verba','sec3','');
  SERIA3         :=inf.ReadString('verba','Seria3','');
  KEY_DEV3       :=inf.ReadString('verba','key_dev3','');

  Abonents_list  :=inf.ReadString('verba','Abonents_list','');
  txt_verba_o_dll:=inf.ReadString('verba','txt_verba_o_dll','');

  kliko          :=inf.ReadInteger('verba','kliko',0);
  fts            :=inf.ReadInteger('verba','fts',0);

  inf.Free;


 if KEY_DEV1='' then ShowMessage('не указан ключ 1');
 if KEY_DEV2='' then ShowMessage('не указан ключ 2');

 if not DirectoryExists(INFO_ARHIV) then CreateDir(INFO_ARHIV);
 if not DirectoryExists(KLIKO_IN_ARHIV) then CreateDir(KLIKO_IN_ARHIV);
 if not DirectoryExists(KLIKO_OUT_ARHIV) then CreateDir(KLIKO_OUT_ARHIV);

 {переинициализируется при каждом копировании}
 DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
 {также создается новый день при каждом копировании файлов}
 if not DirectoryExists(INFO_ARHIV+DEN) then CreateDir(INFO_ARHIV+DEN);
 if not DirectoryExists(KLIKO_IN_ARHIV+DEN) then CreateDir(KLIKO_IN_ARHIV+DEN);
 if not DirectoryExists(KLIKO_OUT_ARHIV+DEN) then CreateDir(KLIKO_OUT_ARHIV+DEN);

  TimerINFO_In.Enabled:=true;
  Label1.Caption:='Мониторинг запущен';
  message_list('Начало обработки');
  vrb:=TVerba.Create;

  //checkloadkey;
end;

function TForm1.checkloadkey: boolean;
begin
  if (Pos(inttostr(NUM_KEY1),vrb.checkKey(''))<>0) or (Pos(inttostr(NUM_KEY2),vrb.checkKey(''))<>0) then begin
    Button2.Enabled:=true;
    Button4.Enabled:=true;
    Button5.Enabled:=true;
    Button7.Enabled:=true;
    Result:=true;
  end else begin
    Button2.Enabled:=false;
    Button4.Enabled:=false;
    Button5.Enabled:=false;
    Button7.Enabled:=false;
    Result:=false;
  end;
end;


procedure TForm1.TimerKliko_InTimer(Sender: TObject);
var
    sr: TSearchRec;
begin
  if SysUtils.FindFirst(UTA_KLIKO_IN+'*.kvt1', faAnyFile, sr) = 0 then
     repeat
        if (sr.Name<>'.') and (sr.Name <>'..') and (sr.Attr<>faDirectory) then begin
          // сначала мы копируем в архив
          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
          if not DirectoryExists(KLIKO_IN_ARHIV+DEN) then CreateDir(KLIKO_IN_ARHIV+DEN);
          CopyFile(Pchar(UTA_KLIKO_IN+sr.Name),Pchar(KLIKO_IN_ARHIV+DEN+sr.Name),true);

          if not DirectoryExists(KLIKO_NET_IN+DEN) then CreateDir(KLIKO_NET_IN+DEN);
          MoveFile(Pchar(UTA_KLIKO_IN+sr.Name),Pchar(KLIKO_NET_IN+DEN+sr.Name));
          message_list('Файл квитанции '+UTA_KLIKO_IN+sr.Name+' перенесен');
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
end;
{*******************************************************************************
  CUT
*******************************************************************************}
function cut(var s_in:string;delims:string):string;
begin
  try
    Result:=copy(s_in,1,pos(delims,s_in)-1);
    delete(s_in,1,pos(delims,s_in));
  except
  end;
end;
{**********************************************************************
    клико
************************************************************************}
procedure TForm1.Button2Click(Sender: TObject);
var
  f:string;
begin
  if OpenDialog1.Execute then begin f:=OpenDialog1.FileName; message_list('----------- Отчетность kliko ' + f + '------------');
    run(f,BUTTON1_EVAL);
 end;
end;
{**********************************************************************
    фтс 364-п
************************************************************************}
procedure TForm1.Button4Click(Sender: TObject);
var
  f:string;
begin
  if OpenDialog1.Execute then begin f:=OpenDialog1.FileName; message_list('----------фтс 364-п ' + f + '-----------');
    run(f,BUTTON2_EVAL);
  end;
end;
{**********************************************************************
    фтс 311-п
************************************************************************}
procedure TForm1.Button7Click(Sender: TObject);
var
  f:string;
begin
  if OpenDialog1.Execute then begin f:=OpenDialog1.FileName; message_list('----------фтс 311-п ' + f + '-----------');
    run(f,BUTTON4_EVAL);
  end;
end;
{****************************************************************************
  Логи пишем по принципу открыли файл, записали, закрыли
  не держим файл постоянно открытым, т.к. записи буферизуются
*****************************************************************************}
procedure TForm1.Log(mes: string);
var
  Stream: TFileStream;
begin
  if LOGI then begin
    if not FileExists(PATH_LOGI) then Stream := TFileStream.Create(PATH_LOGI,fmCreate)
    else Stream := TFileStream.Create(PATH_LOGI,fmOpenWrite);
    try
      Stream.Seek(0, soFromEnd);
      mes:=DateTimeToStr(now)+' '+mes+#10;
      Stream.WriteBuffer(Pointer(mes)^, Length(mes));
    finally
      Stream.Free;
    end;
  end;
end;
{****************************************************************************
  закрываем программу
*****************************************************************************}
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if Dialogs.MessageDlg('Закрыть программу ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then CanClose:=false else begin
    Log('Конец обработки');
 end;
end;
{**********************************************************************
    Обработка INFO
************************************************************************}
procedure TForm1.TimerINFO_InTimer(Sender: TObject);
var
    sr: TSearchRec;
begin
if SysUtils.FindFirst(INFO_IN+'*.*', faAnyFile, sr) = 0 then
     repeat
        if (sr.Name<>'.') and (sr.Name <>'..') and (sr.Attr<>faDirectory) then begin
          // сначала мы копируем в архив
          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
          if not DirectoryExists(INFO_ARHIV+DEN) then CreateDir(INFO_ARHIV+DEN);
          // добавлять уникальное имя файла
          CopyFile(Pchar(INFO_IN+sr.Name),Pchar(INFO_ARHIV+DEN+sr.Name),true);

          if not DirectoryExists(INFO_OUT+DEN) then CreateDir(INFO_OUT+DEN);
          MoveFile(Pchar(INFO_IN+sr.Name),Pchar(INFO_OUT+DEN+sr.Name));
          message_list('Файл '+INFO_IN+sr.Name+' перенесен');
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
end;
{**********************************************************************
    вывод на лмст и в лог
************************************************************************}
procedure TForm1.message_list(ms: string);
begin
  ListBox1.Items.Add(DateTimeToStr(now)+' '+ms);
  Log(ms);
end;
{**********************************************************************
    проверить ключи
************************************************************************}
procedure TForm1.Button3Click(Sender: TObject);
begin
  message_list(vrb.checkKey(''));
end;
{****************************************************************************
   asrkeyw.exe
*****************************************************************************}
procedure TForm1.Button9Click(Sender: TObject);
begin
   ShellExecute(0,'open',PChar('C:\Windows\asrkeyw.exe'), pchar(''), pchar('C:\Windows\'), SW_SHOW);
end;
{****************************************************************************
   интерпретатор
*****************************************************************************}
function TForm1.run(fl,eval: string): string;
var
  comm,command,parametr,target,script_name:string;
begin
comm:=eval;
  while Pos(';',comm) <> 0 do begin
    command:= cut(comm,';');
    if      command = 'LOADKEY_1'  then message_list(Vrb.Load_key_('1'))
    else if command = 'LOADKEY_2'  then message_list(Vrb.Load_key_('2'))
    else if command = 'SIGN_1'     then message_list(vrb.Sign(fl,NUM_KEY1,SERIA1))
    else if command = 'SIGN_2'     then message_list('')
    else if command = 'RESETKEY_1' then message_list(vrb.ResetKey_(inttostr(NUM_KEY1) + SERIA1))
    else if command = 'RESETKEY_2' then message_list(vrb.ResetKey_(inttostr(NUM_KEY2) + SERIA2))
    else if command = 'CRYPT_1(KLIKO)' then message_list(vrb.EnCrypt(fl,NUM_KEY1,SERIA1,kliko))
    else if command = 'CRYPT_2(FTS)' then message_list(vrb.EnCrypt(fl,NUM_KEY2,SERIA2,fts))
    else if pos('MOVE',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='UTA_KLIKO_OUT' then target:=UTA_KLIKO_OUT
            else if parametr='ARJ_364P_OUT' then target:=ARJ_364P_OUT
            else if parametr='ARJ_311P_OUT' then target:=ARJ_311P_OUT
            else target:=parametr;
            message_list(movefile_(fl,target));
          end
    else if pos('ARCHIVE',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='KLIKO_OUT_ARHIV' then target:=KLIKO_OUT_ARHIV
            else if parametr='_364P_OUT_ARHIV' then target:=_364P_OUT_ARHIV
            else if parametr='_311P_OUT_ARHIV' then target:=_311P_OUT_ARHIV
            else target:=parametr;
            message_list(archive(fl,target));
          end
    else if pos('SCRIPT',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='SCRIPT_364P' then script_name:=SCRIPT_364P
            else if parametr='SCRIPT_311P' then script_name:=SCRIPT_311P
            else script_name:=parametr;
            ShellExecute(0,'open',PChar(script_name), pchar(''), pchar(ExtractFileDir(script_name)), SW_SHOW);
            message_list('запущен скрипт ' + script_name);
         end;
  end;
end;
{**********************************************************************
    архив
************************************************************************}
function TForm1.archive(fl,target: string):string;
begin
  DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
  if not DirectoryExists(target+DEN) then CreateDir(target+DEN);
  CopyFile(Pchar(fl),Pchar(target+DEN+ExtractFileName(fl)),true);
  Sleep(1000);
  Result:='файл ' + fl+' скопирован в архив';
end;
{**********************************************************************
    перенос
************************************************************************}
function TForm1.movefile_(fl, target: string): string;
begin
  MoveFile(Pchar(fl),Pchar(target+ExtractFileName(fl)));
  Sleep(1000);
  Result:='Файл '+fl+' перенесен в '+target;
end;

end.
