@echo off

set PATH=%PATH%;^
D:\Apps\Git\bin;^
D:\Apps\Svn\bin;^
D:\Apps\Miniconda3\bin;^
env\Scripts;^
env\Library\bin

set KONDA=conda
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
echo "ANACONDA TOKEN: %ANACONDA_TOKEN%"
env\Scripts\anaconda -v -t %ANACONDA_TOKEN% upload -u kitsune.one --no-progress --force %KONDA_PAK%
