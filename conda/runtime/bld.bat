pip install https://files.pythonhosted.org/packages/23/96/d828354fa2dbdf216eaa7b7de0db692f12c234f7ef888cc14980ef40d1d2/attrs-19.1.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz
pip install https://files.pythonhosted.org/packages/68/9c/a6c34e565351f0b04bcf6835e38bc4bd0647269dc48670e12eb99a3f5ef5/py-ubjson-0.12.0.tar.gz
pip install https://files.pythonhosted.org/packages/73/fb/00a976f728d0d1fecfe898238ce23f502a721c0ac0ecfedb80e0d88c64e9/six-1.12.0-py2.py3-none-any.whl
pip install https://files.pythonhosted.org/packages/75/d0/f213003c9deec99fb4f46e54580b93a3b121c487d9d6d888fc12267eb2a2/httplib2-0.12.1.tar.gz
pip install https://files.pythonhosted.org/packages/8c/46/4e93ab8a379d7efe93f20a0fb8a27bdfe88942cc954ab0210c3164e783e0/pyrsistent-0.14.11.tar.gz
pip install https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz
pip install https://files.pythonhosted.org/packages/77/de/47e35a97b2b05c2fadbec67d44cfcdcd09b8086951b331d82de90d2912da/jsonschema-2.6.0-py2.py3-none-any.whl
rem pip install https://files.pythonhosted.org/packages/cd/e6/be1b2a6ebebdaf1f790f1e750bb720fbda0335c2a19601ea9d8bb5059f38/jsonschema-3.0.0-py2.py3-none-any.whl
rem pip install https://files.pythonhosted.org/packages/d1/6a/4b2fcefd2ea0868810e92d519dacac1ddc64a2e53ba9e3422c3b62b378a6/setuptools-40.8.0-py2.py3-none-any.whl

mkdir %INSTALL%\python
mkdir %INSTALL%\python\Lib
mkdir %INSTALL%\python\Lib\site-packages
mkdir %INSTALL%\python\Lib\site-packages\panda3d
copy /V /Y %CONDA_PREFIX%\python37.dll                      %INSTALL%\python
copy /V /Y %CONDA_PREFIX%\Lib\os.py                         %INSTALL%\python\Lib
xcopy /I /E /Y %CONDA_PREFIX%\DLLs                          %INSTALL%\python\DLLs

del %INSTALL%\python\DLLs\instrumented\_bz2.pyd
del %INSTALL%\python\DLLs\instrumented\_multiprocessing.pyd
del %INSTALL%\python\DLLs\instrumented\_sqlite3.pyd
del %INSTALL%\python\DLLs\instrumented\_testbuffer.pyd
del %INSTALL%\python\DLLs\instrumented\_testcapi.pyd
del %INSTALL%\python\DLLs\instrumented\_testimportmultiple.pyd
del %INSTALL%\python\DLLs\instrumented\_testmultiphase.pyd
del %INSTALL%\python\DLLs\instrumented\_tkinter.pyd
del %INSTALL%\python\DLLs\instrumented\winsound.pyd

del %INSTALL%\python\DLLs\_bz2.pyd
del %INSTALL%\python\DLLs\_ctypes.pyd
del %INSTALL%\python\DLLs\_ctypes_test.pyd
del %INSTALL%\python\DLLs\_msi.pyd
del %INSTALL%\python\DLLs\_multiprocessing.pyd
del %INSTALL%\python\DLLs\_sqlite3.pyd
del %INSTALL%\python\DLLs\_testbuffer.pyd
del %INSTALL%\python\DLLs\_testcapi.pyd
del %INSTALL%\python\DLLs\_testimportmultiple.pyd
del %INSTALL%\python\DLLs\_testmultiphase.pyd
del %INSTALL%\python\DLLs\_tkinter.pyd
del %INSTALL%\python\DLLs\winsound.pyd

del %INSTALL%\python\DLLs\tcl86t.dll
del %INSTALL%\python\DLLs\tk86t.dll
del %INSTALL%\python\DLLs\tk86t.dll

copy /V /Y ^
   %CONDA_PREFIX%\Lib\site-packages\panda3d\__init__.py     %INSTALL%\python\Lib\site-packages\panda3d
copy /V /Y ^
   %CONDA_PREFIX%\lib\site-packages\panda3d\*.pyd           %INSTALL%\python\Lib\site-packages\panda3d
copy /V /Y ^ %CONDA_PREFIX%\Lib\site-packages\kcc.pyd       %INSTALL%\python\Lib\site-packages
copy /V /Y %CONDA_PREFIX%\Lib\site-packages\httplib2\cacerts.txt ^
                                                            %INSTALL%\python

del %INSTALL%\python\sqlite3.dll

copy /V /Y %RECIPE_DIR%\Miniconda3-LICENSE.txt              %INSTALL%\python
copy /V /Y %RECIPE_DIR%\oauth2-LICENSE.txt                  %INSTALL%\python
copy /V /Y %RECIPE_DIR%\Panda3D-LICENSE.txt                 %INSTALL%\python
copy /V /Y %RECIPE_DIR%\py-ubjson-LICENSE.txt               %INSTALL%\python
copy /V /Y %RECIPE_DIR%\py-ubjson-NOTICE.txt                %INSTALL%\python
copy /V /Y %CONDA_PREFIX%\Library\bin\*.dll                 %INSTALL%\python

7za a ^
    -tzip -x@%RECIPE_DIR%\exclude.txt -xr@%RECIPE_DIR%\excluder.txt ^
    %INSTALL%\python\python37.zip ^
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
    %CONDA_PREFIX%\Lib\site-packages\ubjson

pip uninstall --yes ^
    attrs ^
    oauth2 ^
    py-ubjson ^
    six ^
    httplib2 ^
    pyrsistent ^
    idna ^
    jsonschema
