set PATH=%PATH%;^
D:\Apps\Git\bin;^
env\Scripts;^
env\Library\bin

set KONDA=D:\Apps\Miniconda3_x64\Scripts\conda
set KONDA_ARGS=^
--cache-dir D:\Cache ^
--channel kitsune.one ^
--croot croot ^
--dirty ^
--error-overlinking ^
--keep-old-work ^
--no-anaconda-upload ^
--no-build-id ^
--no-remove-work-dir ^
--output-folder output ^
conda\%JOB_BASE_NAME%
set KONDA_TOKEN=C:\Users\WIN8\AppData\Local\ContinuumIO\binstar\https%%3A%%2F%%2Fapi.anaconda.org.token

if not exist env (
    %KONDA% env remove --yes --prefix env
    :: if you have ssl connection problems with it
    :: copy files "libcrypto-1_1-x64.dll" and "libssl-1_1-x64.dll"
    :: from "Library/bin" to "DDLs"
    %KONDA% create --yes --prefix env
    %KONDA% install --prefix env conda-build anaconda-client ripgrep
)

FOR /F "tokens=*" %%g IN ('env\condabin\conda build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)

echo "CONDA BUILD: %KONDA_PAK%"
call env\condabin\conda build %KONDA_ARGS%

echo "ANACONDA UPLOAD: %KONDA_PAK%"
env\Scripts\anaconda ^
--verbose ^
--token %KONDA_TOKEN% ^
upload ^
--no-progress ^
--user kitsune.one ^
--force ^
%KONDA_PAK%
