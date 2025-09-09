unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, DateUtils, IdCustomHTTPServer, IdHTTPServer,
  XMLDoc, XMLIntf, IdContext, SQLite3, SQLite3Wrap, SHDocVw, ActiveX, IniFiles, LangFile,
  Vcl.Imaging.pngimage;

type
  TMain = class(TForm)
    ActionPanel: TPanel;
    AddBtn: TBitBtn;
    SettingsBtn: TBitBtn;
    IdHTTPServer: TIdHTTPServer;
    CoordinatesLbl: TLabel;
    RadiusLbl: TLabel;
    PlaceNameLbl: TLabel;
    DateTimeLbl: TLabel;
    CategoryLbl: TLabel;
    CoordinatesEdt: TEdit;
    RadiusTB: TTrackBar;
    PlaceNameEdt: TEdit;
    CatsCB: TComboBox;
    LeftPanel: TPanel;
    PlacesLB: TListBox;
    FoldersBtn: TBitBtn;
    SearchBtn: TBitBtn;
    SearchEdt: TEdit;
    ActionPanel2: TPanel;
    RemBtn: TBitBtn;
    DoneBtn: TBitBtn;
    RightPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DoneBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlacesLBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure IdHTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure RadiusTBChange(Sender: TObject);
    procedure RemBtnClick(Sender: TObject);
    procedure PlacesLBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchBtnClick(Sender: TObject);
    procedure FoldersBtnClick(Sender: TObject);
    procedure SearchEdtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchEdtKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchEdtMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure LoadPlace;
    procedure LoadCat;
    { Private declarations }
  public
    CategoriesAtRun: boolean;
    function SQLDBTableExists(TableName: string): boolean;
    function SQLTBCount(TableName: string): integer;
    procedure LoadPlaces;
    procedure ImportPlaces(FileName: string);
    procedure ExportPlaces(FileName: string);
    { Public declarations }
  end;

var
  Main: TMain;
  SQLDB: TSQLite3Database;
  DBFileName: string;
  AllowedIPs, AuthorizedDevices, CategoriesList: TStringList;
  AllowAnyIPs, BlockReqNewDevs: boolean;
  UseDarkTheme, UseThemeTime: boolean;

  DarkThemeStartHour, DarkThemeEndHour: integer;
  PlacesListIndex: TStringList;
  CurPlaceID: int64 = -1;
  CurDateTime: int64;
  CatsShown: boolean = false;

  IDS_RADIUS, IDS_DISTANCE_UNIT_SMALL, IDS_SEARCH, IDS_SYNC, IDS_DEV_SYNC_CONFIRM, IDS_LAST_UPDATE,
  IDS_NO_CATEGORIES, IDS_COORDINATES_INCORRECT: string;

  IDS_SETTINGS, IDS_INTERFACE, IDS_DARK_THEME, IDS_THEME_TIME, IDS_DARK_THEME_START,
  IDS_DARK_THEME_END, IDS_SYNCHRONIZATION, IDS_SYNC_PORT, IDS_SYNC_WITH_ANY_IPS, IDS_ALLOW_IPS,
  IDS_ALLOW_DEVS, IDS_ALLOW_DEV_REM, IDS_ENTER_DEV_ID, IDS_BLOCK_REQUEST_NEW_DEVS, IDS_IMPORT,
  IDS_EXPORT, IDS_PLACES, IDS_CATEGORIES, IDS_CATEGORIES_AT_RUN, IDS_DONE, IDS_OK, IDS_CANCEL: string;

const
  AllowedIPsFile = 'AllowedIPs.txt';
  AppName = 'EasyPlaces';

implementation

{$R *.dfm}

uses Unit2;

// TimeStamp по Гринвичу GMT или UTC +0
function GetTimeStamp: int64;
var
 SystemTime: TSystemTime;
begin
  GetSystemTime(SystemTime);
  with SystemTime do
    Result:=DateTimeToUNIX(EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMinute, wSecond, wMilliseconds));
end;

function StrToCharCodes(Str: string): string;
var
  i: integer;
begin
  Result:='';
  for i:=1 to Length(Str) do
    Result:=Result + 'x' + IntToStr( Ord( Str[i] ) );
end;

function CharCodesToStr(Str: string): string;
var
  i: integer;
begin
  Result:='';
  if Length(Str) = 0 then Exit;
  if Str[1] <> 'x' then Exit;
  Delete(Str, 1, 1);
  Str:=Str + 'x';
  while Pos('x', Str) > 0 do begin
    Result:=Result + Chr( StrToIntDef ( Copy( Str, 1, Pos('x', Str) - 1), 0 ) );
    Delete(Str, 1, Pos('x', Str));
  end;
end;

function PlaceDateTime(sDate: string): string; // Äàòà â ìåñòå
var
  mTime, nYear: string;
begin
  sDate:=DateTimeToStr(UNIXToDateTime(StrToInt64(sDate))); // ??????? TimeStamp ? DateTimeStr

  mTime:=Copy(sDate, Pos(' ', sDate) + 1, Length(sDate) - Pos(' ', sDate));
  nYear:=FormatDateTime('yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate))));

  if nYear = FormatDateTime('yyyy', Date) then
    Result:=FormatDateTime('d mmm.', StrToDate(Copy(sDate, 1, Pos(' ', sDate)))) + ' ' + Copy(mTime, 1, Length(mTime) - 3)
  else
    Result:=FormatDateTime('d.mm.yyyy', StrToDate(Copy(sDate, 1, Pos(' ', sDate)))) + ', ' + Copy(mTime, 1, Length(mTime) - 3);
end;

procedure TMain.SearchBtnClick(Sender: TObject);
begin
  if CatsShown then begin
    LoadPlaces;
    CatsShown:=false;
  end;

  if SearchEdt.Visible then begin
    LoadPlaces;
    SearchEdt.Clear;
  end else begin
    SearchEdt.Text:=IDS_SEARCH;
    SearchEdt.Font.Color:=clGray;
  end;
  SearchEdt.Visible:=not SearchEdt.Visible;
end;

procedure TMain.SearchEdtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer; SQLTB: TSQLite3Statement; PlaceName, SearchValue: string;
begin
  if SearchEdt.Text = IDS_SEARCH then begin
    SearchEdt.Font.Color:=clBlack;
    SearchEdt.Clear;
  end;

  if Trim(SearchEdt.Text) = '' then begin LoadPlaces; Exit; end;
  SQLTB:=SQLDB.Prepare('SELECT * FROM Places ORDER BY DateTime DESC');
  PlacesLB.Clear;
  PlacesListIndex.Clear;
  SearchValue:=AnsiLowerCase(SearchEdt.Text);
  try
    while SQLTB.Step = SQLITE_ROW do begin
      PlaceName:=CharCodesToStr(SQLTB.ColumnText(1));
      if Pos(SearchValue, AnsiLowerCase(PlaceName)) > 0 then begin
        PlacesLB.Items.Add(PlaceName);
        PlacesListIndex.Add(SQLTB.ColumnText(0));
      end;
    end;
  finally
    SQLTB.Free;
  end;
end;

procedure TMain.SearchEdtKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if SearchEdt.Text = '' then begin
    SearchEdt.Font.Color:=clGray;
    SearchEdt.Text:=IDS_SEARCH;
  end;
end;

procedure TMain.SearchEdtMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if SearchEdt.Text = IDS_SEARCH then begin
    SearchEdt.Font.Color:=clBlack;
    SearchEdt.Clear;
  end;
end;

procedure TMain.SettingsBtnClick(Sender: TObject);
begin
  Settings.ShowModal;
end;

function TMain.SQLDBTableExists(TableName: string): boolean;
var
  SQLTB: TSQLite3Statement;
begin
  Result:=false;
  SQLTB:=SQLDB.Prepare('SELECT * FROM sqlite_master WHERE name = "' + TableName + '" LIMIT 1');
  try
    if SQLTB.Step = SQLITE_ROW then
      Result:=true;
  finally
    SQLTB.Free;
  end;
end;

function TMain.SQLTBCount(TableName: string): integer;
var
  SQLTB: TSQLite3Statement;
begin
  Result:=0;
  SQLTB:=SQLDB.Prepare('SELECT * FROM ' + TableName);
  try
    while SQLTB.Step = SQLITE_ROW do begin
      Inc(Result);
    end;
  finally
    SQLTB.Free;
  end;
end;

procedure SetCBIndexByText(var ComboBox: TComboBox; Str: string);
var
  i: integer;
begin
  for i:=0 to ComboBox.Items.Count - 1 do
    if ComboBox.Items[i] = Str then begin
      ComboBox.ItemIndex:=i;
      break;
    end;
end;

procedure TMain.LoadCat;
var
  i: integer; SQLTB: TSQLite3Statement;
begin
  if PlacesLB.ItemIndex = -1 then Exit;
  SQLTB:=SQLDB.Prepare('SELECT * FROM Places WHERE Category = "' + StrToCharCodes(PlacesLB.Items.Strings[PlacesLB.ItemIndex]) + '"');
  PlacesLB.Clear;
  PlacesListIndex.Clear;
  try
    while SQLTB.Step = SQLITE_ROW do begin
      PlacesLB.Items.Add(CharCodesToStr(SQLTB.ColumnText(1)));
      PlacesListIndex.Add(SQLTB.ColumnText(0));
    end;
  finally
    SQLTB.Free;
  end;
  CatsShown:=false;
end;

procedure TMain.LoadPlace;
var
  SQLTB: TSQLite3Statement; PlaceCat: string;
begin
  if PlacesLB.ItemIndex = -1 then Exit;
  CatsCB.Clear;
  CatsCB.Items.Text:=CategoriesList.Text;
  if CatsCB.Items.Count > 0 then
    CatsCB.ItemIndex:=0;
  SQLTB:=SQLDB.Prepare('SELECT * FROM Places WHERE ID=' + PlacesListIndex.Strings[PlacesLB.ItemIndex]);
  try
    if SQLTB.Step = SQLITE_ROW then begin
      CurPlaceID:=StrToInt64(SQLTB.ColumnText(0));
      PlaceNameEdt.Text:=CharCodesToStr(SQLTB.ColumnText(1));
      CoordinatesEdt.Text:=SQLTB.ColumnText(2) + ', ' + SQLTB.ColumnText(3);

      PlaceCat:=CharCodesToStr(SQLTB.ColumnText(4));
      if Pos(PlaceCat, CatsCB.Items.Text) = 0 then
        CatsCB.Items.Add(PlaceCat);
      SetCBIndexByText(CatsCB, PlaceCat);

      RadiusTB.Position:=Round(StrToFloat(SQLTB.ColumnText(5)));
      CurDateTime:=StrToInt(SQLTB.ColumnText(6));
      DateTimeLbl.Caption:=PlaceDateTime(SQLTB.ColumnText(6));
    end;
  finally
    SQLTB.Free;
  end;

  if SearchEdt.Text = '' then begin
    SearchEdt.Font.Color:=clGray;
    SearchEdt.Text:=IDS_SEARCH;
  end;
end;

procedure TMain.LoadPlaces;
var
  i: integer; SQLTB: TSQLite3Statement;
begin
  SQLTB:=SQLDB.Prepare('SELECT * FROM Places ORDER BY DateTime DESC');
  PlacesLB.Clear;
  PlacesListIndex.Clear;
  try
    while SQLTB.Step = SQLITE_ROW do begin
      PlacesLB.Items.Add(CharCodesToStr(SQLTB.ColumnText(1)));
      PlacesListIndex.Add(SQLTB.ColumnText(0));
    end;
  finally
    SQLTB.Free;
  end;
end;

procedure TMain.PlacesLBKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key <> VK_UP) and (Key <> VK_DOWN) then Exit;
  if CatsShown then
    LoadCat
  else
    LoadPlace;
end;

procedure TMain.PlacesLBMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CatsShown then
    LoadCat
  else
    LoadPlace;
end;

procedure TMain.RadiusTBChange(Sender: TObject);
begin
  RadiusLbl.Caption:=IDS_RADIUS + ' ' + IntToStr(RadiusTB.Position) + ' ' + IDS_DISTANCE_UNIT_SMALL;
end;

procedure TMain.RemBtnClick(Sender: TObject);
var
  i: integer;
begin
  if (CurPlaceID = -1) then Exit;
    SQLDB.Execute('DELETE FROM Places WHERE ID=' + IntToStr(CurPlaceID));
  for i:=0 to AuthorizedDevices.Count - 1 do
    if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
      SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[i] + ' (Action, ID) values("DELETE", ' + IntToStr(CurPlaceID) + ')');
  LoadPlaces;
  AddBtn.Click;
end;

procedure TMain.AddBtnClick(Sender: TObject);
begin
  CurPlaceID:=-1;
  PlaceNameEdt.Clear;
  CoordinatesEdt.Clear;
  CatsCB.ItemIndex:=0;
  RadiusTB.Position:=0;
  DateTimeLbl.Caption:=PlaceDateTime(IntToStr(DateTimeToUnix(Now)));
  CurDateTime:=0;
  //Width:=445;
  //Height:=262;
end;

{procedure TMain.DarkTheme;
var
  TitlePanelColor: TColor;
  BackgroundColor: TColor;
  SubFontColor: TColor;
  EditBackgroundColor: TColor;
begin
  TitlePanelColor:=RGB(32, 35, 41);
  BackgroundColor:=RGB(42, 48, 53);
  SubFontColor:=RGB(120, 124, 129);
  EditBackgroundColor:=RGB(66, 74, 81);
  ActionPanel.Color:=TitlePanelColor;
  ActionPanel2.Color:=TitlePanelColor;
  ActionPanel.BevelOuter:=bvNone;
  ActionPanel2.BevelOuter:=bvNone;
  PlacesLB.Color:=BackgroundColor;
  PlacesLB.Font.Color:=clWhite;
  PlacesLB.BorderStyle:=bsNone;
  LeftPanel.Color:=BackgroundColor;
  LeftPanel.BevelOuter:=bvNone;
  RightPanel.Color:=BackgroundColor;
  RightPanel.BevelOuter:=bvNone;
  PlaceNameLbl.Font.Color:=SubFontColor;
  PlaceNameEdt.Color:=EditBackgroundColor;
  PlaceNameEdt.BorderStyle:=bsNone;
  PlaceNameEdt.Font.Color:=clWhite;
  DateTimeLbl.Font.Color:=SubFontColor;
  CoordinatesLbl.Font.Color:=SubFontColor;
  CoordinatesEdt.Color:=EditBackgroundColor;
  CoordinatesEdt.BorderStyle:=bsNone;
  CoordinatesEdt.Font.Color:=clWhite;
  RadiusLbl.Font.Color:=SubFontColor;
  CategoryLbl.Font.Color:=SubFontColor;
  CatsCB.Color:=EditBackgroundColor;
  CatsCB.Font.Color:=clWhite;
end;}

procedure TMain.DoneBtnClick(Sender: TObject);
var
  i: integer;
  Lat, Lng: real;
  CoordStr, SLat, SLng: string;
  CommaPos: integer;
begin
  CoordStr:=Trim(CoordinatesEdt.Text);

  if CatsCB.Items.Count = 0 then begin Application.MessageBox(PChar(IDS_NO_CATEGORIES), PChar(Caption), MB_ICONWARNING);; Exit; end;

  CommaPos:=Pos(',', CoordStr);
  if (CommaPos = 0) or (CoordStr = '') then begin
    Lat:=0;
    Lng:=0;
  end else begin
    Lat:=StrToFloatDef(Trim(Copy(CoordStr, 1, CommaPos - 1)), 0);
    Lng:=StrToFloatDef(Trim(Copy(CoordStr, CommaPos + 1, Length(CoordStr))), 0);
  end;

  if (Lat = 0) and (Lng = 0) then
    Application.MessageBox(PChar(IDS_COORDINATES_INCORRECT), PChar(Caption), MB_ICONWARNING);

  //ShowMessage(DateTimeToStr(UNIXToDateTime(CurDateTime)));

  if not SQLDBTableExists('Places') then Exit;

  if CurPlaceID = -1 then begin
    CurDateTime:=DateTimeToUnix(Now);
    SQLDB.Execute('INSERT INTO Places (ID, Name, Latitude, Longitude, Category, Radius, DateTime) values(' + IntToStr(CurDateTime) + ', "' + StrToCharCodes(PlaceNameEdt.Text) + '", ' + FloatToStr(Lat) + ', ' + FloatToStr(Lng) + ', "' + StrToCharCodes(CatsCB.Items.Strings[CatsCB.ItemIndex]) + '", ' + IntToStr(RadiusTB.Position) + ', ' +  IntToStr(CurDateTime) + ')');

    for i:=0 to AuthorizedDevices.Count - 1 do
      if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
        SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[i] + ' (Action, ID, Name, Latitude, Longitude, Category, Radius, DateTime) values("INSERT", ' + IntToStr(DateTimeToUnix(Now)) + ', "' + StrToCharCodes(PlaceNameEdt.Text) + '", ' + FloatToStr(Lat) + ', ' + FloatToStr(Lng) + ', "' + StrToCharCodes(CatsCB.Items.Strings[CatsCB.ItemIndex]) + '", ' + IntToStr(RadiusTB.Position) + ', ' +  IntToStr(CurDateTime) + ')');
  end else begin
    if ((GetAsyncKeyState(VK_LSHIFT) and $8000) = 0) and ((GetAsyncKeyState(VK_RSHIFT) and $8000) = 0) then // Если Shift не нажат, то обновляем дату и время на текущее
      CurDateTime:=DateTimeToUnix(Now);

    SQLDB.Execute('UPDATE Places SET Name="' + StrToCharCodes(PlaceNameEdt.Text) + '", Latitude=' + FloatToStr(Lat) + ', Longitude=' + FloatToStr(Lng) + ', Category="' + StrToCharCodes(CatsCB.Items.Strings[CatsCB.ItemIndex]) + '", Radius=' + IntToStr(RadiusTB.Position) + ', DateTime=' + IntToStr(CurDateTime) + ' WHERE ID=' + IntToStr(CurPlaceID));
    for i:=0 to AuthorizedDevices.Count - 1 do
      if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[i]) then
        SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[i] + ' (Action, ID, Name, Latitude, Longitude, Category, Radius, DateTime) values("UPDATE", ' + IntToStr(CurPlaceID) + ', "' + StrToCharCodes(PlaceNameEdt.Text) + '", ' + FloatToStr(Lat) + ', ' + FloatToStr(Lng) + ', "' + StrToCharCodes(CatsCB.Items.Strings[CatsCB.ItemIndex]) + '", ' + IntToStr(RadiusTB.Position) + ', ' + IntToStr(CurDateTime) + ')');
  end;

  //ShowMessage(DateTimeToStr(UNIXToDateTime(CurDateTime)));


  AddBtn.Click;
  LoadPlaces;
end;

procedure TMain.FoldersBtnClick(Sender: TObject);
begin
  if SearchEdt.Visible then begin
    SearchEdt.Clear;
    SearchEdt.Visible:=false;
  end;

  if CatsShown = false then
    PlacesLB.Items.Text:=CategoriesList.Text
  else
    LoadPlaces;

  CatsShown:=not CatsShown;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IdHTTPServer.Active:=false;
  PlacesListIndex.Free;
  SQLDB.Free;
  AllowedIPs.Free;
  AuthorizedDevices.Free;
  CategoriesList.Free;
end;

function GetLocaleInformation(Flag: integer): string; // If there are multiple languages in the system (with sorting) / Если в системе несколько языков (с сортировкой)
var
  pcLCA: array [0..63] of Char;
begin
  if GetLocaleInfo((DWORD(SORT_DEFAULT) shl 16) or Word(GetUserDefaultUILanguage), Flag, pcLCA, Length(pcLCA)) <= 0 then
    pcLCA[0]:=#0;
  Result:=pcLCA;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  WND: HWND;
  SQLTB: TSQLite3Statement;
  i: integer;
  CurDate: TDateTime;
  CurHour, NilTime: Word;
  SystemLang, LangFileName: string;
  LangFile: TLangFile;
begin
  WND:=FindWindow('TMain', AppName);
  if (WND <> 0) and (ParamStr(1) <> '-show') then begin
    SetForegroundWindow(WND);
    Halt;
  end;
  Caption:=AppName;
  Application.Title:=Caption;

  FormatSettings.DecimalSeparator := '.';

  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  IdHTTPServer.DefaultPort:=Ini.ReadInteger('Main', 'Port', 736);
  AllowAnyIPs:=Ini.ReadBool('Sync', 'AllowAnyIPs', false);
  BlockReqNewDevs:=Ini.ReadBool('Sync', 'BlockRequestNewDevs', false);

  //UseDarkTheme:=Ini.ReadBool('Main', 'DarkTheme', false);
  //UseThemeTime:=Ini.ReadBool('Main', 'ThemeTime', false);

  CategoriesList:=TStringList.Create;
  CategoriesList.Text:=Ini.ReadString('Main', 'Categories', '');
  CategoriesAtRun:=Ini.ReadBool('Main', 'CategoriesAtRun', false);

  //DarkThemeStartHour:=Ini.ReadInteger('Main', 'DarkThemeStartHour', 19);
  //DarkThemeEndHour:=Ini.ReadInteger('Main', 'DarkThemeEndHour', 7);
  Ini.Free;

  IdHTTPServer.Active:=true;

  // Автоматическое изменение темы от времени суток
  if (UseDarkTheme = false) and (UseThemeTime) then begin
    DecodeTime(Now, CurHour, NilTime, NilTime, NilTime);
    if (CurHour < DarkThemeEndHour) or (CurHour >= DarkThemeStartHour) then
      UseDarkTheme:=true;
  end;
  //if UseDarkTheme then DarkTheme();

  // Перевод
  SystemLang:=GetLocaleInformation(LOCALE_SENGLANGUAGE);
  if SystemLang = 'Chinese' then
    SystemLang:='Chinese (Simplified)'
  else if Pos('Spanish', SystemLang) > 0 then
    SystemLang:='Spanish'
  else if Pos('Portuguese', SystemLang) > 0 then
    SystemLang:='Portuguese';

  LangFileName:=SystemLang + '.txt';
  if LangFileName = 'Chinese' then
    LangFileName:=GetLocaleInformation(LOCALE_SLANGUAGE); // Chinese (Traditional), Chinese (Simplified)
  if not FileExists(ExtractFilePath(ParamStr(0)) + 'Languages\' + LangFileName) then
    LangFileName:='English.txt';
  //LangFileName:='English.txt';
  //LangFileName:='Chinese (Simplified).txt';
  //LangFileName:='Chinese (Traditional).txt';
  //LangFileName:='Spanish.txt';
  //LangFileName:='Portuguese.txt';
  //LangFileName:='French.txt';
  //LangFileName:='German.txt';
  //LangFileName:='Japanese.txt';
  //LangFileName:='Italian.txt';
  //LangFileName:='Korean.txt';
  //LangFileName:='Turkish.txt';

  LangFile:=TLangFile.Create(ExtractFilePath(ParamStr(0)) + 'Languages\' + LangFileName);
  try
    PlaceNameLbl.Caption:=LangFile.GetString('NAME', 'Name:');
    CoordinatesLbl.Caption:=LangFile.GetString('COORDINATES', 'Coordinates:');
    IDS_RADIUS:=LangFile.GetString('RADIUS', 'Radius:');
    IDS_DISTANCE_UNIT_SMALL:=LangFile.GetString('DISTANCE_UNIT_SMALL', 'DISTANCE_UNIT_SMALL');
    CategoryLbl.Caption:=LangFile.GetString('CATEGORY', 'Category:');

    IDS_SEARCH:=LangFile.GetString('SEARCH', 'Search...');
    IDS_SYNC:=LangFile.GetString('SYNC', 'Sync');
    IDS_DEV_SYNC_CONFIRM:=LangFile.GetString('DEV_SYNC_CONFIRM', 'The "%s" device requests permission to sync. Allow it?');
    IDS_LAST_UPDATE:=LangFile.GetString('LAST_UPDATE', 'Last update:');
    IDS_NO_CATEGORIES:=LangFile.GetString('NO_CATEGORIES', 'No categories.');
    IDS_COORDINATES_INCORRECT:=LangFile.GetString('IDS_COORDINATES_INCORRECT', 'Coordinates are not specified or incorrect.');

    IDS_SETTINGS:=LangFile.GetString('SETTINGS', 'Settings');
    IDS_INTERFACE:=LangFile.GetString('INTERFACE', 'Interface');
    IDS_DARK_THEME:=LangFile.GetString('DARK_THEME', 'Dark theme');
    IDS_THEME_TIME:=LangFile.GetString('THEME_TIME', 'Theme is time dependent');
    IDS_DARK_THEME_START:=LangFile.GetString('DARK_THEME_START', 'Dark theme start:');
    IDS_DARK_THEME_END:=LangFile.GetString('DARK_THEME_END', 'Dark theme end:');
    IDS_SYNCHRONIZATION:=LangFile.GetString('SYNCHRONIZATION', 'Synchronization');
    IDS_SYNC_PORT:=LangFile.GetString('SYNC_PORT', 'Port:');
    IDS_SYNC_WITH_ANY_IPS:=LangFile.GetString('SYNC_WITH_ANY_IPS', 'Synchronization with any IP (not secure)');
    IDS_ALLOW_IPS:=LangFile.GetString('ALLOW_IPS', 'Allowed IP addresses:');
    IDS_ALLOW_DEVS:=LangFile.GetString('ALLOW_DEVS', 'Allowed devices:');
    IDS_ALLOW_DEV_REM:=LangFile.GetString('ALLOW_DEV_REM', 'Remove');
    IDS_ENTER_DEV_ID:=LangFile.GetString('ENTER_DEV_ID', 'Enter the device ID');
    IDS_BLOCK_REQUEST_NEW_DEVS:=LangFile.GetString('BLOCK_REQUEST_NEW_DEVS', 'Block requests for new devices');
    IDS_PLACES:=LangFile.GetString('PLACES', 'Places');
    IDS_IMPORT:=LangFile.GetString('IMPORT', 'Import');
    IDS_EXPORT:=LangFile.GetString('EXPORT', 'Export');
    IDS_CATEGORIES:=LangFile.GetString('CATEGORIES', 'Categories');
    IDS_CATEGORIES_AT_RUN:=LangFile.GetString('CATEGORIES_AT_RUN', 'Categories at startup');
    IDS_DONE:=LangFile.GetString('DONE', 'Done');
    IDS_OK:=LangFile.GetString('OK', 'OK');
    IDS_CANCEL:=LangFile.GetString('CANCEL', 'Cancel');
    if CategoriesList.Text = '' then
      CategoriesList.Text:=LangFile.GetString('USER_CATEGORIES', 'Places\nWork\nShopping\nFood\nLeisure\nTravel\nTemporary');
  finally
    LangFile.Free;
  end;
  DateTimeLbl.Caption:=PlaceDateTime(IntToStr(DateTimeToUnix(Now)));
  RadiusLbl.Caption:=IDS_RADIUS + ' 0 ' + IDS_DISTANCE_UNIT_SMALL;

  CategoriesList.Text:=Trim(StringReplace(CategoriesList.Text, '\n', #13#10, [rfReplaceAll]));
  CatsCB.Items.Text:=CategoriesList.Text;
  if CatsCB.Items.Count > 0 then
    CatsCB.ItemIndex:=0;

  DBFileName:='Places.db';
  for i:=1 to ParamCount do
    if (LowerCase(ParamStr(i)) = '-db') and (Trim(ParamStr(i + 1)) <> '') then begin
      DBFileName:=ParamStr(i + 1);
      break;
    end;

  SQLDB:=TSQLite3Database.Create;
  SQLDB.Open(DBFileName);
  SQLDB.Execute('CREATE TABLE IF NOT EXISTS Places (ID INTEGER, Name TEXT, Latitude REAL, Longitude REAL, Category VARCHAR(128), Radius REAL, DateTime INTEGER)'); // ID TIMESTAMP áûëî
  PlacesListIndex:=TStringList.Create;
  LoadPlaces;

  // Категории при запуске
  if CategoriesAtRun then
    FoldersBtn.Click;

  // Ограничение IP адресов для синхронизации
  AllowedIPs:=TStringList.Create;
  if FileExists(ExtractFilePath(ParamStr(0)) + AllowedIPsFile) then
    AllowedIPs.LoadFromFile(ExtractFilePath(ParamStr(0)) + AllowedIPsFile);

  // Авторизованные устройства
  AuthorizedDevices:=TStringList.Create;
  SQLTB:=SQLDB.Prepare('SELECT name FROM sqlite_master WHERE name <> "Places"');
  try
    while SQLTB.Step = SQLITE_ROW do
      AuthorizedDevices.Add(Copy(SQLTB.ColumnText(0), 9, Length(SQLTB.ColumnText(0)))); //Actions_ не берем
  finally
    SQLTB.Free;
  end;

  // Экспорт, импорт
  for i:=1 to ParamCount do begin
    if (LowerCase(ParamStr(i)) = '-export') and (Trim(ParamStr(i + 1)) <> '') then
      ExportPlaces(ParamStr(i + 1));

    if (LowerCase(ParamStr(i)) = '-import') and (Trim(ParamStr(i + 1)) <> '') then
      ImportPlaces(ParamStr(i + 1));
  end;
  // Width:=449;
  // Height:=340;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  ActionPanel.SetFocus;
end;

procedure TMain.IdHTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
const
  AuthorizationSuccessfulStatus = 'auth:ok';
  AuthorizationDeniedStatus = 'auth:denied';
  SuccessStatus = 'ok';
  ErrorStatus = 'error';
var
  i, j: integer; SQLTB: TSQLite3Statement;
  XMLDoc: IXMLDocument;
  XMLNode: IXMLNode;

  RequestDocument, RequestFileExt, AuthDeviceID, PostData: string;

  PostDataStream: TStringStream;
begin
  CoInitialize(nil);

  if (AllowAnyIPs = false) and (Pos(AContext.Binding.PeerIP, AllowedIPs.Text) = 0) then begin CoUninitialize; Exit; end;

  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Origin: *'); //Политика безопасности браузеров

  AuthDeviceID:='';
  for i:=0 to ARequestInfo.Params.Count - 1 do begin
    if AnsiLowerCase(ARequestInfo.Params.Names[i]) = 'id' then
      AuthDeviceID:=ARequestInfo.Params.ValueFromIndex[i];
  end;

  // Авторизация
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/auth') then begin

    if Pos(AuthDeviceID, AuthorizedDevices.Text) = 0 then begin

      // Если блокировка новых устройств отключена
      if BlockReqNewDevs = false then begin
        case MessageBox(Handle, PChar(Format(IDS_DEV_SYNC_CONFIRM, [AuthDeviceID])), PChar(Caption), 35) of
          6: if Pos(AuthDeviceID, AuthorizedDevices.Text) = 0 then begin
                AuthorizedDevices.Add(AuthDeviceID);
                AResponseInfo.ContentText:=AuthorizationSuccessfulStatus;

                SQLDB.Execute('CREATE TABLE IF NOT EXISTS Actions_' + AuthDeviceID + ' (Action TEXT, ID INTEGER, Name TEXT, Latitude REAL, Longitude REAL, Category VARCHAR(128), Radius REAL, DateTime INTEGER)');

            end;
          7: AResponseInfo.ContentText:=AuthorizationDeniedStatus;
        end;

      // Если блокировка новых устройств включена
      end else
        AResponseInfo.ContentText:=AuthorizationDeniedStatus;


    end else // Успешная авторизация
      AResponseInfo.ContentText:=AuthorizationSuccessfulStatus;

    RequestDocument:='none';
  end;

  // Новые действия
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/actions') then begin

    if Pos(AuthDeviceID + #13#10, AuthorizedDevices.Text) > 0 then begin
      SQLTB:=SQLDB.Prepare('SELECT * FROM Actions_' + AuthDeviceID);
      try
        AResponseInfo.ContentText:='<actions>' + #13#10;
        while SQLTB.Step = SQLITE_ROW do begin
          if SQLTB.ColumnText(0) = 'INSERT' then
            AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<insert id="' + SQLTB.ColumnText(1) + '" lat="' + SQLTB.ColumnText(3) + '" lng="' + SQLTB.ColumnText(4) + '" cat="' + SQLTB.ColumnText(5) + '" radius="' + SQLTB.ColumnText(6) + '" datetime="' + SQLTB.ColumnText(7) + '">' + SQLTB.ColumnText(2) + '</insert>' + #13#10;

          if SQLTB.ColumnText(0) = 'UPDATE' then
            AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<update id="' + SQLTB.ColumnText(1) + '" lat="' + SQLTB.ColumnText(3) + '" lng="' + SQLTB.ColumnText(4) + '" cat="' + SQLTB.ColumnText(5) + '" radius="' + SQLTB.ColumnText(6) + '" datetime="' + SQLTB.ColumnText(7) + '">' + SQLTB.ColumnText(2) + '</update>' + #13#10;

          if SQLTB.ColumnText(0) = 'DELETE' then
              AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<delete id="' + SQLTB.ColumnText(1) + '"></delete>' + #13#10;
        end;
      finally
        AResponseInfo.ContentText:=AResponseInfo.ContentText + '</actions>';
        SQLTB.Free;
      end;

    end else
      AResponseInfo.ContentText:=AuthorizationDeniedStatus;

    RequestDocument:='none';
  end;

  // Удаление полученных действий
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/received') then begin
    if Pos(AuthDeviceID + #13#10, AuthorizedDevices.Text) > 0 then begin
      SQLDB.Execute('DELETE FROM Actions_' + AuthDeviceID);
      AResponseInfo.ContentText:=SuccessStatus;
    end else
      AResponseInfo.ContentText:=AuthorizationDeniedStatus;

    RequestDocument:='none';
  end;

  // Все места
  if (AuthDeviceID <> '') and (ARequestInfo.Document = '/api/places') then begin

    if Pos(AuthDeviceID + #13#10, AuthorizedDevices.Text) > 0 then begin
      SQLTB:=SQLDB.Prepare('SELECT * FROM Places ORDER BY DateTime DESC');
      try
        AResponseInfo.ContentText:='<places>' + #13#10;
        while SQLTB.Step = SQLITE_ROW do
          AResponseInfo.ContentText:=AResponseInfo.ContentText + #9 + '<place id="' + SQLTB.ColumnText(0) + '" lat="' + SQLTB.ColumnText(2) + '" lng="' + SQLTB.ColumnText(3) + '" cat="' + SQLTB.ColumnText(4) + '" radius="' + SQLTB.ColumnText(5) + '" datetime="' + SQLTB.ColumnText(6) + '">' + SQLTB.ColumnText(1) + '</place>' + #13#10;
      finally
        AResponseInfo.ContentText:=AResponseInfo.ContentText + '</places>';
        SQLTB.Free;
      end;
    end else
      AResponseInfo.ContentText:=AuthorizationDeniedStatus;

    RequestDocument:='none';
  end;

  // Проверка соединения
  if ARequestInfo.Document = '/api/connecttest' then begin
    AResponseInfo.ContentText:=SuccessStatus;
    RequestDocument:='none';
  end;

  if (AuthDeviceID <> '') and (Pos(AuthDeviceID, AuthorizedDevices.Text) > 0) and (ARequestInfo.Document = '/api/syncplaces') and (ARequestInfo.CommandType = hcPOST) then begin

    Caption:=AppName + ' - ' + 'ID_SYNC';
    Application.Title:=Caption;
    XMLDoc:=TXMLDocument.Create(nil);

    PostData:='';
    PostDataStream:=TStringStream.Create('', TEncoding.UTF8);
    try
      if ARequestInfo.PostStream <> nil then begin
        // Перемещаем данные из PostStream в строку
        ARequestInfo.PostStream.Position:=0;
        PostDataStream.LoadFromStream(ARequestInfo.PostStream);
        PostData:=PostDataStream.DataString;
      end;
    finally
      PostDataStream.Free;
    end;

    try
      XMLDoc:=LoadXMLData(PostData);
      XMLDoc.Active:=true;
      AResponseInfo.ContentText:=SuccessStatus;
    except
      AResponseInfo.ContentText := ErrorStatus;
    end;

    XMLNode:=XMLDoc.DocumentElement;

    for i:=0 to XMLNode.ChildNodes.Count - 1 do begin   // Не дописано, нужно добавление в базы устройств других, кроме отправляющей стороны!
      try
        if (XMLNode.ChildNodes[i].NodeName = 'insert') and (Trim( XMLNode.ChildNodes[i].NodeValue ) <> '') then begin
          SQLDB.Execute('INSERT INTO Places (ID, Name, Latitude, Longitude, Category, Radius, DateTime) values("' + XMLNode.ChildNodes[i].Attributes['id'] + '", "' + XMLNode.ChildNodes[i].NodeValue + '", "' + XMLNode.ChildNodes[i].Attributes['lat'] + '", "' + XMLNode.ChildNodes[i].Attributes['lng'] + '", "' + XMLNode.ChildNodes[i].Attributes['cat'] + '", ' + XMLNode.ChildNodes[i].Attributes['radius'] + ', ' + XMLNode.ChildNodes[i].Attributes['datetime'] + ')');

          // Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
          for j:=0 to AuthorizedDevices.Count - 1 do
            if (AuthorizedDevices.Strings[j] <> AuthDeviceID) and (SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j])) then // Исключаем устройств отправляющее действие
              SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID, Name, Latitude, Longitude, Category, Radius, DateTime) values("INSERT", ' + XMLNode.ChildNodes[i].Attributes['id'] + ', "' + XMLNode.ChildNodes[i].NodeValue + '", "' + XMLNode.ChildNodes[i].Attributes['lat'] + '", "' + XMLNode.ChildNodes[i].Attributes['lng'] + '", "' + XMLNode.ChildNodes[i].Attributes['cat'] + '", ' + XMLNode.ChildNodes[i].Attributes['radius'] + ', ' + XMLNode.ChildNodes[i].Attributes['datetime'] + ')');

        end else if XMLNode.ChildNodes[i].NodeName = 'update' then begin
          SQLDB.Execute('UPDATE Places SET Name="' + XMLNode.ChildNodes[i].NodeValue + '", Latitude=' + XMLNode.ChildNodes[i].Attributes['lat'] + ', Longitude=' + XMLNode.ChildNodes[i].Attributes['lng'] + ', Category="' + XMLNode.ChildNodes[i].Attributes['cat'] + '", Radius=' + XMLNode.ChildNodes[i].Attributes['radius'] + ', DateTime=' + XMLNode.ChildNodes[i].Attributes['datetime'] + ' WHERE ID=' + XMLNode.ChildNodes[i].Attributes['id']);

          // Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
          for j:=0 to AuthorizedDevices.Count - 1 do
            if (AuthorizedDevices.Strings[j] <> AuthDeviceID) and (SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j])) then // Исключаем устройств отправляющее действие
              SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID, Name, Latitude, Longitude, Category, Radius, DateTime) values("UPDATE", ' + XMLNode.ChildNodes[i].Attributes['id'] + ', "' + XMLNode.ChildNodes[i].NodeValue + '", "' + XMLNode.ChildNodes[i].Attributes['lat'] + '", "' + XMLNode.ChildNodes[i].Attributes['lng'] + '", "' + XMLNode.ChildNodes[i].Attributes['cat'] + '", ' + XMLNode.ChildNodes[i].Attributes['radius'] + ', ' + XMLNode.ChildNodes[i].Attributes['datetime'] + ')');

        end else if XMLNode.ChildNodes[i].NodeName = 'delete' then begin
          SQLDB.Execute('DELETE FROM Places WHERE id=' + XMLNode.ChildNodes[i].Attributes['id']);

          // Добавляем действие во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
          for j:=0 to AuthorizedDevices.Count - 1 do
            if (AuthorizedDevices.Strings[j] <> AuthDeviceID) and (SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j])) then // Исключаем устройств отправляющее действие
              SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID) values("DELETE", ' + XMLNode.ChildNodes[i].Attributes['id'] + ')');

        end;
      except
      end;
    end;

    LoadPlaces;
    AddBtn.Click; // Сбрасываем (могут быть старые данные)

    Caption:=AppName;
    Application.Title:=Caption;
    XMLDoc.Active:=false;
    RequestDocument:='none';
  end;

  if (RequestDocument <> 'none') then begin
    RequestDocument:=ExtractFilePath(ParamStr(0)) + '\webapp' + StringReplace(ARequestInfo.Document, '/', '\', [rfReplaceAll]);
    RequestDocument:=StringReplace(RequestDocument, '\\', '\', [rfReplaceAll]);
    if ARequestInfo.Document = '/webapp' then // по webapp отдаем главный файл
      RequestDocument:=ExtractFilePath(ParamStr(0)) + 'webapp\index.html';

    if FileExists(RequestDocument) then begin
      RequestFileExt:=AnsiLowerCase(ExtractFileExt(ARequestInfo.Document));

      if (RequestFileExt = '.html') or (RequestFileExt = '') then
        AResponseInfo.ContentType := 'text/html'
      else if RequestFileExt = '.js' then
        AResponseInfo.ContentType := 'application/javascript'
      else if RequestFileExt = '.css' then
        AResponseInfo.ContentType := 'text/css'
      else if RequestFileExt = '.png' then
        AResponseInfo.ContentType := 'image/png'
      else if RequestFileExt = '.txt' then
        AResponseInfo.ContentType := 'text/plain'
      else if ARequestInfo.Document = '/app.manifest' then // Устаревший метод, однако кто-то все еще может использовать устройства на iOS 12
        AResponseInfo.ContentType:='text/cache-manifest'
      else
        AResponseInfo.ContentType := 'application/octet-stream';

     AResponseInfo.ContentType:=AResponseInfo.ContentType + '; charset=utf-8';

      // AResponseInfo.ContentType:=IdHTTPServer.MIMETable.GetDefaultFileExt(RequestDocument); какие-то проблемы с ним

      //Memo1.Lines.Add(AResponseInfo.ContentType + ' ' + RequestFileExt + ' ' + RequestDocument);
      try
        AResponseInfo.ContentStream:=TFileStream.Create(RequestDocument, fmOpenRead or fmShareDenyWrite);
      except
      end;
    end else
      AResponseInfo.ContentText:=ErrorStatus;
  end;

  CoUninitialize;
end;

procedure TMain.ImportPlaces(FileName: string);
var
  Places, ImportPlace: TStringList;
  i, j: integer;
begin
  if not FileExists(FileName) then Exit;
  Places:=TStringList.Create;
  Places.LoadFromFile(FileName, TEncoding.UTF8);
  ImportPlace:=TStringList.Create;

  for i:=Places.Count - 1 downto 0 do begin
    ImportPlace.Text:=Places.Strings[i];

    if (Trim(ImportPlace.Text) = '') or (Pos(#9, ImportPlace.Text) = 0) then Continue;

    ImportPlace.Text:=StringReplace(ImportPlace.Text, #9, #13#10, [rfReplaceAll]);

    if ImportPlace.Count < 7 then Continue;

    //ShowMessage(IntToStr(ImportPlace.Count));
    //ShowMessage(ImportPlace.Text);

    SQLDB.Execute('INSERT INTO Places (ID, Name, Latitude, Longitude, Category, Radius, DateTime) values(' + ImportPlace[1] + ', "' + StrToCharCodes(ImportPlace[2]) + '", ' + ImportPlace[3] + ', ' + ImportPlace[4] + ', "' + StrToCharCodes(ImportPlace[5]) + '", ' + ImportPlace[6] + ', ' +  ImportPlace[1] + ')');

    // Добавляем действия во все таблицы авторизованных устройств. Проверка доступности нужна для использования иных баз данных
    for j:=0 to AuthorizedDevices.Count - 1 do
      if SQLDBTableExists('Actions_' + AuthorizedDevices.Strings[j]) then
        SQLDB.Execute('INSERT INTO Actions_' + AuthorizedDevices.Strings[j] + ' (Action, ID, Name, Latitude, Longitude, Category, Radius, DateTime) values("INSERT", ' + ImportPlace[1] + ', "' + StrToCharCodes(ImportPlace[2]) + '", "' + ImportPlace[3] + '", "' + ImportPlace[4] + '", "' + StrToCharCodes(ImportPlace[5]) + '", ' + ImportPlace[6] + ', ' + ImportPlace[1] + ')');

  end;

  ImportPlace.Free;
  Places.Free;
end;

procedure TMain.ExportPlaces(FileName: string);
var
  i: integer; SQLTB: TSQLite3Statement; Places: TStringList;
begin
  Places:=TStringList.Create;
  SQLTB:=SQLDB.Prepare('SELECT * FROM Places ORDER BY DateTime DESC');
  try
    while SQLTB.Step = SQLITE_ROW do
      Places.Text:=Places.Text + DateTimeToStr(UNIXToDateTime(StrToInt64(SQLTB.ColumnText(6)))) + #9 + SQLTB.ColumnText(6) + #9 + CharCodesToStr(SQLTB.ColumnText(1)) + #9 + SQLTB.ColumnText(2) + #9 + SQLTB.ColumnText(3) + #9 + CharCodesToStr(SQLTB.ColumnText(4)) + #9 + SQLTB.ColumnText(5) + #13#10;
  finally
    SQLTB.Free;
  end;
  Places.SaveToFile(FileName, TEncoding.UTF8);
  Places.Free;
end;

end.
