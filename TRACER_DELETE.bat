@Echo off
:: BatchGotAdmin
:-------------------------------------
REM --> Check for permissions
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params= %*
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------
taskkill /IM Agent.exe /F
taskkill /IM Battle.net.exe /F
del "D:\GAMES\Call of Duty Modern Warfare\main\data0.dcache"
del "D:\GAMES\Call of Duty Modern Warfare\main\data1.dcache"
del "D:\GAMES\Call of Duty Modern Warfare\main\toc0.dcache"
del "D:\GAMES\Call of Duty Modern Warfare\main\toc1.dcache"
del "D:\GAMES\Call of Duty Modern Warfare\Data\data\shmem"
del "D:\GAMES\Call of Duty Modern Warfare\main\recipes\cmr_hist"
del /f ".\Data\data\shmem"
del /f ".\main\recipes\cmr_hist"
rmdir ".\main\recipes\cmr_hist" /s /q
rmdir "%userprofile%\documents\Call of Duty Modern Warfare" /s /q
rmdir "%localappdata%\Battle.net" /s /q
rmdir "%localappdata%\Blizzard Entertainment" /s /q
rmdir "%appdata%\Battle.net" /s /q
rmdir "%programdata%\Battle.net" /s /q
rmdir "%programdata%\Blizzard Entertainment" /s /q
rmdir "%Documents%\Call Of Duty Modern Warfare" /s /q
reg delete "HKEY_CURRENT_USER\Software\Blizzard Entertainment" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Blizzard Entertainment" /f
reg delete "HKEY_CURRENT_USER\Software\Blizzard Entertainment\Battle.net\Identity" /f
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\InstallTime" /f
cls
echo . . . . . . . . . . . . . . . .
echo.
echo. You are now free to create your new account! ENJOY!
echo.
echo . . . . . . . . . . . . . . . .
echo.
pause
Exit