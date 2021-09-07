@echo off
rem set VSCMD_DEBUG=2
set PATH=%PATH%;^
D:\7-Zip;^
D:\Git\bin;^
D:\Miniconda3;^
D:\Miniconda3\Scripts;^
D:\NuGet;^
D:\Svn\bin

set JENKINS_DIR=%APPDATA%\Jenkins
if not exist %JENKINS_DIR% (
    mkdir %JENKINS_DIR%
)

set JOB_DIR=%JENKINS_DIR%\%JOB_BASE_NAME%
set CACHE_DIR=%JENKINS_DIR%\cache

echo "CLEAN: %CLEAN%"
if "%CLEAN%" == "true" (
    rmdir /S /Q %JOB_DIR%
)

if not exist %JOB_DIR% (
    mkdir %JOB_DIR%
)

if not exist %CACHE_DIR% (
    mkdir %CACHE_DIR%
)

rem FOR /F "tokens=*" %%g IN ('python windows_sdk.py path') do (SET WINDOWS_SDK_PATH=%%g)
rem echo "WINDOWS SDK PATH: %WINDOWS_SDK_PATH%"

rem FOR /F "tokens=*" %%g IN ('python windows_sdk.py version') do (SET WINDOWS_SDK_VERSION=%%g)
rem echo "WINDOWS SDK VERSION: %WINDOWS_SDK_VERSION%"

set VSBT_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat"
rem set VSBT_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"

set KONDA_ARGS=^
--cache-dir %CACHE_DIR% ^
--channel kitsune.one ^
--croot %JOB_DIR%\build ^
--dirty ^
--error-overlinking ^
--keep-old-work ^
--no-anaconda-upload ^
--no-build-id ^
--no-remove-work-dir ^
--output-folder %JOB_DIR%\output ^
conda\%JOB_BASE_NAME%
FOR /F "tokens=*" %%g IN ('conda-build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)

echo "CONDA BUILD: %KONDA_PAK%"
conda-build %KONDA_ARGS%

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
