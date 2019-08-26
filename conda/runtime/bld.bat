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

mkdir %PREFIX%\panda3d
copy /V /Y %CONDA_PREFIX%\python37.dll                      %PREFIX%
copy /V /Y %CONDA_PREFIX%\Lib\os.py                         %PREFIX%

xcopy /I /E /Y %CONDA_PREFIX%\DLLs                          %PREFIX%\DLLs

del %PREFIX%\DLLs\instrumented\_bz2.pyd
del %PREFIX%\DLLs\instrumented\_sqlite3.pyd
del %PREFIX%\DLLs\instrumented\_testbuffer.pyd
del %PREFIX%\DLLs\instrumented\_testcapi.pyd
del %PREFIX%\DLLs\instrumented\_testimportmultiple.pyd
del %PREFIX%\DLLs\instrumented\_testmultiphase.pyd
del %PREFIX%\DLLs\instrumented\_tkinter.pyd
del %PREFIX%\DLLs\instrumented\winsound.pyd

del %PREFIX%\DLLs\_bz2.pyd
del %PREFIX%\DLLs\_msi.pyd
del %PREFIX%\DLLs\_sqlite3.pyd
del %PREFIX%\DLLs\_testbuffer.pyd
del %PREFIX%\DLLs\_testcapi.pyd
del %PREFIX%\DLLs\_testimportmultiple.pyd
del %PREFIX%\DLLs\_testmultiphase.pyd
del %PREFIX%\DLLs\_tkinter.pyd
del %PREFIX%\DLLs\winsound.pyd

del %PREFIX%\DLLs\tcl86t.dll
del %PREFIX%\DLLs\tk86t.dll
del %PREFIX%\DLLs\tk86t.dll

copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d\__init__.py ^
                                                            %PREFIX%\panda3d
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\panda3d\*.pyd ^
                                                            %PREFIX%\panda3d
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\kcc.pyd ^
                                                            %PREFIX%
copy /V /Y ^
    %CONDA_PREFIX%\Lib\site-packages\httplib2\cacerts.txt ^
                                                            %PREFIX%

copy /V /Y %RECIPE_DIR%\Miniconda3-LICENSE.txt              %PREFIX%
copy /V /Y %RECIPE_DIR%\Panda3D-LICENSE.txt                 %PREFIX%
copy /V /Y %RECIPE_DIR%\jsonschema-LICENSE.txt              %PREFIX%
copy /V /Y %RECIPE_DIR%\oauth2-LICENSE.txt                  %PREFIX%
copy /V /Y %RECIPE_DIR%\py-ubjson-LICENSE.txt               %PREFIX%
copy /V /Y %RECIPE_DIR%\py-ubjson-NOTICE.txt                %PREFIX%

copy /V /Y %CONDA_PREFIX%\Library\bin\*.dll                 %PREFIX%
copy /V /Y %RECIPE_DIR%\%MINGW%\5.3-win32\*.dll             %PREFIX%
copy /V /Y %RECIPE_DIR%\%MINGW%\5.3-win32\*.dll             %PREFIX%
copy /V /Y %RECIPE_DIR%\discord-rpc\%DISCORD%\bin\*.dll     %PREFIX%

del %PREFIX%\sqlite3.dll
rem del %PREFIX%\Qt5*.dll

del %PREFIX%\Qt53DAnimation.dll
del %PREFIX%\Qt53DCore.dll
del %PREFIX%\Qt53DExtras.dll
del %PREFIX%\Qt53DInput.dll
del %PREFIX%\Qt53DLogic.dll
del %PREFIX%\Qt53DQuick.dll
del %PREFIX%\Qt53DQuickAnimation.dll
del %PREFIX%\Qt53DQuickExtras.dll
del %PREFIX%\Qt53DQuickInput.dll
del %PREFIX%\Qt53DQuickRender.dll
del %PREFIX%\Qt53DQuickScene2D.dll
del %PREFIX%\Qt53DRender.dll
del %PREFIX%\Qt5Bluetooth.dll
del %PREFIX%\Qt5Charts.dll
del %PREFIX%\Qt5Concurrent.dll
del %PREFIX%\Qt5Core.dll
del %PREFIX%\Qt5DataVisualization.dll
del %PREFIX%\Qt5DBus.dll
del %PREFIX%\Qt5Designer.dll
del %PREFIX%\Qt5DesignerComponents.dll
del %PREFIX%\Qt5Gamepad.dll
del %PREFIX%\Qt5Gui.dll
del %PREFIX%\Qt5Help.dll
del %PREFIX%\Qt5Location.dll
del %PREFIX%\Qt5Multimedia.dll
del %PREFIX%\Qt5MultimediaQuick_p.dll
del %PREFIX%\Qt5MultimediaWidgets.dll
del %PREFIX%\Qt5Network.dll
del %PREFIX%\Qt5NetworkAuth.dll
del %PREFIX%\Qt5Nfc.dll
del %PREFIX%\Qt5OpenGL.dll
del %PREFIX%\Qt5Positioning.dll
del %PREFIX%\Qt5PrintSupport.dll
del %PREFIX%\Qt5Purchasing.dll
del %PREFIX%\Qt5Qml.dll
del %PREFIX%\Qt5Quick.dll
del %PREFIX%\Qt5QuickControls2.dll
del %PREFIX%\Qt5QuickParticles.dll
del %PREFIX%\Qt5QuickTemplates2.dll
del %PREFIX%\Qt5QuickTest.dll
del %PREFIX%\Qt5QuickWidgets.dll
del %PREFIX%\Qt5RemoteObjects.dll
del %PREFIX%\Qt5Script.dll
del %PREFIX%\Qt5ScriptTools.dll
del %PREFIX%\Qt5Scxml.dll
del %PREFIX%\Qt5Sensors.dll
del %PREFIX%\Qt5SerialBus.dll
del %PREFIX%\Qt5SerialPort.dll
del %PREFIX%\Qt5Sql.dll
del %PREFIX%\Qt5Svg.dll
del %PREFIX%\Qt5Test.dll
del %PREFIX%\Qt5TextToSpeech.dll
del %PREFIX%\Qt5WebChannel.dll
del %PREFIX%\Qt5WebEngine.dll
del %PREFIX%\Qt5WebEngineCore.dll
del %PREFIX%\Qt5WebEngineWidgets.dll
del %PREFIX%\Qt5WebSockets.dll
del %PREFIX%\Qt5WebView.dll
del %PREFIX%\Qt5Widgets.dll
del %PREFIX%\Qt5WinExtras.dll
del %PREFIX%\Qt5Xml.dll
del %PREFIX%\Qt5XmlPatterns.dll

7za a ^
    -tzip -x@%RECIPE_DIR%\exclude.txt -xr@%RECIPE_DIR%\excluder.txt ^
    %PREFIX%\python37.zip ^
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
    attrs ^
    httplib2 ^
    idna ^
    jsonschema ^
    oauth2 ^
    py-ubjson ^
    pyrsistent ^
    six
