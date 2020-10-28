@echo off

Rem --> -------------------------------------------------------------------------------------------------
Rem  --> Check for permissions
if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
    >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
)
else (
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)   

Rem --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) 
else (
    goto gotAdmin
)

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

Rem --> Opening installers folder
cd Installers

echo ====================================================================================================
echo ========================== Univerexport Back Office Softwate Installation ==========================
echo ====================================================================================================
echo -

echo Sotware installation started . . .
echo -

Rem --> Installing CCleaner

echo Installing CCleaner . . .
echo -
ccsetup.exe /S
echo CCleaner successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Java JRE

echo Installing Java 1.6 u43 x64 . . .
echo -
jre-6u43-windows-x64.exe INSTALLCFG=java.cfg /s
echo Java successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing 7zip x64

echo Installing 7zip x64 . . .
echo -
zip64.exe /S
echo 7zip successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Mozilla Firefox

echo Installing Mozilla Firefox x64 . . .
echo -
firefox64.exe /s
echo Mozilla Firefox successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Ultra VNC x64

echo Installing Ultra VNC x64 . . .
echo -
UltraVNC64_Setup.exe /silent /loadinf=ultravnc.inf
echo Ultra VNC x64 successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Rocket Chat

echo Installing Rocket Chat . . .
echo -
rocketchat-setup.exe /S /allusers
echo Rocket Chat successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Notepad++

echo Installing Notepad++ . . .
echo -
Notepad++.exe /S
echo Notepad++ successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Speccy

echo Installing Speccy . . .
echo -
SpeccySetup.exe /S
echo Speccy successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

Rem --> Installing Foxit Reader

echo Installing Foxit Reader . . .
echo -
FoxitReader.exe /S
echo Foxit Reader successfully installed
echo -

Rem --> -------------------------------------------------------------------------------------------------

echo Sotware installation finished . . .
echo -
echo ====================================================================================================

pause