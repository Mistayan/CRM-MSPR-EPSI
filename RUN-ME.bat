@echo off

:: BatchGotAdmin
:: Thank you Eneerge @ https://sites.google.com/site/eneerge/scripts/batchgotadmin
:-------------------------------------
REM  --> Check for permissions
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
    if exist 'conf\KeyStore\jetty.p12' (
        echo "keystore OK"
    ) else (
        keytool -genkeypair -alias jetty -keyalg RSA -keysize 4096 -validity 365 -dname "CN=localhost" -keypass JettyOPPASS%% -keystore 'conf/KeyStore/jetty.p12' -storeType PKCS12  -storepass JettyOPPASS%%
    )
    NET START wampmysqld64
    set %SQL_VERSION%="8.0.27"
    C:\wamp64\bin\mysql\mysql%SQL_VERSION%\bin\mysql --host=localhost --port=3306 --user=acme --password=acme --database=acme < ./conf/sql/acme.sql
    CALL mvn install -U -f pom.xml
    java -jar target/acme-0.1.1.7.jar

pause
