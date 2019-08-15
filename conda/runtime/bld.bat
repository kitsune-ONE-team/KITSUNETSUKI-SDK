if "%ARCH%" == "64" (
    set MINGW=x86_64-w64-mingw32
    set DISCORD=win64-dynamic
) else (
    set MINGW=i686-w64-mingw32
    set DISCORD=win32-dynamic
)

pip install https://files.pythonhosted.org/packages/23/96/d828354fa2dbdf216eaa7b7de0db692f12c234f7ef888cc14980ef40d1d2/attrs-19.1.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz
pip install https://files.pythonhosted.org/packages/68/9c/a6c34e565351f0b04bcf6835e38bc4bd0647269dc48670e12eb99a3f5ef5/py-ubjson-0.12.0.tar.gz
pip install https://files.pythonhosted.org/packages/73/fb/00a976f728d0d1fecfe898238ce23f502a721c0ac0ecfedb80e0d88c64e9/six-1.12.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/75/d0/f213003c9deec99fb4f46e54580b93a3b121c487d9d6d888fc12267eb2a2/httplib2-0.12.1.tar.gz
pip install https://files.pythonhosted.org/packages/8c/46/4e93ab8a379d7efe93f20a0fb8a27bdfe88942cc954ab0210c3164e783e0/pyrsistent-0.14.11.tar.gz
pip install https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz
pip install https://files.pythonhosted.org/packages/77/de/47e35a97b2b05c2fadbec67d44cfcdcd09b8086951b331d82de90d2912da/jsonschema-2.6.0-py2.py3-none-any.whl

mkdir %PREFIX%\python
mkdir %PREFIX%\python\Lib
mkdir %PREFIX%\python\Lib\site-packages
mkdir %PREFIX%\python\Lib\site-packages\panda3d
copy /V /Y %CONDA_PREFIX%\python37.dll                      %PREFIX%\python
copy /V /Y %CONDA_PREFIX%\Lib\os.py                         %PREFIX%\python\Lib
xcopy /I /E /Y %CONDA_PREFIX%\DLLs                          %PREFIX%\python\DLLs

del %PREFIX%\python\DLLs\instrumented\_bz2.pyd
del %PREFIX%\python\DLLs\instrumented\_sqlite3.pyd
del %PREFIX%\python\DLLs\instrumented\_testbuffer.pyd
del %PREFIX%\python\DLLs\instrumented\_testcapi.pyd
del %PREFIX%\python\DLLs\instrumented\_testimportmultiple.pyd
del %PREFIX%\python\DLLs\instrumented\_testmultiphase.pyd
del %PREFIX%\python\DLLs\instrumented\_tkinter.pyd
del %PREFIX%\python\DLLs\instrumented\winsound.pyd

del %PREFIX%\python\DLLs\_bz2.pyd
del %PREFIX%\python\DLLs\_msi.pyd
del %PREFIX%\python\DLLs\_sqlite3.pyd
del %PREFIX%\python\DLLs\_testbuffer.pyd
del %PREFIX%\python\DLLs\_testcapi.pyd
del %PREFIX%\python\DLLs\_testimportmultiple.pyd
del %PREFIX%\python\DLLs\_testmultiphase.pyd
del %PREFIX%\python\DLLs\_tkinter.pyd
del %PREFIX%\python\DLLs\winsound.pyd

del %PREFIX%\python\DLLs\tcl86t.dll
del %PREFIX%\python\DLLs\tk86t.dll
del %PREFIX%\python\DLLs\tk86t.dll

copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d\__init__.py ^
    %PREFIX%\python\Lib\site-packages\panda3d
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d\*.pyd ^
    %PREFIX%\python\Lib\site-packages\panda3d
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\kcc.pyd ^
    %PREFIX%\python\Lib\site-packages
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2\cacerts.txt ^
    %PREFIX%\python

xcopy /I /E /Y ^
    %CONDA_PREFIX%\Lib\site-packages\rpcore ^
    %PREFIX%\python\Lib\site-packages\rpcore
xcopy /I /E /Y ^
    %CONDA_PREFIX%\Lib\site-packages\rplibs ^
    %PREFIX%\python\Lib\site-packages\rplibs
xcopy /I /E /Y ^
    %CONDA_PREFIX%\Lib\site-packages\rpplugins ^
    %PREFIX%\python\Lib\site-packages\rpplugins

rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpcore\shader
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\ao\shader
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\bloom\resources
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\clouds\resources
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\plugin_prefab
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\scattering\resources
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\smaa\resources

del %PREFIX%\python\sqlite3.dll

copy /V /Y %RECIPE_DIR%\Miniconda3-LICENSE.txt              %PREFIX%\python
copy /V /Y %RECIPE_DIR%\oauth2-LICENSE.txt                  %PREFIX%\python
copy /V /Y %RECIPE_DIR%\Panda3D-LICENSE.txt                 %PREFIX%\python
copy /V /Y %RECIPE_DIR%\py-ubjson-LICENSE.txt               %PREFIX%\python
copy /V /Y %RECIPE_DIR%\py-ubjson-NOTICE.txt                %PREFIX%\python
copy /V /Y %CONDA_PREFIX%\Library\bin\*.dll                 %PREFIX%\python
copy /V /Y %RECIPE_DIR%\%MINGW%\5.3-win32\*.dll             %PREFIX%\python
copy /V /Y %RECIPE_DIR%\%MINGW%\5.3-win32\*.dll             %PREFIX%\python
copy /V /Y %RECIPE_DIR%\discord-rpc\%DISCORD%\bin\*.dll     %PREFIX%\python

7za a ^
    -tzip -x@%RECIPE_DIR%\exclude.txt -xr@%RECIPE_DIR%\excluder.txt ^
    %PREFIX%\python\python37.zip ^
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
    %PREFIX%\python\Lib\site-packages\rpcore ^
    %PREFIX%\python\Lib\site-packages\rplibs ^
    %PREFIX%\python\Lib\site-packages\rpplugins

rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpcore
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rplibs
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins

pip uninstall --yes ^
    attrs ^
    oauth2 ^
    py-ubjson ^
    six ^
    httplib2 ^
    pyrsistent ^
    idna ^
    jsonschema
