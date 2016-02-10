unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, shellapi,
  Dialogs,inifiles, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type

  StrTD = record
    path,maska,arhiv,target:string;
  end;

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
    ListBox2: TListBox;
    Button1: TButton;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function archive(fl,target:string):string;
    function movefile_(fl,target:string):string;
    function run(fl,eval:string):string;
    procedure Log(mes: string);
    procedure message_list(ms:string);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure TimerProc(Sender: TObject);
    function ARJ_run(in_,out_,arch:string):string;
    function ARJ_extract(name_archive,out_catalog:string):string;
    function archiveRun311(f:string):string;
    procedure Button1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);

  private
    KLIKO_OUT_ARHIV,UTA_KLIKO_OUT,
    ARJ_364P_OUT,_364P_OUT_ARHIV,SCRIPT_364P,UTA_364P_OUT,_364P_TK,ARJ_364P_OUT2,
    ARJ_311P_OUT,_311P_OUT_ARHIV,SCRIPT_311P,UTA_311P_OUT,_311P_TK,ARJ_311P_OUT2,
    ARJ_365P_OUT,_365P_OUT_ARHIV,SCRIPT_365P,UTA_365P_OUT,_365P_TK,ARJ_365P_OUT2,ARJ_365P_OUT_kvit,
    PATH_LOGI,
    DEN:string;
    LOGI:Boolean;BUTTON1_EVAL,BUTTON2_EVAL,BUTTON3_EVAL,BUTTON4_EVAL,BUTTON5_EVAL,BUTTON6_EVAL:string;
    DIR:string;
    TimerPool:array of TTimer;
    TimerData:array of StrTD;
    ARJ:string;
  public
  end;

var
  Form1: TForm1;
    SEC1,PUB1,SERIA1,SEC2,PUB2,SERIA2,txt_verba_o_dll,
    SEC3,PUB3,SERIA3,Abonents_list,key_dev1,key_dev2,key_dev3:string;
    NUM_KEY1,NUM_KEY2,NUM_KEY3,kliko,fts:integer;

implementation

uses unit_Verba, DateUtils;

{$R *.dfm}
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
    description: FormCreate
************************************************************************}
procedure TForm1.FormCreate(Sender: TObject);
var
 inf:TIniFile;
 s_:string;kt:integer;
begin
  form1.Caption:=form1.Caption+' 1.7.4 от 10/02/2016 ';
  inf:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'sp.ini');

  UTA_KLIKO_OUT   :=inf.ReadString('DIRECTORY','UTA_KLIKO_OUT','');
  KLIKO_OUT_ARHIV :=inf.ReadString('DIRECTORY','KLIKO_OUT_ARHIV','');//архив незашифрованных

  ARJ_364P_OUT    :=inf.ReadString('DIRECTORY','ARJ_364P_OUT','');
  _364P_OUT_ARHIV :=inf.ReadString('DIRECTORY','_364P_OUT_ARHIV',''); //архив незашифрованных
  SCRIPT_364P     :=inf.ReadString('DIRECTORY','SCRIPT_364P','');
  ARJ_364P_OUT2   :=inf.ReadString('DIRECTORY','ARJ_364P_OUT2','');
  UTA_364P_OUT    :=inf.ReadString('DIRECTORY','UTA_364P_OUT','');
  _364P_TK        :=inf.ReadString('DIRECTORY','_364P_TK','');

  ARJ_311P_OUT    :=inf.ReadString('DIRECTORY','ARJ_311P_OUT','');
  _311P_OUT_ARHIV :=inf.ReadString('DIRECTORY','_311P_OUT_ARHIV','');//архив незашифрованных
  SCRIPT_311P     :=inf.ReadString('DIRECTORY','SCRIPT_311P','');
  ARJ_311P_OUT2   :=inf.ReadString('DIRECTORY','ARJ_311P_OUT2','');
  UTA_311P_OUT    :=inf.ReadString('DIRECTORY','UTA_311P_OUT','');
  _311P_TK        :=inf.ReadString('DIRECTORY','_311P_TK','');

  ARJ_365P_OUT    :=inf.ReadString('DIRECTORY','ARJ_365P_OUT','');
  _365P_OUT_ARHIV :=inf.ReadString('DIRECTORY','_365P_OUT_ARHIV','');//архив незашифрованных
  SCRIPT_365P     :=inf.ReadString('DIRECTORY','SCRIPT_365P','');
  ARJ_365P_OUT2   :=inf.ReadString('DIRECTORY','ARJ_365P_OUT2','');
  UTA_365P_OUT    :=inf.ReadString('DIRECTORY','UTA_365P_OUT','');
  _365P_TK        :=inf.ReadString('DIRECTORY','_365P_TK','');
  ARJ_365P_OUT_kvit:=inf.ReadString('DIRECTORY','ARJ_365P_OUT_kvit','');

  DIR             :=inf.ReadString('DIRECTORY','DIR','');
  PATH_LOGI       :=inf.ReadString('DIRECTORY','PATH_LOGI','');
  LOGI            :=inf.ReadBool('COMMON','LOGI',false);  CheckBox1.Checked:=LOGI;
  ARJ             :=inf.ReadString('COMMON','ARJ','');

  BUTTON1_EVAL   :=inf.ReadString('COMMON','BUTTON1_EVAL','');
  BUTTON2_EVAL   :=inf.ReadString('COMMON','BUTTON2_EVAL','');
  BUTTON3_EVAL   :=inf.ReadString('COMMON','BUTTON3_EVAL','');
  BUTTON4_EVAL   :=inf.ReadString('COMMON','BUTTON4_EVAL','');
  BUTTON5_EVAL   :=inf.ReadString('COMMON','BUTTON5_EVAL','');
  BUTTON6_EVAL   :=inf.ReadString('COMMON','BUTTON6_EVAL','');

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

 if not DirectoryExists(KLIKO_OUT_ARHIV) then ForceDirectories(KLIKO_OUT_ARHIV);

 {переинициализируется при каждом копировании}
 DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';

  Label1.Caption:='Мониторинг запущен';
  message_list('Начало обработки');
  vrb:=TVerba.Create;

{ разбор шаблонов }
  kt:=0;
  if DIR<>'' then
    while Pos('#',DIR)<>0 do begin
      s_:=cut(DIR,'#');
      SetLength(TimerData, kt+1);
      TimerData[kt].path :=cut(s_,';');
      TimerData[kt].maska:=cut(s_,';');
      TimerData[kt].arhiv:=cut(s_,';');if not DirectoryExists(TimerData[kt].arhiv) then ForceDirectories(TimerData[kt].arhiv);
      TimerData[kt].target:=cut(s_,';');if not DirectoryExists(TimerData[kt].target) then ForceDirectories(TimerData[kt].target);

      SetLength(TimerPool, kt+1);
      TimerPool[kt]:= TTimer.Create(Self); // массив изб. от именования таймеров, много таймеров запускалок лучше
      TimerPool[kt].tag:=kt;
      TimerPool[kt].Interval:=strtoint(cut(s_,';'))*1000;
      TimerPool[kt].OnTimer:= TimerProc;
      TimerPool[kt].enabled:=true;

      // добавляем на форму
      ListBox2.Items.Add(TimerData[kt].path+TimerData[kt].maska+';'+TimerData[kt].arhiv+';'+TimerData[kt].target+';'+inttostr(TimerPool[kt].Interval div 1000));
      inc(kt);
    end;

end;
{*******************************************************************************
  Ковентирование DosToWin
*******************************************************************************}
function DosToWin(St: string): string;
var
  Ch: PChar;
begin
  Ch := StrAlloc(Length(St) + 1);
  OemToAnsi(PChar(St), Ch);
  Result := Ch;
  StrDispose(Ch)
end;
{**********************************************************************
    обработчик таймеров шедулера
************************************************************************}
procedure TForm1.TimerProc(Sender: TObject);
var
  ind:integer;
  sr,sr1,sr2: TSearchRec;
  postfix,newname,lastfile_arj,s:string;
  f:TextFile;
begin
  ind:=(Sender as TTimer).Tag;
  postfix:='_'+StringReplace(TimeToStr(Now), ':', '_',[rfReplaceAll, rfIgnoreCase]);

  if SysUtils.FindFirst(TimerData[ind].PATH+TimerData[ind].Maska, faAnyFile, sr) = 0 then
    repeat
      if (sr.Name<>'.') and (sr.Name <>'..') and (sr.Attr<>faDirectory) then begin
          // добавлять уникальное имя файла
          // INFO
          if ind=0 then begin
            newname:=TimerData[ind].PATH+sr.Name+postfix+ExtractFileExt(sr.Name);
            RenameFile(TimerData[ind].PATH+sr.Name,newname);
            message_list(archive(newname,TimerData[ind].arhiv));
            DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
            if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
            message_list(movefile_(newname,TimerData[ind].target+DEN));
          end;
          //311P
          if ind = 1 then begin
           // квитанция от цб
           if pos('GU_',sr.Name) = 0 then begin
               message_list('311p квитанция от цб');
               message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv));

               lastfile_arj:=TimerData[ind].PATH+sr.Name;
               message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
               lastfile_arj:=StringReplace(lastfile_arj, 'ARJ', 'XML',[rfReplaceAll, rfIgnoreCase]);
               run(lastfile_arj,'DELSIGN;');
               if FileExists(TimerData[ind].PATH+sr.Name) then DeleteFile(TimerData[ind].PATH+sr.Name);

               DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
               if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
               sleep(1000);
               message_list(movefile_(lastfile_arj,TimerData[ind].target+DEN));
           end;
          end;
          if ind = 2 then begin
           // квитанция от фнс
           if pos('GU_',sr.Name) <> 0 then begin
               message_list('311p квитанция от фнс');
               message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv));

               lastfile_arj:=TimerData[ind].PATH+sr.Name;
               message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
               if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);
               lastfile_arj:=TimerData[ind].PATH+copy(sr.Name,4,length(sr.Name));
               message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
               if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

               if SysUtils.FindFirst(TimerData[ind].PATH+'*.XML', faAnyFile, sr1) = 0 then
                repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  run(TimerData[ind].PATH+sr1.Name,'DELSIGN;');
                  sleep(1000);
                  message_list(movefile_(TimerData[ind].PATH+sr1.Name,TimerData[ind].target));
                end;
                until FindNext(sr1) <> 0;
               FindClose(sr1);
           end;
          end;

         if ind = 3 then begin
            // kliko
            message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv));
            run(TimerData[ind].PATH+sr.Name,'DELSIGN;');
            DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
            if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
            sleep(1000);
            message_list(movefile_(TimerData[ind].PATH+sr.Name,TimerData[ind].target+DEN));
         end;

//         if ind = 4 then begin
          // 365p квитанция от цб  непонятно пока что с ними делать

//         end;

         // 365p
         {if ind = 4 then begin
            message_list('365p ------------');
            newname:=TimerData[ind].PATH+sr.Name+postfix+ExtractFileExt(sr.Name);
            RenameFile(TimerData[ind].PATH+sr.Name,newname);
            message_list(archive(newname,TimerData[ind].arhiv));

            lastfile_arj:=newname;
            message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
            if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);
            // квитанция от цб
            if SysUtils.FindFirst(TimerData[ind].PATH+'*.txt', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  message_list('365p квитанция от цб');
                  run(TimerData[ind].PATH+sr1.Name,'DELSIGN;');
                  sleep(1000);
                  message_list(movefile_(TimerData[ind].PATH+sr1.Name,TimerData[ind].target));
                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);

            // квитанция от фнс
            if SysUtils.FindFirst(TimerData[ind].PATH+'*.arj', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  message_list('365p квитанция от фнс');
                  lastfile_arj:=TimerData[ind].PATH+sr1.Name;
                  message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
                  sleep(1000);
                  if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.txt', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          run(TimerData[ind].PATH+sr2.Name,'DELSIGN;');
                          sleep(1000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target));
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);

                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);

         end; }

         // 402p
         if ind = 4 then begin

            message_list('402p ------------');
            newname:=TimerData[ind].PATH+sr.Name+postfix+ExtractFileExt(sr.Name);
            RenameFile(TimerData[ind].PATH+sr.Name,newname);
            message_list(archive(newname,TimerData[ind].arhiv));

            lastfile_arj:=newname;
            message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
            if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);
            // фнс
            if SysUtils.FindFirst(TimerData[ind].PATH+'*.arj', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  lastfile_arj:=TimerData[ind].PATH+sr1.Name;
                  message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
                  sleep(1000);
                  if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.xml', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          run(TimerData[ind].PATH+sr2.Name,'DELSIGN;');
                          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
                          if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
                          sleep(1000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target+DEN));
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);

                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);

         end;

         // 364p
         if ind = 5 then begin
          message_list('364p ------------');
          message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv));          
          AssignFile(f,TimerData[ind].PATH+sr.Name);Reset(f);Readln(f,s);s:=DosToWin(s);CloseFile(f);
          //цб
          if Pos('Территориальное учреждение',s)<>0 then begin
            message_list('364p квитанция от цб');
            run(TimerData[ind].PATH+sr.Name,'DELSIGN;');
            DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
            if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
            sleep(1000);
            message_list(movefile_(TimerData[ind].PATH+sr.Name,TimerData[ind].target+DEN));
          end else begin //фтс
            message_list('364p квитанция от фтс');          
            lastfile_arj:=TimerData[ind].PATH+sr.Name;
            message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
            if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

            if SysUtils.FindFirst(TimerData[ind].PATH+'*.arj', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  lastfile_arj:=TimerData[ind].PATH+sr1.Name;
                  message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)));
                  sleep(1000);
                  if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.xml', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          run(TimerData[ind].PATH+sr2.Name,'DELSIGN;');
                          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
                          if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
                          sleep(1000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target+DEN));
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);

                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);
          end; //

         end;


      end;
    until FindNext(sr) <> 0;
  FindClose(sr);
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
  f,lastfile_arj,tk:string;
  sr: TSearchRec;
  i:integer;
begin
  if OpenDialog1.Execute then begin
    for i:=0 to OpenDialog1.Files.Count - 1 do begin
      f:=OpenDialog1.Files.Strings[i];
      message_list('----------фтс 364-п ' + f + '-----------');
      run(f,BUTTON2_EVAL);
    end;
  run(f,'SCRIPT(SCRIPT_364P);');
  ShowMessage('Сформирован сводный архив');
  if SysUtils.FindFirst(ARJ_364P_OUT2+'*.arj', faAnyFile, sr) = 0 then
    lastfile_arj:=ARJ_364P_OUT2 + sr.Name;
  FindClose(sr);
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Сводный архив подписан КА');

  tk:=inttostr(MonthOf(now));
  if Length(tk)=1 then tk:='0'+tk;
  tk:=_364P_TK +'a'+tk+'344.099.arj';
  // создаем транспортный конверт
  lastfile_arj:=ARJ_run(lastfile_arj,ARJ_364P_OUT2 + tk,'');
  ShowMessage('Сформирован транспортный конверт');
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Транспортный конверт подписан КА');
  message_list(movefile_(lastfile_arj,UTA_364p_OUT));
  end;
end;
{**********************************************************************
    фтс 311-п

    добавлена возможность отправки нескольких архивов, т.к. скрипт формирует
    отдельные архивы по физлицам и юрлицам
************************************************************************}
procedure TForm1.Button7Click(Sender: TObject);
var
  f,lastfile_arj,tk:string;
  sr: TSearchRec;
  i:integer;
begin
  if OpenDialog1.Execute then begin
    for i:=0 to OpenDialog1.Files.Count - 1 do begin
      f:=OpenDialog1.Files.Strings[i];
      message_list('----------фнс 311-п ' + f + '-----------');
      run(f,BUTTON4_EVAL);
    end;
  run(f,'SCRIPT(SCRIPT_311P);');
  ShowMessage('Сформирован сводный архив');
  if SysUtils.FindFirst(ARJ_311P_OUT2+'*.arj', faAnyFile, sr) = 0 then
    repeat
      if (sr.Name<>'.') and (sr.Name <>'..') and (sr.Attr<>faDirectory) then begin
        lastfile_arj:=ARJ_311P_OUT2 + sr.Name;
        run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
        ShowMessage('Сводный архив '+sr.Name+' подписан КА');

        tk:=inttostr(MonthOf(now));
        if Length(tk)=1 then tk:='0'+tk;
        tk:=_311P_TK +LowerCase(Copy(sr.Name,1,1))+tk+'344.099.arj';
        // создаем транспортный конверт
        lastfile_arj:=ARJ_run(lastfile_arj,ARJ_311P_OUT2 + tk,'');
        ShowMessage('Сформирован '+extractfilename(lastfile_arj)+' транспортный конверт');
        run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
        ShowMessage('Транспортный конверт '+extractfilename(lastfile_arj)+' подписан КА');
        message_list(movefile_(lastfile_arj,UTA_311p_OUT));
      end;
    until FindNext(sr) <> 0;
  FindClose(sr);
  end;{OpenDialog1.Execute}
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
    else if command = 'DELSIGN'    then message_list(vrb.DelSign_(fl))
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
            else if parametr='ARJ_365P_OUT' then target:=ARJ_365P_OUT
            else if parametr='ARJ_365P_OUT_kvit' then target:=ARJ_365P_OUT_kvit
            else target:=parametr;
            message_list(movefile_(fl,target));
          end
    else if pos('ARCHIVE',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='KLIKO_OUT_ARHIV' then target:=KLIKO_OUT_ARHIV
            else if parametr='_364P_OUT_ARHIV' then target:=_364P_OUT_ARHIV
            else if parametr='_311P_OUT_ARHIV' then target:=_311P_OUT_ARHIV
            else if parametr='_365P_OUT_ARHIV' then target:=_365P_OUT_ARHIV
            else target:=parametr;
            message_list(archive(fl,target));
          end
    else if pos('SCRIPT',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='SCRIPT_364P' then script_name:=SCRIPT_364P
            else if parametr='SCRIPT_311P' then script_name:=SCRIPT_311P
            else if parametr='SCRIPT_365P' then script_name:=SCRIPT_365P
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
{**********************************************************************
    аналог ARJ
************************************************************************}
function TForm1.ARJ_run(in_, out_, arch:string): string;
begin
  ShellExecute(0,'open',PChar(ARJ), pchar('m -e '+out_+' '+in_), pchar(ExtractFileDir(ARJ)), SW_SHOW);
  sleep(1000);
  result:=out_;
end;

function TForm1.archiveRun311(f:string): string;
Const BTypeFilenameHead:string = 'SFC';
  ATypeMask:string = 'SBC??4525344_*_*_xxx??.xml'; // маска для архивации сообщений по юр. лицам и иже с ними
  BTypeMask:string = 'SFC??4525344_*_*_7??.xml'; //маска для архивации сообщений по физ. лицам (не ИП)
  BIK:string = '25344';
var
 inf:TIniFile;
 ArchiveDate:string;
 ArchiveNameA:string; //имя файла архива
 FilesStr:string;
 ArchivePathA:string;
begin
  inf:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'sp.ini');
//    date_311p       :=inf.ReadString('DIRECTORY','date_311p','');
//    count_311p      :=inf.ReadInteger('DIRECTORY','count_311p',0);
  inf.free;

  ArchiveDate:=DateToStr(now);
{  if date_311p=ArchiveDate then
    inc(count_311p) else begin
     date_311p:=ArchiveDate;
     count_311p:=0;
    end;}

  inf:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'sp.ini');
//    inf.WriteString('DIRECTORY','date_311p',date_311p);
//    inf.WriteInteger('DIRECTORY','count_311p',count_311p);
  inf.free;

  ArchiveDate:= FormatDateTime('yymmdd', strtodatetime(ArchiveDate));
//  FilesStr:= '0000' + inttostr(count_311p);
  FilesStr:=copy(FilesStr, Length(FilesStr)-3,4);

  //формируем имя файла архива
  ArchiveNameA:= 'AN' + BIK + ArchiveDate + FilesStr +'.arj';
  //ArchiveNameB = "BN"& BIK & ArchiveDay & FilesStr &".arj"

  //Полный путь к файлу архива - для каждого типа
  ArchivePathA:=ARJ_311P_OUT +ArchiveNameA;
  //ArchivePathB = ArchivePath & ArchiveNameB

  // архивируем
  ShellExecute(0,'open',PChar(ARJ), pchar(' m -e '+ ArchivePathA+' '+f), pchar(ExtractFileDir(ARJ)), SW_SHOW);
  Sleep(1000);
  Result:=ArchivePathA;
end;
{**********************************************************************
    фтс 365-п ответы BOS
************************************************************************}
procedure TForm1.Button1Click(Sender: TObject);
var
  f,lastfile_arj,tk:string;
  sr: TSearchRec;
  i:integer;
begin
  if OpenDialog1.Execute then begin
    for i:=0 to OpenDialog1.Files.Count - 1 do begin
      f:=OpenDialog1.Files.Strings[i];
      message_list('----------фнс 365-п ответы ' + f + '-----------');
      run(f,BUTTON5_EVAL);
    end;
  run(f,'SCRIPT(SCRIPT_365P);');
  ShowMessage('Сформирован сводный архив');
  if SysUtils.FindFirst(ARJ_365P_OUT2+'*.arj', faAnyFile, sr) = 0 then
    lastfile_arj:=ARJ_365P_OUT2 + sr.Name;
  FindClose(sr);
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Сводный архив подписан КА');

  tk:=inttostr(MonthOf(now));
  if Length(tk)=1 then tk:='0'+tk;
  tk:=_365P_TK +'a'+tk+'344.099.arj';
  // создаем транспортный конверт
  lastfile_arj:=ARJ_run(lastfile_arj,ARJ_365P_OUT2 + tk,'');
  ShowMessage('Сформирован транспортный конверт');
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Транспортный конверт подписан КА');
  message_list(movefile_(lastfile_arj,UTA_365p_OUT));
  end;
end;
{**********************************************************************
    фтс 365-п квитанции PB1
************************************************************************}
procedure TForm1.Button8Click(Sender: TObject);
var
  f,lastfile_arj,tk:string;
  sr: TSearchRec;
  i:integer;
begin
  if OpenDialog1.Execute then begin
    for i:=0 to OpenDialog1.Files.Count - 1 do begin
      f:=OpenDialog1.Files.Strings[i];
      message_list('----------фнс 365-п квитанции ' + f + '-----------');
      run(f,BUTTON6_EVAL);
    end;
  run(f,'SCRIPT(SCRIPT_365P);');
  ShowMessage('Сформирован сводный архив');
  if SysUtils.FindFirst(ARJ_365P_OUT2+'*.arj', faAnyFile, sr) = 0 then
    lastfile_arj:=ARJ_365P_OUT2 + sr.Name;
  FindClose(sr);
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Сводный архив подписан КА');

  tk:=inttostr(MonthOf(now));
  if Length(tk)=1 then tk:='0'+tk;
  tk:=_365P_TK +'a'+tk+'344.099.arj';
  // создаем транспортный конверт
  lastfile_arj:=ARJ_run(lastfile_arj,ARJ_365P_OUT2 + tk,'');
  ShowMessage('Сформирован транспортный конверт');
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Транспортный конверт подписан КА');
  message_list(movefile_(lastfile_arj,UTA_365p_OUT));
  end;
end;

function TForm1.ARJ_extract(name_archive, out_catalog: string): string;
begin
  ShellExecute(0,'open',PChar(ARJ), pchar('e '+name_archive), pchar(ExtractFileDir(out_catalog)), SW_SHOW);
  sleep(1000);
  result:='Распакован '+name_archive;
end;

end.
