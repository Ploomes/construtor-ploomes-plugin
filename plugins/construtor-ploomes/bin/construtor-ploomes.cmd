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
echo construtor-ploomes: no Node 20.19+/22.12+ found; downloading %file% to %cache% 1>&2
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $u='https://nodejs.org/dist/%NODE_VERSION%/%file%'; $t=Join-Path $env:TEMP '%file%'; Invoke-WebRequest -Uri $u -OutFile $t; if ((Get-FileHash $t -Algorithm SHA256).Hash -ne '%SUM_WIN_X64%') { Remove-Item $t; throw 'the download sha256 does not match' }; New-Item -ItemType Directory -Force -Path '%cache%' | Out-Null; Expand-Archive -Path $t -DestinationPath '%cache%' -Force; Remove-Item $t" 1>&2
if errorlevel 1 exit /b 1
set "node=%cache%\node-%NODE_VERSION%-win-x64\node.exe"
exit /b 0
