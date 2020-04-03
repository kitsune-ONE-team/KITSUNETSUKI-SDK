set PATH=%PATH%;D:\Apps\Git\bin
set KONDA=D:\Apps\Miniconda3_x64\Scripts\conda
set KONDA_ARGS=^
--cache-dir D:\Cache ^
--croot croot ^
--output-folder output ^
--channel kitsune.one ^
conda\%JOB_BASE_NAME%
set KONDA_TOKEN=C:\Users\WIN8\.continuum\anaconda-client\tokens\https%%3A%%2F%%2Fapi.anaconda.org.token

%KONDA% env remove --yes --prefix env

rem if you have ssl connection problems with it
rem copy files "libcrypto-1_1-x64.dll" and "libssl-1_1-x64.dll"
rem from "Library/bin" to "DDLs"
%KONDA% create --yes --prefix env

%KONDA% install --prefix env conda-build anaconda-client

rem FOR /F "tokens=*" %%g IN ('env\Scripts\conda build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)
FOR /F "tokens=*" %%g IN ('env\condabin\conda build --output %KONDA_ARGS%') do (SET KONDA_PAK=%%g)

rem env\Scripts\conda build %KONDA_ARGS%
env\condabin\conda build %KONDA_ARGS%
env\Scripts\anaconda ^
--verbose ^
--token %KONDA_TOKEN% ^
upload ^
--user kitsune.one ^
--force ^
%KONDA_PAK%
