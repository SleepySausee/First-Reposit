@echo off
setlocal

echo # This is a Network Connectivity Test script #
echo PLEASE SEE IPCONFIG INFORMATION AND DHCP INFO BELOW #FIRST# 
echo ## TO EXIT THE TEXT AT ANY TIME, PRESS CTRL + C ##
echo PRESS ANY KEY TO CONTINUE...
pause > nul

echo.
echo ==========================================
echo       Network Connectivity Test
echo ==========================================
echo.


:: Get IPCONFIG information and DCHP info
echo ==========================================
echo Gathering network configuration...
echo ==========================================
systeminfo
echo.
ipconfig /all
echo.
:: Check DHCP
echo ==========================================
echo DHCP Information - Will load in 3 seconds...
echo ==========================================
echo.
:: DHCP information for all ACTIVE network adapters
powershell -NoProfile -Command "Get-NetIPConfiguration | Where-Object {$_.NetAdapter.Status -eq 'Up' -and (Get-NetIPInterface -InterfaceIndex $_.InterfaceIndex -AddressFamily IPv4).Dhcp -eq 'Enabled'} | ForEach-Object { Write-Host ('Adapter: ' + $_.InterfaceAlias); Write-Host ('DHCP: Enabled'); Write-Host ('IPv4 Address: ' + $_.IPv4Address.IPAddress); Write-Host ('Gateway: ' + $_.IPv4DefaultGateway.NextHop); Write-Host '' }"
pause
:: PAUSED HERE TO VIEW INFORMATION

:: Ping Google -- Simple test to check if the internet is reachable
echo.
echo ==========================================
echo Pinging Google for benchmark test...
echo ==========================================
ping www.google.com
ping 8.8.8.8
echo.
echo ==========================================
echo Please check the results above.
echo.
echo Press any key to test pings for Gateway, DNS, and Intranet Website
echo OR
echo Press CTRL + C to exit the script
pause > nul


:: Request user input to continue
echo.
echo ## ENTER YOUR OWN GATEWAY IP ADDRESS BELOW OR ENTER N/A TO SKIP TEST
set /p "gateway=Enter Gateway IP you would like to test: "
echo ## ENTER YOUR OWN DNS SERVER IP ADDRESS BELOW OR ENTER N/A TO SKIP TEST
set /p "dns=Enter DNS Server IP you would like to test: "
echo ## ENTER YOUR OWN INTRANET WEBSITE BELOW OR ENTER N/A TO SKIP TEST
set /p "intraWebsite=Enter intranet website you would like to test: "

:: Ping Gateway
if not "%gateway%"=="" if /I not "%gateway%"=="N/A" (
    echo.
    echo ==========================================
    echo Pinging Gateway...
    echo ==========================================
    ping "%gateway%"
)

:: Ping DNS Server
if not "%dns%"=="" if /I not "%dns%"=="N/A" (
    echo.
    echo ==========================================
    echo Pinging DNS Server...
    echo ==========================================
    ping "%dns%"
)

:: Ping Intranet Website
if not "%intraWebsite%"=="" if /I not "%intraWebsite%"=="N/A" (
    echo.
    echo ==========================================
    echo Pinging Intranet Website...
    echo ==========================================
    ping "%intraWebsite%"
)

:: ==========================================
:: Additional Diagnostics
:: ==========================================

echo.
echo ==========================================
echo       Additional Diagnostics
echo ==========================================
echo.
set /p "additional=Run additional diagnostics? (Y/N): "


if /I "%additional%"=="N" goto END
if /I not "%additional%"=="Y" goto END

:DIAGNOSTICS

echo.
echo ==========================================
echo       Additional Diagnostics
echo ==========================================
echo.
echo 1. NSLookup
echo 2. Tracert
echo 3. PathPing
echo 4. EXIT to END
echo.
set /p "diag=Select an option: "

if "%diag%"=="1" goto DIAG_NSLOOKUP
if "%diag%"=="2" goto DIAG_TRACERT
if "%diag%"=="3" goto DIAG_PATHPING
if "%diag%"=="4" goto END

echo.
echo Invalid selection.
pause
goto DIAGNOSTICS


:DIAG_NSLOOKUP
cls

echo.
echo ==========================================
echo             NSLookup Test
echo ==========================================
echo.

set /p "target=Enter hostname or IP address: "

echo.
echo Running NSLookup for %target%...
echo.

nslookup %target%

echo.
echo ==========================================
echo NSLookup completed.
echo ==========================================
echo.

pause
goto DIAGNOSTICS


:DIAG_TRACERT
cls

echo.
echo ==========================================
echo             Tracert Test
echo ==========================================
echo.

set /p "target=Enter IP address or hostname: "

echo.
echo Running Tracert to %target%...
echo.

tracert %target%

echo.
echo ==========================================
echo Tracert completed.
echo ==========================================
echo.

pause
goto DIAGNOSTICS


:DIAG_PATHPING
cls

echo.
echo ==========================================
echo            PathPing Test
echo ==========================================
echo.

set /p "target=Enter IP address or hostname: "

echo.
echo Running PathPing to %target%...
echo.
echo This may take several minutes.
echo.

pathping %target%

echo.
echo ==========================================
echo PathPing completed.
echo ==========================================
echo.

pause
goto DIAGNOSTICS
endlocal
exit

:END

echo.
echo ==========================================
echo Network check completed.
echo ==========================================
echo.
echo Press any key TWICE to exit...
pause > nul
pause > nul

endlocal
exit
