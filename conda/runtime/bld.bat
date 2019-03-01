if "%ARCH%" == "64" (
    set INSTALL=%PREFIX%\runtime-winx64
) else (
    set INSTALL=%PREFIX%\runtime-winx32
)

pip install -r %RECIPE_DIR%\req.txt

mkdir %INSTALL%\kgame
mkdir %INSTALL%\kgame\Lib
mkdir %INSTALL%\kgame\Lib\site-packages
mkdir %INSTALL%\kgame\Lib\site-packages\panda3d
copy /V /Y %CONDA_PREFIX%\python37.dll                      %INSTALL%\kgame
copy /V /Y %CONDA_PREFIX%\Lib\os.py                         %INSTALL%\kgame\Lib
xcopy /I /E /Y %CONDA_PREFIX%\DLLs                          %INSTALL%\kgame\DLLs

copy /V /Y ^
   %CONDA_PREFIX%\Lib\site-packages\panda3d\__init__.py     %INSTALL%\kgame\Lib\site-packages\panda3d
copy /V /Y ^
   %CONDA_PREFIX%\lib\site-packages\panda3d\*.pyd           %INSTALL%\kgame\Lib\site-packages\panda3d
copy /V /Y ^ %CONDA_PREFIX%\Lib\site-packages\kcc.pyd       %INSTALL%\kgame\Lib\site-packages
copy /V /Y %CONDA_PREFIX%\Lib\site-packages\httplib2\cacerts.txt ^
                                                            %INSTALL%\kgame

copy /V /Y %RECIPE_DIR%\Miniconda3-LICENSE.txt              %INSTALL%\kgame
copy /V /Y %RECIPE_DIR%\oauth2-LICENSE.txt                  %INSTALL%\kgame
copy /V /Y %RECIPE_DIR%\Panda3D-LICENSE.txt                 %INSTALL%\kgame
copy /V /Y %RECIPE_DIR%\py-ubjson-LICENSE.txt               %INSTALL%\kgame
copy /V /Y %RECIPE_DIR%\py-ubjson-NOTICE.txt                %INSTALL%\kgame
copy /V /Y %CONDA_PREFIX%\Library\bin\*.dll                 %INSTALL%\kgame

7za a ^
    -tzip -x@%RECIPE_DIR%\exclude.txt -xr@%RECIPE_DIR%\excluder.txt ^
    %INSTALL%\kgame\python37.zip ^
    "%CONDA_PREFIX%\Lib\*" ^
    %CONDA_PREFIX%\Lib\site-packages\direct ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2 ^
    %CONDA_PREFIX%\Lib\site-packages\idna ^
    %CONDA_PREFIX%\Lib\site-packages\jsonschema ^
    %CONDA_PREFIX%\Lib\site-packages\oauth2 ^
    %CONDA_PREFIX%\Lib\site-packages\pandac ^
    %CONDA_PREFIX%\Lib\site-packages\ubjson

pip uninstall --yes httplib2 jsonschema oauth2 py-ubjson idna
