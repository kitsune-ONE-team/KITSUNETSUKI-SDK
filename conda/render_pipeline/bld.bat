if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
)
color 0f

python setup.py

mkdir %PREFIX%\Lib
mkdir %PREFIX%\Lib\site-packages
mkdir %PREFIX%\Lib\site-packages\rpcore
mkdir %PREFIX%\Lib\site-packages\rpcore\native

xcopy /I /E /Y config                 %PREFIX%\Lib\site-packages\config
xcopy /I /E /Y data                   %PREFIX%\Lib\site-packages\data
xcopy /I /E /Y effects                %PREFIX%\Lib\site-packages\effects
xcopy /I /E /Y rplibs                 %PREFIX%\Lib\site-packages\rplibs
xcopy /I /E /Y rpplugins              %PREFIX%\Lib\site-packages\rpplugins
xcopy /I /E /Y toolkit                %PREFIX%\Lib\site-packages\toolkit

copy /V /Y     rpcore\*.py            %PREFIX%\Lib\site-packages\rpcore
xcopy /I /E /Y rpcore\gui             %PREFIX%\Lib\site-packages\rpcore\gui
xcopy /I /E /Y rpcore\pluginbase      %PREFIX%\Lib\site-packages\rpcore\pluginbase
xcopy /I /E /Y rpcore\shader          %PREFIX%\Lib\site-packages\rpcore\shader
xcopy /I /E /Y rpcore\stages          %PREFIX%\Lib\site-packages\rpcore\stages
xcopy /I /E /Y rpcore\util            %PREFIX%\Lib\site-packages\rpcore\util

copy /V /Y rpcore\native\__init__.py  %PREFIX%\Lib\site-packages\rpcore\native
copy /V /Y rpcore\native\use_cxx.flag %PREFIX%\Lib\site-packages\rpcore\native
