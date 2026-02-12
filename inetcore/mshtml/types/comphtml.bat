@echo off
rem Need the next line to clear build.exe status
echo Build_Status Checking for update to %2

diff %1 %2 >nul
if errorlevel 1 goto update

:same
rem Мы убрали проверку переменной MSHTML_PUBLISH_GENERATED_FILES,
rem чтобы скрипт не застревал на чтении атрибутов.
dir /a:r %2 >nul 2>&1
if errorlevel 1 goto readwrite
goto out

:readwrite
echo comphtml.bat(1) : warning W1001: %2% is read/write.
goto out

:update
rem Скрипт теперь всегда обновляет published файлы из сгенерированных
copy %1 %2 >nul
if errorlevel 1 goto cantcopy
echo comphtml.bat(1) : warning W1000: Updated %2% - Automatically synced
shift
shift
if not "%1" == "" goto update
goto out

:cantcopy
echo comphtml.bat(1) : error E9999: Need to update %2% - Please check file permissions

:out
echo %errorlevel%