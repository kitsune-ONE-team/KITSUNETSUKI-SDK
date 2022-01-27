if "%ARCH%" == "64" (
    call %VSBT_PATH% x64 %WINDOWS_SDK_VERSION%
) else (
    call %VSBT_PATH% x86 %WINDOWS_SDK_VERSION%
)
color 0f

set PYTHON_VERSION=python39
set RP_VERSION=2.0.1

pip install git+https://github.com/Moguri/panda3d-gltf.git@v0.13
pip install git+https://github.com/Iotic-Labs/py-ubjson.git@v0.16.1
pip install git+https://github.com/httplib2/httplib2.git@v0.20.2
pip install git+https://github.com/joestump/python-oauth2.git@v1.9
pip install https://github.com/kitsune-ONE-team/RenderPipeline/releases/download/v%RP_VERSION%/render_pipeline-%RP_VERSION%-py3-none-any.whl

mkdir %PREFIX%\kitsunetsuki-runtime\panda3d
copy /V /Y %CONDA_PREFIX%\%PYTHON_VERSION%.dll              %PREFIX%\kitsunetsuki-runtime\
copy /V /Y %CONDA_PREFIX%\Lib\os.py                         %PREFIX%\kitsunetsuki-runtime\
xcopy /I /E /Y %CONDA_PREFIX%\DLLs                          %PREFIX%\kitsunetsuki-runtime\DLLs

del %PREFIX%\kitsunetsuki-runtime\cg.dll
del %PREFIX%\kitsunetsuki-runtime\cgGL.dll
del %PREFIX%\kitsunetsuki-runtime\cgD3D9.dll
del %PREFIX%\kitsunetsuki-runtime\cgD3D10.dll
del %PREFIX%\kitsunetsuki-runtime\cgD3D11.dll

del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_msi.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_sqlite3.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_testbuffer.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_testcapi.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_testconsole.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_testimportmultiple.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_testinternalcapi.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_testmultiphase.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_tkinter.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\winsound.pyd

del %PREFIX%\kitsunetsuki-runtime\DLLs\_msi.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_sqlite3.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_testbuffer.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_testcapi.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_testcapi.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_testconsole.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_testimportmultiple.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_testmultiphase.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\_tkinter.pyd
del %PREFIX%\kitsunetsuki-runtime\DLLs\winsound.pyd

del %PREFIX%\kitsunetsuki-runtime\DLLs\py.ico
del %PREFIX%\kitsunetsuki-runtime\DLLs\pyc.ico
del %PREFIX%\kitsunetsuki-runtime\DLLs\tcl86t.dll
del %PREFIX%\kitsunetsuki-runtime\DLLs\tk86t.dll
del %PREFIX%\kitsunetsuki-runtime\DLLs\tk86t.dll

copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d\__init__.py ^
                                                            %PREFIX%\kitsunetsuki-runtime\panda3d
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d\*.pyd ^
                                                            %PREFIX%\kitsunetsuki-runtime\panda3d
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\kphys.pyd ^
                                                            %PREFIX%\kitsunetsuki-runtime
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2\cacerts.txt ^
                                                            %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\Miniconda3-LICENSE.txt              %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\OpenAL-soft-LICENSE.txt             %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\Panda3D-LICENSE.txt                 %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\jsonschema-LICENSE.txt              %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\oauth2-LICENSE.txt                  %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\py-ubjson-LICENSE.txt               %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\py-ubjson-NOTICE.txt                %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\vorbis-LICENSE.txt                  %PREFIX%\kitsunetsuki-runtime
copy /V /Y %RECIPE_DIR%\zlib-LICENSE.txt                    %PREFIX%\kitsunetsuki-runtime

copy /V /Y %CONDA_PREFIX%\Library\bin\*.dll                 %PREFIX%\kitsunetsuki-runtime

if "%ARCH%" == "64" (
   copy /V /Y "%VCToolsRedistDir%\x64\Microsoft.VC142.CRT\*.dll" %PREFIX%\kitsunetsuki-runtime
) else (
   copy /V /Y "%VCToolsRedistDir%\x86\Microsoft.VC142.CRT\*.dll" %PREFIX%\kitsunetsuki-runtime
)

del %PREFIX%\kitsunetsuki-runtime\sqlite3.dll

D:\Apps\7-Zip\7z a ^
    -tzip -x@%RECIPE_DIR%\exclude.txt -xr@%RECIPE_DIR%\excluder.txt ^
    %PREFIX%\kitsunetsuki-runtime\%PYTHON_VERSION%.zip ^
    "%CONDA_PREFIX%\Lib\*" ^
    %CONDA_PREFIX%\Lib\site-packages\attr ^
    %CONDA_PREFIX%\Lib\site-packages\config ^
    %CONDA_PREFIX%\Lib\site-packages\direct ^
    %CONDA_PREFIX%\Lib\site-packages\effects ^
    %CONDA_PREFIX%\Lib\site-packages\gltf ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2 ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2-0.20.2.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\idna ^
    %CONDA_PREFIX%\Lib\site-packages\jsonschema ^
    %CONDA_PREFIX%\Lib\site-packages\jsonschema-3.2.0.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\oauth2 ^
    %CONDA_PREFIX%\Lib\site-packages\oauth2-1.9.0.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d_gltf-0.13.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\pandac ^
    %CONDA_PREFIX%\Lib\site-packages\pkg_resources ^
    %CONDA_PREFIX%\Lib\site-packages\py_ubjson-0.16.1.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\pyparsing ^
    %CONDA_PREFIX%\Lib\site-packages\pyrsistent ^
    %CONDA_PREFIX%\Lib\site-packages\render_pipeline-%RP_VERSION%.dist-info ^
    %CONDA_PREFIX%\Lib\site-packages\rpcore ^
    %CONDA_PREFIX%\Lib\site-packages\rplibs ^
    %CONDA_PREFIX%\Lib\site-packages\rpplugins ^
    %CONDA_PREFIX%\Lib\site-packages\shader ^
    %CONDA_PREFIX%\Lib\site-packages\six.py ^
    %CONDA_PREFIX%\Lib\site-packages\ubjson

pip uninstall --yes ^
    httplib2 ^
    oauth2 ^
    panda3d-gltf ^
    py-ubjson ^
    render-pipeline
