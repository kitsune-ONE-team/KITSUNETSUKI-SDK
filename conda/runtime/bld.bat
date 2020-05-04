set PYTHON_VERSION=python38

if "%ARCH%" == "64" (
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64
) else (
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x86
)
color 0f

pip install https://files.pythonhosted.org/packages/23/96/d828354fa2dbdf216eaa7b7de0db692f12c234f7ef888cc14980ef40d1d2/attrs-19.1.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz
pip install https://files.pythonhosted.org/packages/68/9c/a6c34e565351f0b04bcf6835e38bc4bd0647269dc48670e12eb99a3f5ef5/py-ubjson-0.12.0.tar.gz
pip install https://files.pythonhosted.org/packages/75/d0/f213003c9deec99fb4f46e54580b93a3b121c487d9d6d888fc12267eb2a2/httplib2-0.12.1.tar.gz
pip install https://github.com/kitsune-ONE-team/RenderPipeline/releases/download/v1.3.2/render_pipeline-1.3.2-py3-none-any.whl

mkdir %PREFIX%\kitsunetsuki-runtime\panda3d
mkdir %PREFIX%\kitsunetsuki-runtime\panda3d
copy /V /Y %CONDA_PREFIX%\%PYTHON_VERSION%.dll              %PREFIX%\kitsunetsuki-runtime\
copy /V /Y %CONDA_PREFIX%\Lib\os.py                         %PREFIX%\kitsunetsuki-runtime\
xcopy /I /E /Y %CONDA_PREFIX%\DLLs                          %PREFIX%\kitsunetsuki-runtime\DLLs

del %PREFIX%\kitsunetsuki-runtime\cgD3D9.dll
del %PREFIX%\kitsunetsuki-runtime\cgD3D10.dll
del %PREFIX%\kitsunetsuki-runtime\cgD3D11.dll

del %PREFIX%\kitsunetsuki-runtime\DLLs\instrumented\_bz2.pyd
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

del %PREFIX%\kitsunetsuki-runtime\DLLs\_bz2.pyd
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
    %CONDA_PREFIX%\Lib\site-packages\kcc.pyd ^
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

7za a ^
    -tzip -x@%RECIPE_DIR%\exclude.txt -xr@%RECIPE_DIR%\excluder.txt ^
    %PREFIX%\kitsunetsuki-runtime\%PYTHON_VERSION%.zip ^
    "%CONDA_PREFIX%\Lib\*" ^
    %CONDA_PREFIX%\Lib\site-packages\attr ^
    %CONDA_PREFIX%\Lib\site-packages\direct ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2 ^
    %CONDA_PREFIX%\Lib\site-packages\idna ^
    %CONDA_PREFIX%\Lib\site-packages\jsonschema ^
    %CONDA_PREFIX%\Lib\site-packages\oauth2 ^
    %CONDA_PREFIX%\Lib\site-packages\pandac ^
    %CONDA_PREFIX%\Lib\site-packages\pkg_resources ^
    %CONDA_PREFIX%\Lib\site-packages\pyrsistent ^
    %CONDA_PREFIX%\Lib\site-packages\six.py ^
    %CONDA_PREFIX%\Lib\site-packages\ubjson ^
    %CONDA_PREFIX%\Lib\site-packages\rpcore ^
    %CONDA_PREFIX%\Lib\site-packages\rplibs ^
    %CONDA_PREFIX%\Lib\site-packages\rpplugins

pip uninstall --yes ^
    render-pipeline ^
    attrs ^
    httplib2 ^
    oauth2 ^
    py-ubjson
