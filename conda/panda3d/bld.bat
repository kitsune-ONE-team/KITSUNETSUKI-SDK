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

set BUILT=built

if not exist %BUILT% (
    mkdir %BUILT%
)

cd %BUILT%
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%\Library" ^
    -DCMAKE_CXX_FLAGS="/bigobj" ^
    -DBUILD_DTOOL=ON ^
    -DBUILD_PANDA=ON ^
    -DBUILD_DIRECT=ON ^
    -DBUILD_PANDATOOL=ON ^
    -DBUILD_CONTRIB=ON ^
    -DBUILD_MODELS=ON ^
    ..

nmake
nmake install

cd ..

rem mkdir %PREFIX%\Library
rem xcopy /I /E /Y %BUILT%\bin                        %PREFIX%\Library\bin
rem xcopy /I /E /Y %BUILT%\etc                        %PREFIX%\Library\etc
rem xcopy /I /E /Y %BUILT%\lib                        %PREFIX%\Library\lib

rem mkdir %PREFIX%\Library\include
rem xcopy /I /E /Y %BUILT%\include                    %PREFIX%\Library\include\panda3d

rem mkdir %PREFIX%\Library\share
rem mkdir %PREFIX%\Library\share\panda3d
rem xcopy /I /E /Y %BUILT%\models                     %PREFIX%\Library\share\panda3d\models

rem mkdir %PREFIX%\Lib
rem mkdir %PREFIX%\Lib\site-packages
rem xcopy /I /E /Y %BUILT%\direct                     %PREFIX%\Lib\site-packages\direct
rem xcopy /I /E /Y %BUILT%\panda3d                    %PREFIX%\Lib\site-packages\panda3d
rem xcopy /I /E /Y %BUILT%\panda3d.dist-info          %PREFIX%\Lib\site-packages\panda3d.dist-info
rem xcopy /I /E /Y %BUILT%\pandac                     %PREFIX%\Lib\site-packages\pandac

rem del %PREFIX%\Library\bin\cg.dll
rem del %PREFIX%\Library\bin\cgGL.dll
rem del %PREFIX%\Library\bin\cgD3D9.dll
rem del %PREFIX%\Library\bin\cgD3D10.dll
rem del %PREFIX%\Library\bin\cgD3D11.dll
rem del %PREFIX%\Library\bin\*.pdb
rem del %PREFIX%\Library\lib\*.pdb
rem del %PREFIX%\Lib\site-packages\panda3d\*.pdb
