@echo off

set WORKSPACES=D:\Workspaces
if not exist %WORKSPACES% (
    mkdir %WORKSPACES%
)

set WORKSPACE=D:\Workspaces\%JOB_BASE_NAME%
if not exist %WORKSPACE% (
    mkdir %WORKSPACE%
)

set CACHE=D:\Cache
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
--croot %WORKSPACE%\croot ^
--dirty ^
--error-overlinking ^
--keep-old-work ^
--no-anaconda-upload ^
--no-build-id ^
--no-remove-work-dir ^
--output-folder %WORKSPACE%\output ^
conda\%JOB_BASE_NAME%

if not exist %WORKSPACE%\env (
    rem %KONDA% env remove --yes --prefix env
    :: if you have ssl connection problems with it
    :: copy files "libcrypto-1_1-x64.dll" and "libssl-1_1-x64.dll"
    :: from "Library/bin" to "DDLs"
    %KONDA% create --yes --prefix %WORKSPACE%\env
    %KONDA% install --prefix %WORKSPACE%\env conda-build anaconda-client ripgrep
)

FOR /F "tokens=*" %%g IN ('%WORKSPACE%\env\condabin\conda build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)

echo "CONDA BUILD: %KONDA_PAK%"
call env\condabin\conda build %KONDA_ARGS%

echo "ANACONDA UPLOAD: %KONDA_PAK%"
echo "ANACONDA TOKEN: %ANACONDA_TOKEN%"
%WORKSPACE%\env\Scripts\anaconda ^
    -v -t %ANACONDA_TOKEN% ^
    upload -u kitsune.one --no-progress --force %KONDA_PAK%
