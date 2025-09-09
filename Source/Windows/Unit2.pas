unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SQLite3, SQLite3Wrap,
  Vcl.Menus, IniFiles;

type
  TSettings = class(TForm)
    InterfaceGB: TGroupBox;
    DarkThemeStartHourLbl: TLabel;
    DarkThemeEndHourLbl: TLabel;
    DarkThemeCB: TCheckBox;
    ThemeTimeCB: TCheckBox;
    DarkThemeStartHourEdt: TEdit;
    DarkThemeEndHourEdt: TEdit;
    SyncGB: TGroupBox;
    PortLbl: TLabel;
    AllowedIPsLbl: TLabel;
    AllowedDevsLbl: TLabel;
    PortEdt: TEdit;
    AllowedIPsMemo: TMemo;
    AllowAnyIPsCB: TCheckBox;
    AllowedDevsLB: TListBox;
    AddManualDev: TButton;
    BlockReqNewDevsCB: TCheckBox;
    RemManualDev: TButton;
    OkBtn: TButton;
    CancelBtn: TButton;
    AboutBtn: TButton;
    PlacesGB: TGroupBox;
    ImportBtn: TButton;
    ExportBtn: TButton;
    CategoriesGB: TGroupBox;
    CategoriesMemo: TMemo;
    AllowedDevsPM: TPopupMenu;
    AllowedDevRemBtn: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    CategoriesAtRunCB: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure RemManualDevClick(Sender: TObject);
    procedure AddManualDevClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure AllowedDevsLBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure ExportBtnClick(Sender: TObject);
    procedure ImportBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure DarkThemeCBClick(Sender: TObject);
    procedure ThemeTimeCBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Settings: TSettings;

implementation

{$R *.dfm}

uses Unit1;

procedure TSettings.AboutBtnClick(Sender: TObject);
begin
  Application.MessageBox(PChar(Main.Caption + ' 1.0' + #13#10 +
    IDS_LAST_UPDATE + ' 10.09.25' + #13#10 +
    'https://r57zone.github.io' + #13#10 +
    'r57zone@gmail.com'), PChar(Main.Caption), MB_ICONINFORMATION);
end;

procedure TSettings.AddManualDevClick(Sender: TObject);
var
  AllowDeviceName: string;
begin
  if InputQuery(Main.Caption, 'ID_ENTER_DEV_ID', AllowDeviceName) and (Trim(AllowDeviceName) <> '') then begin
    AllowedDevsLB.Items.Add(AllowDeviceName);
    AuthorizedDevices.Text:=AllowedDevsLB.Items.Text;

    if not Main.SQLDBTableExists('Actions_' + AllowDeviceName) then
      SQLDB.Execute('CREATE TABLE Actions_' + AllowDeviceName + ' (Action TEXT, ID TIMESTAMP, Name TEXT, Coordinates TEXT, Radius REAL)');
  end;
end;

procedure TSettings.AllowedDevsLBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i, ActionTablesCount: integer; SQLTB: TSQLite3Statement; TablesNames: string;
begin
  if (Key = VK_DELETE) or (Key = VK_DECIMAL) then
    AllowedDevRemBtn.Click;

  if (Key = VK_F7) then begin
    ActionTablesCount:=0;
    SQLTB:=SQLDB.Prepare('SELECT name FROM sqlite_master WHERE name <> "Places"');
    try
      while SQLTB.Step = SQLITE_ROW do begin
        TablesNames:=TablesNames + SQLTB.ColumnText(0) + #13#10;
        Inc(ActionTablesCount);
      end;
    finally
      SQLTB.Free;
    end;
    Application.MessageBox(PChar('Tables: ' + IntToStr(ActionTablesCount) + #13#10 + Trim(TablesNames)), PChar(Main.Caption), MB_ICONINFORMATION);
  end;
end;

procedure TSettings.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TSettings.DarkThemeCBClick(Sender: TObject);
begin
  if (DarkThemeCB.Checked) and (ThemeTimeCB.Checked) then
    ThemeTimeCB.Checked:=false;
end;

procedure TSettings.ExportBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    Main.ExportPlaces(SaveDialog.FileName);
    SaveDialog.InitialDir:=ExtractFilePath(SaveDialog.FileName);  // Поведение старых диалогов
    SaveDialog.FileName:=ExtractFileName(SaveDialog.FileName);
    Application.MessageBox(PChar(IDS_DONE), PChar(Main.Caption), MB_ICONINFORMATION);
  end;
end;

procedure TSettings.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
  SetWindowLong(PortEdt.Handle, GWL_STYLE, GetWindowLong(PortEdt.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(DarkThemeStartHourEdt.Handle, GWL_STYLE, GetWindowLong(DarkThemeStartHourEdt.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(DarkThemeEndHourEdt.Handle, GWL_STYLE, GetWindowLong(DarkThemeEndHourEdt.Handle, GWL_STYLE) or ES_NUMBER);

  Caption:=IDS_SETTINGS;
  InterfaceGB.Caption:=IDS_INTERFACE;
  DarkThemeCB.Caption:=IDS_DARK_THEME;
  ThemeTimeCB.Caption:=IDS_THEME_TIME;
  DarkThemeStartHourLbl.Caption:=IDS_DARK_THEME_START;
  DarkThemeEndHourLbl.Caption:=IDS_DARK_THEME_END;
  SyncGB.Caption:=IDS_SYNCHRONIZATION;
  PortLbl.Caption:=IDS_SYNC_PORT;
  AllowAnyIPsCB.Caption:=IDS_SYNC_WITH_ANY_IPS;
  AllowedIPSLbl.Caption:=IDS_ALLOW_IPS;
  AllowedDevsLbl.Caption:=IDS_ALLOW_DEVS;
  AllowedDevRemBtn.Caption:=IDS_ALLOW_DEV_REM;
  BlockReqNewDevsCB.Caption:=IDS_BLOCK_REQUEST_NEW_DEVS;
  CategoriesGB.Caption:=IDS_CATEGORIES;
  CategoriesMemo.Text:=Trim(CategoriesList.Text);
  CategoriesAtRunCB.Caption:=IDS_CATEGORIES_AT_RUN;
  CategoriesAtRunCB.Checked:=Main.CategoriesAtRun;

  PlacesGB.Caption:=IDS_PLACES;
  OpenDialog.Filter:=IDS_PLACES + ' (*.ptxt)|*.ptxt';
  SaveDialog.Filter:=OpenDialog.Filter;
  SaveDialog.DefaultExt:=SaveDialog.Filter;
  ImportBtn.Caption:=IDS_IMPORT;
  ExportBtn.Caption:=IDS_EXPORT;

  OkBtn.Caption:=IDS_OK;
  CancelBtn.Caption:=IDS_CANCEL;

  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  PortEdt.Text:=IntToStr(Main.IdHTTPServer.DefaultPort);
  DarkThemeCB.Checked:=UseDarkTheme;
  ThemeTimeCB.Checked:=UseThemeTime;
  DarkThemeStartHourEdt.Text:=IntToStr(DarkThemeStartHour);
  DarkThemeEndHourEdt.Text:=IntToStr(DarkThemeEndHour);
  if AllowAnyIPs then begin
    AllowAnyIPsCB.Checked:=true;
    AllowedIPsMemo.Enabled:=false;
  end;
  BlockReqNewDevsCB.Checked:=BlockReqNewDevs;
  AllowedIPsMemo.Text:=Trim(AllowedIPs.Text);
  Ini.Free;

  // Пока нет тёмной темы
  CategoriesGB.Top:=8;
  PlacesGB.Top:=130;

  // Width 536
  // Height 425
end;

procedure TSettings.FormShow(Sender: TObject);
begin
  AllowedDevsLB.Items.Text:=AuthorizedDevices.Text;
end;

procedure TSettings.ImportBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    Main.ImportPlaces(OpenDialog.FileName);
    Main.LoadPlaces;
    Application.MessageBox(PChar(IDS_DONE), PChar(Main.Caption), MB_ICONINFORMATION);
  end;
end;

procedure TSettings.OkBtnClick(Sender: TObject);
var
  Ini: TIniFile; ParamsStr: string; i: integer;
begin
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  Ini.WriteInteger('Sync', 'Port', StrToIntDef(PortEdt.Text, 736));
  if ThemeTimeCB.Checked then
    DarkThemeCB.Checked:=false;
  //Ini.WriteBool('Main', 'DarkTheme', DarkThemeCB.Checked);
  //Ini.WriteBool('Main', 'ThemeTime', ThemeTimeCB.Checked);
  //Ini.WriteString('Main', 'DarkThemeStartHour', DarkThemeStartHourEdt.Text);
  //Ini.WriteString('Main', 'DarkThemeEndHour', DarkThemeEndHourEdt.Text);
  Ini.WriteBool('Sync', 'AllowAnyIPs', AllowAnyIPsCB.Checked);
  Ini.WriteBool('Sync', 'BlockRequestNewDevs', BlockReqNewDevsCB.Checked);
  AllowedIPsMemo.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + AllowedIPsFile); // В Ini ограничение на кол-во символов в строке
  CategoriesMemo.Text:=StringReplace(Trim(CategoriesMemo.Text), ' ', '_', [rfReplaceAll]);
  Ini.WriteString('Main', 'Categories', StringReplace(CategoriesMemo.Text, #13#10, '\n', [rfReplaceAll]));
  Main.CategoriesAtRun:=CategoriesAtRunCB.Checked;
  Ini.WriteBool('Main', 'CategoriesAtRun', CategoriesAtRunCB.Checked);
  Ini.Free;
  Main.IdHTTPServer.Active:=false;
  for i:=1 to ParamCount do
    if (LowerCase(ParamStr(i)) = '-db') and (Trim(ParamStr(i + 1)) <> '') then begin
      ParamsStr:=' -db ' + ParamStr(i + 1);
      break;
    end;

  WinExec(PAnsiChar(AnsiString(ParamStr(0) + ' -show' + ParamsStr)), SW_SHOW);
  Main.Close;
end;

procedure TSettings.RemManualDevClick(Sender: TObject);
begin
  if AllowedDevsLB.ItemIndex <> -1 then begin
    if Main.SQLDBTableExists('Actions_' + AllowedDevsLB.Items[AllowedDevsLB.ItemIndex]) then
      SQLDB.Execute('DROP TABLE Actions_' + AllowedDevsLB.Items[AllowedDevsLB.ItemIndex]);

    AllowedDevsLB.Items.Delete(AllowedDevsLB.ItemIndex);
    AuthorizedDevices.Text:=AllowedDevsLB.Items.Text;
  end;
end;

procedure TSettings.ThemeTimeCBClick(Sender: TObject);
begin
  if (ThemeTimeCB.Checked) and (DarkThemeCB.Checked) then
    DarkThemeCB.Checked:=false;
end;

end.
