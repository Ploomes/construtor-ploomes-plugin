@echo off
setlocal
set "here=%~dp0"
set "server=%here%..\dist\server.mjs"
set "NODE_VERSION=v22.23.3"
set "SUM_WIN_X64=2b0ff57b049cda1bbcea2240eec20467018713c1efe1f7360c2681859b90ed71"
set "cache=%LOCALAPPDATA%\construtor-ploomes\node"
set "node="

if defined CONSTRUTOR_PLOOMES_NODE call :serves "%CONSTRUTOR_PLOOMES_NODE%" && set "node=%CONSTRUTOR_PLOOMES_NODE%"
if not defined node for /f "delims=" %%n in ('where node 2^>nul') do if not defined node call :serves "%%n" && set "node=%%n"
if not defined node for %%c in ("%ProgramFiles%\nodejs\node.exe" "%LOCALAPPDATA%\Programs\nodejs\node.exe" "%ProgramFiles(x86)%\nodejs\node.exe") do if not defined node call :serves %%c && set "node=%%~c"
if not defined node for /d %%d in ("%APPDATA%\nvm\v22*" "%APPDATA%\nvm\v20*" "%LOCALAPPDATA%\Volta\tools\image\node\2*" "%cache%\node-*") do if not defined node call :serves "%%d\node.exe" && set "node=%%d\node.exe"
if not defined node call :download || exit /b 1
"%node%" "%server%" %*
exit /b %errorlevel%

:serves
if not exist %1 exit /b 1
%1 -e "const [a,b]=process.versions.node.split('.').map(Number); process.exit((a===20&&b>=19)||(a===22&&b>=12)||a>22 ? 0 : 1)" >nul 2>&1
exit /b %errorlevel%

:download
rem stdout is the MCP channel: every message goes to stderr.
set "file=node-%NODE_VERSION%-win-x64.zip"
set "logdir=%CONSTRUTOR_PLOOMES_STATE_DIR%"
if not defined logdir set "logdir=%CONSTRUTOR_PLOOMES_DATA%"
if not defined logdir set "logdir=%CLAUDE_PLUGIN_DATA%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue'; function Say($m) { [Console]::Error.WriteLine('construtor-ploomes: ' + $m); if ($env:logdir) { try { New-Item -ItemType Directory -Force -Path $env:logdir | Out-Null; Add-Content -Path (Join-Path $env:logdir 'construtor-ploomes.log') -Value ((Get-Date).ToUniversalTime().ToString('s') + 'Z ' + $PID + ' [launcher] ' + $m) } catch {} } }; Say 'no Node 20.19+/22.12+ found; downloading %file% to %cache%'; $u='https://nodejs.org/dist/%NODE_VERSION%/%file%'; $t=Join-Path $env:TEMP '%file%'; try { Invoke-WebRequest -Uri $u -OutFile $t } catch { Remove-Item $t -ErrorAction SilentlyContinue; Say 'could not download Node from nodejs.org; check the internet connection, or install Node 22, and try again'; exit 1 }; if ((Get-FileHash $t -Algorithm SHA256).Hash -ne '%SUM_WIN_X64%') { Remove-Item $t; Say 'the download sha256 does not match; nothing was installed'; exit 1 }; New-Item -ItemType Directory -Force -Path '%cache%' | Out-Null; Expand-Archive -Path $t -DestinationPath '%cache%' -Force; Remove-Item $t" 1>&2
if errorlevel 1 exit /b 1
set "node=%cache%\node-%NODE_VERSION%-win-x64\node.exe"
exit /b 0
