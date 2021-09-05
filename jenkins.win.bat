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

set PATH=%PATH%;^
env\Scripts;^
env\Library\bin

set KONDA=_conda
set KONDA_ARGS=^
--cache-dir %CACHE% ^
--channel kitsune.one ^
--croot %WORKSPACE%\build_root ^
--dirty ^
--error-overlinking ^
--keep-old-work ^
--no-anaconda-upload ^
--no-build-id ^
--no-remove-work-dir ^
--output-folder %WORKSPACE%\output ^
conda\%JOB_BASE_NAME%

if exist %WORKSPACE%\build_env (
    rmdir /S /Q %WORKSPACE%\build_env
)

if not exist %WORKSPACE%\build_env (
    %KONDA% create --yes --prefix %WORKSPACE%\build_env
    %KONDA% install --prefix %WORKSPACE%\build_env conda==4.10.3 conda-build anaconda-client ripgrep

    :: fix ssl connection problems
    copy /V /Y %WORKSPACE%\build_env\Library\bin\libcrypto*.dll %WORKSPACE%\build_env\DLLs
    copy /V /Y %WORKSPACE%\build_env\Library\bin\libssl*.dll %WORKSPACE%\build_env\DLLs
)

FOR /F "tokens=*" %%g IN ('%WORKSPACE%\build_env\condabin\conda build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)

echo "CONDA BUILD: %KONDA_PAK%"
call %WORKSPACE%\build_env\condabin\conda build %KONDA_ARGS%

echo "ANACONDA UPLOAD: %KONDA_PAK%"
%WORKSPACE%\build_env\Scripts\anaconda ^
    --disable-ssl-warnings ^
    --show-traceback ^
    --verbose ^
    --token %ANACONDA_TOKEN% ^
    upload ^
    -u kitsune.one ^
    --no-progress ^
    --force ^
    %KONDA_PAK%
