@echo off

set JENKINS_DIR=%APPDATA%\Jenkins
if not exist %JENKINS_DIR% (
    mkdir %JENKINS_DIR%
)

set WORKSPACE=%JENKINS_DIR%\%JOB_BASE_NAME%
set CACHE=%JENKINS_DIR%\Cache

echo "CLEAN: %CLEAN%"
if "%CLEAN%" == "true" (
    rmdir /S /Q %WORKSPACE%
)

if not exist %WORKSPACE% (
    mkdir %WORKSPACE%
)

if not exist %CACHE% (
    mkdir %CACHE%
)

FOR /F "tokens=*" %%g IN ('python windows_sdk.py path') do (SET WINDOWS_SDK_PATH=%%g)
echo "WINDOWS SDK PATH: %WINDOWS_SDK_PATH%"

FOR /F "tokens=*" %%g IN ('python windows_sdk.py version') do (SET WINDOWS_SDK_VERSION=%%g)
echo "WINDOWS SDK VERSION: %WINDOWS_SDK_VERSION%"

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
