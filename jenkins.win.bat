@echo off

set WORKSPACES=%APPDATA%\Build
if not exist %WORKSPACES% (
    mkdir %WORKSPACES%
)

set WORKSPACE=%WORKSPACES%\%JOB_BASE_NAME%

echo "CLEAN: %CLEAN%"
if "%CLEAN%" == "true" (
    rmdir /S /Q %WORKSPACE%
)

if not exist %WORKSPACE% (
    mkdir %WORKSPACE%
)

set CACHE=%APPDATA%\Cache
rem set CACHE=D:\Cache
if not exist %CACHE% (
    mkdir %CACHE%
)

set KONDA_ARGS=^
--cache-dir %CACHE% ^
--channel kitsune.one ^
--croot %WORKSPACE%\build ^
--dirty ^
--error-overlinking ^
--keep-old-work ^
--no-anaconda-upload ^
--no-build-id ^
--no-remove-work-dir ^
--output-folder %WORKSPACE%\output ^
conda\%JOB_BASE_NAME%

FOR /F "tokens=*" %%g IN ('conda build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)

echo "CONDA BUILD: %KONDA_PAK%"
call conda build %KONDA_ARGS%

echo "ANACONDA UPLOAD: %KONDA_PAK%"
anaconda ^
    --disable-ssl-warnings ^
    --show-traceback ^
    --verbose ^
    --token %ANACONDA_TOKEN% ^
    upload ^
    -u kitsune.one ^
    --no-progress ^
    --force ^
    %KONDA_PAK%
