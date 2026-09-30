@echo off
:: Get current time and date stamp for log file -- also puts the log file in a folder in the same directory as the script
echo Checking network connectivity...
for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set "timestamp=%%A"
set "log_file=PrintLog_%timestamp%.txt"
set "log_folder=%~dp0PingPrintLog"
set "log_file=%log_folder%\PrintLog_%timestamp%.txt"
if not exist "%log_folder%" mkdir "%log_folder%"

echo Network Connectivity Test > "%log_file%"
echo ========================= >> "%log_file%"
echo. >> "%log_file%"

:: Ping Gateway
echo Pinging Gateway... >> %log_file%
ping 192.168.1.1 >> %log_file%

:: Ping DNS Server
echo Pinging DNS Server... >> %log_file%
ping 8.8.8.8 >> %log_file%

:: Ping Google
echo Pinging Google... >> %log_file%
ping www.google.com >> %log_file%

echo Network check completed. Log saved to %log_file%.
pause
