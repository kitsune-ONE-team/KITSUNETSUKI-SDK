@echo off
set PATH=%PATH%;^
D:\7-Zip;^
D:\Git\bin;^
D:\Miniconda3;^
D:\Miniconda3\Library\bin;^
D:\Miniconda3\Scripts;^
D:\NuGet;^
D:\Svn\bin

conda activate builder

set JENKINS_DIR=%USERPROFILE%\Jenkins\conda
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

rem copy libcrypto*dll and libssl*dll from Library\bin to DLLS

set VSBT_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat"
rem set VSBT_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"

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
FOR /F "tokens=*" %%g IN ('conda build --output %CONDA_BUILD_ARGS%') do (SET CONDA_PAK=%%g)

echo "CONDA BUILD: %CONDA_PAK%"
conda build %CONDA_BUILD_ARGS%

echo "ANACONDA UPLOAD: %CONDA_PAK%"
anaconda ^
    --disable-ssl-warnings ^
    --show-traceback ^
    --verbose ^
    --token %ANACONDA_TOKEN% ^
    upload ^
    -u kitsune.one ^
    --no-progress ^
    --force ^
    %CONDA_PAK%
