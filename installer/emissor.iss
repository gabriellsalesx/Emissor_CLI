; Instalador do Emissor para Windows (Inno Setup 6).
; A versão é passada pela linha de comando: ISCC /DMyAppVersion=1.2.3 installer\emissor.iss
; O binário emissor-cli.exe deve estar nesta mesma pasta (installer/) no momento do build.

#ifndef MyAppVersion
  #define MyAppVersion "0.0.0"
#endif

#define MyAppName "Emissor"
#define MyAppExeName "emissor-cli.exe"
#define MyAppPublisher "Gabriell Sales"
#define MyAppURL "https://github.com/gabriellsalesx/Emissor_CLI"

[Setup]
AppId={{7B3F1E64-2A4C-4E2E-9E7A-6D5C4B3A2F10}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}/releases
DefaultDirName={localappdata}\Programs\Emissor
DisableProgramGroupPage=yes
DefaultGroupName=Emissor
PrivilegesRequired=lowest
OutputDir=..\dist
OutputBaseFilename=Emissor-Setup-{#MyAppVersion}
SetupIconFile=emissor.ico
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ChangesEnvironment=yes

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "Criar um atalho na Área de Trabalho"; GroupDescription: "Atalhos:"
Name: "addtopath"; Description: "Adicionar o Emissor ao PATH (para usar no terminal também)"; GroupDescription: "Opções avançadas:"; Flags: unchecked

[Files]
Source: "emissor-cli.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Emissor"; Filename: "{app}\{#MyAppExeName}"; Comment: "Gerar contratos, orçamentos e recibos"
Name: "{group}\Desinstalar o Emissor"; Filename: "{uninstallexe}"
Name: "{userdesktop}\Emissor"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Comment: "Gerar contratos, orçamentos e recibos"

[Registry]
Root: HKCU; Subkey: "Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}"; Tasks: addtopath; Check: NeedsAddPath('{app}')

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Abrir o Emissor agora"; Flags: nowait postinstall skipifsilent

[Code]
function NeedsAddPath(Param: string): Boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKCU, 'Environment', 'Path', OrigPath) then
  begin
    Result := True;
    exit;
  end;
  Result := Pos(';' + ExpandConstant(Param) + ';', ';' + OrigPath + ';') = 0;
end;
