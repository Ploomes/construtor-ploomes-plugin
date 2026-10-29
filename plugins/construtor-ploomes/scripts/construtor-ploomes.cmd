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
rem One start downloads under the lock; the others wait for it and reuse its Node instead of each downloading one.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue'; function Say($m) { [Console]::Error.WriteLine('construtor-ploomes: ' + $m); if ($env:logdir) { try { New-Item -ItemType Directory -Force -Path $env:logdir | Out-Null; Add-Content -Path (Join-Path $env:logdir 'construtor-ploomes.log') -Value ((Get-Date).ToUniversalTime().ToString('s') + 'Z ' + $PID + ' [launcher] ' + $m) } catch {} } }; $d=Join-Path '%cache%' 'node-%NODE_VERSION%-win-x64'; $x=$null; function Runs { try { & (Join-Path $d 'node.exe') --version | Out-Null; $LASTEXITCODE -eq 0 } catch { $false } }; New-Item -ItemType Directory -Force -Path '%cache%' | Out-Null; $l=$null; $until=(Get-Date).AddSeconds(120); while (-not $l) { try { $l=[IO.File]::Open((Join-Path '%cache%' '.instalando'), 'OpenOrCreate', 'ReadWrite', 'None') } catch { if ((Get-Date) -gt $until) { Say 'another start of Construtor Ploomes is still installing Node in %cache%; try again'; exit 1 }; Start-Sleep -Milliseconds 200 } }; try { if (Runs) { exit 0 }; Say 'no Node 20.19+/22.12+ found; downloading %file% to %cache%'; $u='https://nodejs.org/dist/%NODE_VERSION%/%file%'; $t=Join-Path $env:TEMP ([string]$PID + '-%file%'); $old=(Get-Date).AddMinutes(-15); try { Get-ChildItem '%cache%' -Directory -Force -Filter '.extraindo-*' -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt $old } | Remove-Item -Recurse -Force; Get-ChildItem $env:TEMP -File -Filter '*-%file%' | Where-Object { $_.LastWriteTime -lt $old } | Remove-Item -Force } catch {}; try { Invoke-WebRequest -Uri $u -OutFile $t } catch { Remove-Item $t -ErrorAction SilentlyContinue; Say 'could not download Node from nodejs.org; check the internet connection, or install Node 22, and try again'; exit 1 }; if ((Get-FileHash $t -Algorithm SHA256).Hash -ne '%SUM_WIN_X64%') { Remove-Item $t; Say 'the download sha256 does not match; nothing was installed'; exit 1 }; $x=Join-Path '%cache%' ('.extraindo-' + $PID); try { if (Test-Path $x) { Remove-Item $x -Recurse -Force }; New-Item -ItemType Directory -Force -Path $x | Out-Null; $tar=Join-Path $env:SystemRoot 'System32\tar.exe'; if (Test-Path $tar) { & $tar -xf $t -C $x; if ($LASTEXITCODE -ne 0) { throw 'tar' } } else { Add-Type -AssemblyName System.IO.Compression.FileSystem; [IO.Compression.ZipFile]::ExtractToDirectory($t, $x) }; & (Join-Path $x 'node-%NODE_VERSION%-win-x64\node.exe') --version | Out-Null; if ($LASTEXITCODE -ne 0) { throw 'node' } } catch { Remove-Item $t -ErrorAction SilentlyContinue; Say 'could not unpack %file%, or the Node in it does not run on this machine; install Node 22 and try again'; exit 1 }; Remove-Item $t; try { if (Test-Path $d) { Remove-Item $d -Recurse -Force }; Move-Item (Join-Path $x 'node-%NODE_VERSION%-win-x64') $d } catch { Say 'could not move the unpacked Node into %cache%; install Node 22 and try again'; exit 1 } } finally { $l.Close(); if ($x) { Remove-Item $x -Recurse -Force -ErrorAction SilentlyContinue } }" 1>&2
if errorlevel 1 exit /b 1
set "node=%cache%\node-%NODE_VERSION%-win-x64\node.exe"
exit /b 0
