if "%ARCH%" == "64" (
    call %VSBT_PATH% x64 %WINDOWS_SDK_VERSION%
    set THIRDPARTY=thirdparty\win-libs-vc14-x64
) else (
    call %VSBT_PATH% x86 %WINDOWS_SDK_VERSION%
    set THIRDPARTY=thirdparty\win-libs-vc14
)
color 0f

:: remove included libs
rmdir /S /Q %THIRDPARTY%\bullet
rmdir /S /Q %THIRDPARTY%\openssl
rmdir /S /Q %THIRDPARTY%\png

:: remove included python
if exist thirdparty\win-python3.4-x64 ( rmdir /S /Q thirdparty\win-python3.4-x64 )
if exist thirdparty\win-python3.5-x64 ( rmdir /S /Q thirdparty\win-python3.5-x64 )
if exist thirdparty\win-python3.6-x64 ( rmdir /S /Q thirdparty\win-python3.6-x64 )
if exist thirdparty\win-python3.7-x64 ( rmdir /S /Q thirdparty\win-python3.7-x64 )
if exist thirdparty\win-python3.8-x64 ( rmdir /S /Q thirdparty\win-python3.8-x64 )
if exist thirdparty\win-python3.9-x64 ( rmdir /S /Q thirdparty\win-python3.9-x64 )
if exist thirdparty\win-python3.10-x64 ( rmdir /S /Q thirdparty\win-python3.10-x64 )
if exist thirdparty\win-python-x64 ( rmdir /S /Q thirdparty\win-python-x64 )

set BUILT=built

if not exist %BUILT% (
    mkdir %BUILT%
)

cd %BUILT%
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Standard ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%\Library" ^
    -DBUILD_CONTRIB=ON ^
    -DBUILD_DIRECT=ON ^
    -DBUILD_DTOOL=ON ^
    -DBUILD_METALIBS=ON ^
    -DBUILD_MODELS=ON ^
    -DBUILD_PANDA=ON ^
    -DBUILD_PANDATOOL=ON ^
    -DCMAKE_CXX_FLAGS="/bigobj" ^
    -DHAVE_EIGEN=NO ^
    ..

nmake
nmake install

cd ..

:: move python packages to site-packages
mkdir %PREFIX%\Lib
mkdir %PREFIX%\Lib\site-packages
xcopy /I /E /Y %PREFIX%\Library\direct            %PREFIX%\Lib\site-packages\direct
xcopy /I /E /Y %PREFIX%\Library\panda3d           %PREFIX%\Lib\site-packages\panda3d
xcopy /I /E /Y %PREFIX%\Library\pandac            %PREFIX%\Lib\site-packages\pandac
rmdir /S /Q %PREFIX%\Library\direct
rmdir /S /Q %PREFIX%\Library\panda3d
rmdir /S /Q %PREFIX%\Library\pandac

:: copy missing includes
xcopy /I /E /Y dtool\src\parser-inc               %PREFIX%\Library\include\panda3d\parser-inc

:: copy dist-info for pip
xcopy /I /E /Y %BUILT%\panda3d.dist-info          %PREFIX%\Lib\site-packages\panda3d.dist-info
