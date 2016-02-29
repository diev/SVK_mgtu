unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, shellapi,
  Dialogs,inifiles, StdCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids,
  Menus, DB, ADODB;

type

  StrTD = record
    path,maska,arhiv,target:string;
  end;

  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SGIN: TStringGrid;
    TabSheet3: TTabSheet;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    asrkeyw1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    KLIKO1: TMenuItem;
    N364P1: TMenuItem;
    N3111: TMenuItem;
    N3651: TMenuItem;
    N3652: TMenuItem;
    SGIN2: TStringGrid;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    N7: TMenuItem;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    N32311: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function archive(fl,target:string):string;
    function movefile_(fl,target:string):string;
    function run(fl,eval:string):string;
    procedure Log(mes: string);
    procedure message_list(ms,file_name:string);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure TimerProc(Sender: TObject);
    function ARJ_run(in_,out_,arch:string):string;
    function ARJ_extract(name_archive,out_catalog:string):string;
    procedure Button1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    function DBfirstInsert(fn,arj,tk:string):string;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure N32311Click(Sender: TObject);
    function DBfirstEdit(id, arj, tk: string): string;    

  private
    KLIKO_OUT_ARHIV,UTA_KLIKO_OUT,
    ARJ_364P_OUT,_364P_OUT_ARHIV,SCRIPT_364P,UTA_364P_OUT,_364P_TK,ARJ_364P_OUT2,
    ARJ_311P_OUT,_311P_OUT_ARHIV,SCRIPT_311P,UTA_311P_OUT,_311P_TK,ARJ_311P_OUT2,
    ARJ_365P_OUT,_365P_OUT_ARHIV,SCRIPT_365P,UTA_365P_OUT,_365P_TK,ARJ_365P_OUT2,ARJ_365P_OUT_kvit,
    TRANSFER_OUT_ARHIV,UTA_TRANSFER_OUT,
    PATH_LOGI,
    DEN:string;
    LOGI:Boolean;BUTTON1_EVAL,BUTTON2_EVAL,BUTTON3_EVAL,BUTTON4_EVAL,BUTTON5_EVAL,BUTTON6_EVAL,BUTTON7_EVAL:string;
    DIR:string;
    TimerPool:array of TTimer;
    TimerData:array of StrTD;
    ARJ:string;
    ind_SG,ind_SG2:integer;
  public
  end;

var
  Form1: TForm1;
    SEC1,PUB1,SERIA1,SEC2,PUB2,SERIA2,txt_verba_o_dll,
    SEC3,PUB3,SERIA3,Abonents_list,key_dev1,key_dev2,key_dev3:string;
    NUM_KEY1,NUM_KEY2,NUM_KEY3,kliko,fts:integer;

implementation

uses unit_Verba, DateUtils, Unit2, Math;

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
  form1.Caption:=form1.Caption+' 1.7.5 от 11/02/2016 ';
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

  TRANSFER_OUT_ARHIV:=inf.ReadString('DIRECTORY','TRANSFER_OUT_ARHIV','');
  UTA_TRANSFER_OUT:=inf.ReadString('DIRECTORY','UTA_TRANSFER_OUT','');

  DIR             :=inf.ReadString('DIRECTORY','DIR','');
  PATH_LOGI       :=inf.ReadString('DIRECTORY','PATH_LOGI','');
  LOGI            :=inf.ReadBool('COMMON','LOGI',false);
  ARJ             :=inf.ReadString('COMMON','ARJ','');

  BUTTON1_EVAL   :=inf.ReadString('COMMON','BUTTON1_EVAL','');
  BUTTON2_EVAL   :=inf.ReadString('COMMON','BUTTON2_EVAL','');
  BUTTON3_EVAL   :=inf.ReadString('COMMON','BUTTON3_EVAL','');
  BUTTON4_EVAL   :=inf.ReadString('COMMON','BUTTON4_EVAL','');
  BUTTON5_EVAL   :=inf.ReadString('COMMON','BUTTON5_EVAL','');
  BUTTON6_EVAL   :=inf.ReadString('COMMON','BUTTON6_EVAL','');
  BUTTON7_EVAL   :=inf.ReadString('COMMON','BUTTON7_EVAL','');

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

  SGIN.Rows[0].Add('Дата');
  SGIN.Rows[0].Add('Время');
  SGIN.Rows[0].Add('Информация');
  SGIN.Rows[0].Add('Файл');
  ind_SG:=1;
  message_list('Начало обработки','');

  SGIN2.Rows[0].Add('Путь');
  SGIN2.Rows[0].Add('Маска');
  SGIN2.Rows[0].Add('Архив');
  SGIN2.Rows[0].Add('Назначение');
  SGIN2.Rows[0].Add('Интервал');
  ind_SG2:=1;

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
      SGIN2.Rows[ind_SG2].Add(TimerData[kt].path);
      SGIN2.Rows[ind_SG2].Add(TimerData[kt].maska);
      SGIN2.Rows[ind_SG2].Add(TimerData[kt].arhiv);
      SGIN2.Rows[ind_SG2].Add(TimerData[kt].target);
      SGIN2.Rows[ind_SG2].Add(inttostr(TimerPool[kt].Interval div 1000));
      inc(ind_SG2);

      inc(kt);
    end;

 try
   ADOConnection1.ConnectionString:='Provider=Microsoft.ACE.OLEDB.12.0;'+
                                    'User ID=Admin;'+
                                    'Data Source='+ExtractFilePath(Application.ExeName)+'base.mdb;'+
                                    'Mode=Share Deny None;'+
                                    'Jet OLEDB:System database="";'+
                                    'Jet OLEDB:Registry Path="";'+
                                    'Jet OLEDB:Database Password="";'+
                                    'Jet OLEDB:Engine Type=6;'+
                                    'Jet OLEDB:Database Locking Mode=1;'+
                                    'Jet OLEDB:Global Partial Bulk Ops=2;'+
                                    'Jet OLEDB:Global Bulk Transactions=1;'+
                                    'Jet OLEDB:New Database Password="";'+
                                    'Jet OLEDB:Create System Database=False;'+
                                    'Jet OLEDB:Encrypt Database=False;'+
                                    'Jet OLEDB:Don''t Copy Locale on Compact=False;'+
                                    'Jet OLEDB:Compact Without Replica Repair=False;'+
                                    'Jet OLEDB:SFP=False;'+
                                    'Jet OLEDB:Support Complex Data=False;';
   ADOConnection1.Connected:=true;
   ADOQuery1.SQL.Clear;
   ADOQuery1.SQL.Add('select * from docs order by id');
   ADOQuery1.Close;
   ADOQuery1.Open;
 except
    on E: Exception do begin
      Log('Ошибка соединения с БД: ' + e.Message);
      ShowMessage('Ошибка соединения с БД: ' + e.Message);
      Halt;
    end;  
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
            message_list(archive(newname,TimerData[ind].arhiv),sr.Name);
            DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
            if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
            message_list(movefile_(newname,TimerData[ind].target+DEN),sr.Name);
          end;
          //311P
          if ind = 1 then begin
           // квитанция от цб
           if pos('GU_',sr.Name) = 0 then begin
               message_list('311p квитанция от цб','');
               message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv),sr.Name);

               lastfile_arj:=TimerData[ind].PATH+sr.Name;
               message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),sr.Name);
               lastfile_arj:=StringReplace(lastfile_arj, 'ARJ', 'XML',[rfReplaceAll, rfIgnoreCase]);
               run(lastfile_arj,'DELSIGN;');
               if FileExists(TimerData[ind].PATH+sr.Name) then DeleteFile(TimerData[ind].PATH+sr.Name);

               DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
               if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
               sleep(1000);
               message_list(movefile_(lastfile_arj,TimerData[ind].target+DEN),lastfile_arj);
           end;
          end;
          if ind = 2 then begin
           // квитанция от фнс
           if pos('GU_',sr.Name) <> 0 then begin
               message_list('311p квитанция от фнс','');
               message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv),sr.Name);

               lastfile_arj:=TimerData[ind].PATH+sr.Name;
               message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),sr.Name);
               if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);
               lastfile_arj:=TimerData[ind].PATH+copy(sr.Name,4,length(sr.Name));
               message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),lastfile_arj);
               if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

               if SysUtils.FindFirst(TimerData[ind].PATH+'*.XML', faAnyFile, sr1) = 0 then
                repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  run(TimerData[ind].PATH+sr1.Name,'DELSIGN;');
                  sleep(1000);
                  message_list(movefile_(TimerData[ind].PATH+sr1.Name,TimerData[ind].target),sr1.Name);
                end;
                until FindNext(sr1) <> 0;
               FindClose(sr1);
           end;
          end;

         if ind = 3 then begin
            // kliko
            message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv),sr.Name);
            run(TimerData[ind].PATH+sr.Name,'DELSIGN;');
            DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
            if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
            sleep(1000);
            message_list(movefile_(TimerData[ind].PATH+sr.Name,TimerData[ind].target+DEN),sr.Name);
//            id:=DBfin_forKvit(readKvit(sr.Name));
//            if id<>'0' then DBKvit(ID,sr.Name,'-','-',1);
         end;

         // 402p
         if ind = 4 then begin

            message_list('402p ------------','');
            newname:=TimerData[ind].PATH+sr.Name+postfix+ExtractFileExt(sr.Name);
            RenameFile(TimerData[ind].PATH+sr.Name,newname);
            message_list(archive(newname,TimerData[ind].arhiv),sr.Name);

            lastfile_arj:=newname;
            message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),sr.Name);
            if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);
            // фнс
            if SysUtils.FindFirst(TimerData[ind].PATH+'*.arj', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  lastfile_arj:=TimerData[ind].PATH+sr1.Name;
                  message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),'');
                  sleep(1000);
                  if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.xml', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          run(TimerData[ind].PATH+sr2.Name,'DELSIGN;');
                          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
                          if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
                          sleep(1000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target+DEN),'');
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);

                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);

         end;

         // 364p
         if ind = 5 then begin
          message_list('364p ------------','');
          message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv),'');
          AssignFile(f,TimerData[ind].PATH+sr.Name);Reset(f);Readln(f,s);s:=DosToWin(s);CloseFile(f);
          //цб
          if Pos('Территориальное учреждение',s)<>0 then begin
            message_list('364p квитанция от цб','');
            run(TimerData[ind].PATH+sr.Name,'DELSIGN;');
            DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
            if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
            sleep(1000);
            message_list(movefile_(TimerData[ind].PATH+sr.Name,TimerData[ind].target+DEN),'');
          end else begin //фтс
            message_list('364p квитанция от фтс','');
            lastfile_arj:=TimerData[ind].PATH+sr.Name;
            message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),'');
            if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

            if SysUtils.FindFirst(TimerData[ind].PATH+'*.arj', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  lastfile_arj:=TimerData[ind].PATH+sr1.Name;
                  message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),'');
                  sleep(1000);
                  if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.xml', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          run(TimerData[ind].PATH+sr2.Name,'DELSIGN;');
                          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
                          if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
                          sleep(1000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target+DEN),'');
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);

                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);
          end; //

         end;

         // 365p
        if ind = 6 then begin
            message_list('365p ------------','');
            newname:=TimerData[ind].PATH+sr.Name+postfix+ExtractFileExt(sr.Name);
            RenameFile(TimerData[ind].PATH+sr.Name,newname);
            message_list(archive(newname,TimerData[ind].arhiv),'');

            lastfile_arj:=newname;
            message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),'');
            if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);
            // квитанция от цб
            if SysUtils.FindFirst(TimerData[ind].PATH+'*.txt', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  message_list('365p квитанция от цб','');
                  run(TimerData[ind].PATH+sr1.Name,'DELSIGN;');
                  DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
                  if not DirectoryExists('Z:\CB_kvit\'+DEN) then ForceDirectories('Z:\CB_kvit\'+DEN);    // danger !!!!!!!!!
                  sleep(1000);
                  message_list(movefile_(TimerData[ind].PATH+sr1.Name,'Z:\CB_kvit\'+DEN),'');
                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);

            // квитанция или входящий от фнс
            if SysUtils.FindFirst(TimerData[ind].PATH+'afn*.arj', faAnyFile, sr1) = 0 then
              repeat
                if (sr1.Name<>'.') and (sr1.Name <>'..') and (sr1.Attr<>faDirectory) then begin
                  lastfile_arj:=TimerData[ind].PATH+sr1.Name;
                  message_list(ARJ_extract(lastfile_arj,ExtractFilePath(lastfile_arj)),'');
                  sleep(1000);
                  if FileExists(lastfile_arj) then DeleteFile(lastfile_arj);

                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.txt', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          message_list('365p квитанция от фнс','');
                          run(TimerData[ind].PATH+sr2.Name,'DELSIGN;');
                          sleep(1000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target),'');
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);


                    if SysUtils.FindFirst(TimerData[ind].PATH+'*.vrb', faAnyFile, sr2) = 0 then
                      repeat
                        if (sr2.Name<>'.') and (sr2.Name <>'..') and (sr2.Attr<>faDirectory) then begin
                          message_list('365p ВНИМАНИЕ ВХОДЯЩИЙ от фнс','');
                          run(TimerData[ind].PATH+sr2.Name,'LOADKEY_2;DECRYPT;RESETKEY_2;');
                          sleep(2000);
                          message_list(movefile_(TimerData[ind].PATH+sr2.Name,TimerData[ind].target),'');
                        end;
                      until FindNext(sr2) <> 0;
                    FindClose(sr2);

                end;
              until FindNext(sr1) <> 0;
            FindClose(sr1);

         end; 
        if ind = 7 then begin
          message_list('transfer квитанция ------------','');
          message_list(archive(TimerData[ind].PATH+sr.Name,TimerData[ind].arhiv),sr.Name);
          run(TimerData[ind].PATH+sr.Name,'DELSIGN;');
          DEN:=copy(DateToStr(Now),7,4)+copy(DateToStr(Now),4,2)+copy(DateToStr(Now),1,2)+'\';
          if not DirectoryExists(TimerData[ind].target+DEN) then ForceDirectories(TimerData[ind].target+DEN);
          sleep(1000);
          message_list(movefile_(TimerData[ind].PATH+sr.Name,TimerData[ind].target+DEN),sr.Name);
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
  if OpenDialog1.Execute then begin
    f:=OpenDialog1.FileName;
    message_list('ОТЧЕТНОСТЬ KLIKO',ExtractFileName(f));
    run(f,BUTTON1_EVAL);
    DBfirstInsert(ExtractFileName(f),'-','-');
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
      message_list('ПОЛОЖЕНИЕ 364П ФТС',f);
      run(f,BUTTON2_EVAL);
      DBfirstInsert(ExtractFileName(f),'-','-');      
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
  message_list(movefile_(lastfile_arj,UTA_364p_OUT),'');
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
      message_list('ПОЛОЖЕНИЕ 311П ФНС',f);
      run(f,BUTTON4_EVAL);
      DBfirstInsert(ExtractFileName(f),'-','-');      
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
        message_list(movefile_(lastfile_arj,UTA_311p_OUT),'');
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
procedure TForm1.message_list(ms,file_name: string);
begin
  SGIN.Rows[ind_SG].Add(Datetostr(date));
  SGIN.Rows[ind_SG].Add(timetostr(time));
  SGIN.Rows[ind_SG].Add(ms);
  SGIN.Rows[ind_SG].Add(file_name);
  inc(ind_SG);
  Log(ms);
end;
{**********************************************************************
    проверить ключи
************************************************************************}
procedure TForm1.Button3Click(Sender: TObject);
begin
  message_list(vrb.checkKey(''),'');
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
    if      command = 'LOADKEY_1'  then Log(Vrb.Load_key_('1'))
    else if command = 'LOADKEY_2'  then Log(Vrb.Load_key_('2'))
    else if command = 'SIGN_1'     then Log(vrb.Sign(fl,NUM_KEY1,SERIA1))
    else if command = 'SIGN_2'     then Log('')
    else if command = 'DELSIGN'    then Log(vrb.DelSign_(fl))
    else if command = 'RESETKEY_1' then Log(vrb.ResetKey_(inttostr(NUM_KEY1) + SERIA1))
    else if command = 'RESETKEY_2' then Log(vrb.ResetKey_(inttostr(NUM_KEY2) + SERIA2))
    else if command = 'CRYPT_1(KLIKO)' then Log(vrb.EnCrypt(fl,NUM_KEY1,SERIA1,kliko))
    else if command = 'CRYPT_2(FTS)' then Log(vrb.EnCrypt(fl,NUM_KEY2,SERIA2,fts))
    else if command = 'DECRYPT' then Log(vrb.DeCrypt(fl))
    else if pos('MOVE',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='UTA_KLIKO_OUT' then target:=UTA_KLIKO_OUT
            else if parametr='ARJ_364P_OUT' then target:=ARJ_364P_OUT
            else if parametr='ARJ_311P_OUT' then target:=ARJ_311P_OUT
            else if parametr='ARJ_365P_OUT' then target:=ARJ_365P_OUT
            else if parametr='ARJ_365P_OUT_kvit' then target:=ARJ_365P_OUT_kvit
            else target:=parametr;
            message_list(movefile_(fl,target),'');
          end
    else if pos('ARCHIVE',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='KLIKO_OUT_ARHIV' then target:=KLIKO_OUT_ARHIV
            else if parametr='_364P_OUT_ARHIV' then target:=_364P_OUT_ARHIV
            else if parametr='_311P_OUT_ARHIV' then target:=_311P_OUT_ARHIV
            else if parametr='_365P_OUT_ARHIV' then target:=_365P_OUT_ARHIV
            else if parametr='TRANSFER_OUT_ARHIV' then target:=TRANSFER_OUT_ARHIV
            else target:=parametr;
            Log(archive(fl,target));
          end
    else if pos('SCRIPT',command)<>0 then begin
            parametr:= Copy(command,pos('(',command)+1,length(command));
            Delete(parametr,length(parametr),1);

            if parametr='SCRIPT_364P' then script_name:=SCRIPT_364P
            else if parametr='SCRIPT_311P' then script_name:=SCRIPT_311P
            else if parametr='SCRIPT_365P' then script_name:=SCRIPT_365P
            else script_name:=parametr;
            ShellExecute(0,'open',PChar(script_name), pchar(''), pchar(ExtractFileDir(script_name)), SW_SHOW);
            Log('запущен скрипт ' + script_name);
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
      message_list('ПОЛОЖЕНИЕ 365П ответы',f);
      run(f,BUTTON5_EVAL);
      DBfirstInsert(ExtractFileName(f),'-','-');
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
  message_list(movefile_(lastfile_arj,UTA_365p_OUT),'');
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
      message_list('ПОЛОЖЕНИЕ 365П квитанции',f);
      run(f,BUTTON6_EVAL);
      DBfirstInsert(ExtractFileName(f),'-','-');
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
  message_list(movefile_(lastfile_arj,UTA_365p_OUT),'');
  end;
end;
{**********************************************************************
    ведомости
************************************************************************}
procedure TForm1.N32311Click(Sender: TObject);
var
  f,dir,lastfile_arj,mes,id:string;
  i:integer;  Stream: TFileStream;
begin
// решить вопрос с отчетной датой
  if OpenDialog1.Execute then begin
    for i:=0 to OpenDialog1.Files.Count - 1 do begin
      f:=OpenDialog1.Files.Strings[i];
      dir:=ExtractFilePath(f);
      message_list('TRANSFER',ExtractFileName(f));
      run(f,BUTTON7_EVAL);
      id:=DBfirstInsert(ExtractFileName(f),'-','-');
    end;
  // создаем Заголовок.xml
  Stream := TFileStream.Create(dir+'Заголовок.xml',fmCreate);
  try
    Stream.Seek(0, soFromEnd);mes:='';
    mes:='<?xml version="1.0" encoding="windows-1251" ?> '+#10;
    mes:=mes+'<Заголовок>'+#10;
    mes:=mes+'  <Сведения Код="VBKClose" >'+#10;
    mes:=mes+'    <Отправитель РегНомер="1067/3" Наименование="Филиал ОАО БайкалИнвестБанк в г.Москва" />'+#10;
    mes:=mes+'    <Данные ОтчетнаяДата="****-**-**" >'+#10;
    for i:=0 to OpenDialog1.Files.Count - 1 do begin
      f:=OpenDialog1.Files.Strings[i];
      mes:=mes+'      <Файл Имя="'+ ExtractFileName(f)+'" />'+#10;
    end;
    mes:=mes+'    </Данные>'+#10;
    mes:=mes+'  </Сведения>'+#10;
    mes:=mes+'</Заголовок>'+#10;
    Stream.WriteBuffer(Pointer(mes)^, Length(mes));
  finally
    Stream.Free;
  end;
  // создаем транспортный конверт
  lastfile_arj:=ARJ_run(dir+'*.*',dir+'TRANSFER.ARJ','');
  ShowMessage('Сформирован транспортный конверт');
  run(lastfile_arj,'LOADKEY_1;SIGN_1;RESETKEY_1;');
  ShowMessage('Транспортный конверт подписан КА');
  if id<>'0' then DBfirstEdit(id,'-',ExtractFileName(lastfile_arj));

  message_list(movefile_(lastfile_arj,UTA_TRANSFER_OUT),'');
  end;
end;
{**********************************************************************
    распаковка
************************************************************************}
function TForm1.ARJ_extract(name_archive, out_catalog: string): string;
begin
  ShellExecute(0,'open',PChar(ARJ), pchar('e '+name_archive), pchar(ExtractFileDir(out_catalog)), SW_SHOW);
  sleep(1000);
  result:='Распакован '+name_archive;
end;
{**********************************************************************
    пишем отправляемый файл
************************************************************************}
function TForm1.DBfirstInsert(fn, arj, tk: string): string;
begin
  ADOQuery1.Insert;
  ADOQuery1.FieldByName('data').AsDateTime:=now;
  ADOQuery1.FieldByName('file_name').AsString:=fn;
  ADOQuery1.FieldByName('svod_arj').AsString:=arj;
  ADOQuery1.FieldByName('tk').AsString:=tk;
  ADOQuery1.Post;

  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('select top 1 id from docs order by id desc');
  ADOQuery2.Close;
  ADOQuery2.Open;

  if ADOQuery2.RecordCount > 0 then begin
    ADOQuery2.First;
    Result:=ADOQuery2.FieldByName('id').AsString;
  end
  else Result:='0';
end;
{**********************************************************************
    пишем по первому файлу
************************************************************************}
function TForm1.DBfirstEdit(id, arj, tk: string): string;
begin
  ADOQuery1.Locate('id',id,[]);
  ADOQuery1.Edit;
  ADOQuery1.FieldByName('svod_arj').AsString:=arj;
  ADOQuery1.FieldByName('tk').AsString:=tk;
  ADOQuery1.Post;
end;
{**********************************************************************
    окно деталей
************************************************************************}
procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  Form2.ShowModal;
end;

{function TForm1.DBKvit(id,fn, arj, tk: string;n:integer): string; // добавить в логи по id
begin
  ADOQuery1.Locate('id',id,[]);
  ADOQuery1.Edit;
  if n = 1 then begin
    ADOQuery1.FieldByName('kvit1_data').AsDateTime:=now;
    ADOQuery1.FieldByName('kvit1_file').AsString:=fn;
    ADOQuery1.FieldByName('kvit1_svod_arj').AsString:=arj;
    ADOQuery1.FieldByName('kvit1_tk').AsString:=tk;
  end;
  if n = 2 then begin
    ADOQuery1.FieldByName('kvit2_data').AsDateTime:=now;
    ADOQuery1.FieldByName('kvit2_file').AsString:=fn;
    ADOQuery1.FieldByName('kvit2_svod_arj').AsString:=arj;
    ADOQuery1.FieldByName('kvit2_tk').AsString:=tk;
  end;
  if n = 3 then begin
    ADOQuery1.FieldByName('kvit3_data').AsDateTime:=now;
    ADOQuery1.FieldByName('kvit3_file').AsString:=fn;
    ADOQuery1.FieldByName('kvit3_svod_arj').AsString:=arj;
    ADOQuery1.FieldByName('kvit3_tk').AsString:=tk;
  end;
  ADOQuery1.Post;
end;
{**********************************************************************
    read kvit
    result file name original
************************************************************************
function TForm1.readKvit(f: string): string;
begin
  Result:='123.FB2';
end;
{**********************************************************************
    rfind id from docs
************************************************************************
function TForm1.DBfin_forKvit(f: string): string;
begin
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('select id from docs where file_name = :f'); // добавить дату до текущей
  ADOQuery2.Parameters.ParamByName('f').Value:=f;
  ADOQuery2.Close;
  ADOQuery2.Open;

  if ADOQuery2.RecordCount > 0 then Result:=ADOQuery2.FieldByName('id').AsString
  else Result:='0';
end;

procedure TForm1.N1231Click(Sender: TObject);
var
  id:string;
begin
  id:=DBfin_forKvit(readKvit(''));
  if id<>'0' then DBKvit(ID,'kvit_001.txt','123.arj','tza02.099',1);
  if id<>'0' then DBKvit(ID,'kvit_002.txt','1232.arj','tza022.099',2);
  if id<>'0' then DBKvit(ID,'kvit_003.txt','-','-',3);
end;
}

end.
