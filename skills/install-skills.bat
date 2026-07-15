@echo off
chcp 65001 >nul
setlocal

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-skills.ps1"
if errorlevel 1 (
  echo 安装失败。
  exit /b 1
)

echo 安装完成。
pause
endlocal
