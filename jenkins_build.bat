@echo off
set PATH=%PATH%;^
D:\7-Zip;^
D:\Git\bin;^
D:\Miniconda3\envs\builder;^
D:\Miniconda3\envs\builder\Library\bin;^
D:\Miniconda3\envs\builder\Scripts;^
D:\NuGet;^
D:\Svn\bin

set JENKINS_DIR=D:\Jenkins
if not exist %JENKINS_DIR% (
    mkdir %JENKINS_DIR%
)

set JOB_DIR=%JENKINS_DIR%\conda_root\%JOB_BASE_NAME%
set CACHE_DIR=%JENKINS_DIR%\conda_cache

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

if "%ANACONDA_TOKEN%" == "" (
    FOR /F "tokens=*" %%i in ('type %USERPROFILE%\AppData\Local\ContinuumIO\binstar\https%%3A%%2F%%2Fapi.anaconda.org.token') do (SET ANACONDA_TOKEN=%%i)
) else (
    echo %ANACONDA_TOKEN% > %USERPROFILE%\AppData\Local\ContinuumIO\binstar\https%%3A%%2F%%2Fapi.anaconda.org.token
)

rem copy libcrypto*dll and libssl*dll from Library\bin to DLLS

rem set VSBT_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
set VSBT_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"

set CONDA_BUILD_ARGS=^
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
FOR /F "tokens=*" %%g IN ('conda.exe build --output %CONDA_BUILD_ARGS%') do (SET CONDA_PAK=%%g)

echo "CONDA BUILD: %CONDA_PAK%"
conda.exe build %CONDA_BUILD_ARGS%

echo "ANACONDA UPLOAD: %CONDA_PAK%"
anaconda.exe ^
    --disable-ssl-warnings ^
    --show-traceback ^
    --verbose ^
    --token %ANACONDA_TOKEN% ^
    upload ^
    -u kitsune.one ^
    --no-progress ^
    --force ^
    %CONDA_PAK%
