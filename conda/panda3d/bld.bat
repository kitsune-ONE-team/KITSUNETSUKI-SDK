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

rem cd %BUILT%
rem cmake -G "NMake Makefiles" ^
rem     -DCMAKE_BUILD_TYPE=Standard ^
rem     -DCMAKE_INSTALL_PREFIX="%PREFIX%\Library" ^
rem     -DBUILD_CONTRIB=ON ^
rem     -DBUILD_DIRECT=ON ^
rem     -DBUILD_DTOOL=ON ^
rem     -DBUILD_METALIBS=ON ^
rem     -DBUILD_MODELS=ON ^
rem     -DBUILD_PANDA=ON ^
rem     -DBUILD_PANDATOOL=ON ^
rem     -DCMAKE_CXX_FLAGS="/bigobj" ^
rem     -DHAVE_EIGEN=NO ^
rem     ..

rem nmake
rem nmake install

rem cd ..

:: move python packages to site-packages
rem mkdir %PREFIX%\Lib
rem mkdir %PREFIX%\Lib\site-packages
rem xcopy /I /E /Y %PREFIX%\Library\direct            %PREFIX%\Lib\site-packages\direct
rem xcopy /I /E /Y %PREFIX%\Library\panda3d           %PREFIX%\Lib\site-packages\panda3d
rem xcopy /I /E /Y %PREFIX%\Library\pandac            %PREFIX%\Lib\site-packages\pandac
rem rmdir /S /Q %PREFIX%\Library\direct
rem rmdir /S /Q %PREFIX%\Library\panda3d
rem rmdir /S /Q %PREFIX%\Library\pandac

:: copy missing includes
rem xcopy /I /E /Y dtool\src\parser-inc               %PREFIX%\Library\include\panda3d\parser-inc

:: copy dist-info for pip
rem xcopy /I /E /Y %BUILT%\panda3d.dist-info          %PREFIX%\Lib\site-packages\panda3d.dist-info

python makepanda/makepanda.py ^
    --openssl-incdir %CONDA_PREFIX%\include ^
    --openssl-libdir %CONDA_PREFIX%\lib ^
    --bullet-incdir %CONDA_PREFIX%\include ^
    --bullet-libdir %CONDA_PREFIX%\lib ^
    --python-incdir %CONDA_PREFIX%\include ^
    --python-libdir %CONDA_PREFIX%\lib ^
    --zlib-incdir %CONDA_PREFIX%\include ^
    --zlib-libdir %CONDA_PREFIX%\lib ^
    --png-incdir %CONDA_PREFIX%\Library\include ^
    --png-libdir %CONDA_PREFIX%\Library\lib ^
    --msvc-version=14.3 ^
    --nothing ^
    --outputdir %BUILT% ^
    --threads=2 ^
    --use-bullet ^
    --use-contrib ^
    --use-deploytools ^
    --use-direct ^
    --use-egg ^
    --use-freetype ^
    --use-gl ^
    --use-harfbuzz ^
    --use-openal ^
    --use-openssl ^
    --use-pandafx ^
    --use-pandaparticlesystem ^
    --use-pandaphysics ^
    --use-pandatool ^
    --use-png ^
    --use-pview ^
    --use-python ^
    --use-skel ^
    --use-vorbis ^
    --use-x11 ^
    --use-zlib ^
    --verbose ^
    --windows-sdk=10

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

python makepanda/makewheel.py ^
    --outputdir %BUILT% ^
    --verbose

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

mkdir %PREFIX%\Library
xcopy /I /E /Y %BUILT%\bin                        %PREFIX%\Library\bin
xcopy /I /E /Y %BUILT%\etc                        %PREFIX%\Library\etc
xcopy /I /E /Y %BUILT%\lib                        %PREFIX%\Library\lib

mkdir %PREFIX%\Library\include
xcopy /I /E /Y %BUILT%\include                    %PREFIX%\Library\include\panda3d

mkdir %PREFIX%\Library\share
mkdir %PREFIX%\Library\share\panda3d
xcopy /I /E /Y %BUILT%\models                     %PREFIX%\Library\share\panda3d\models

mkdir %PREFIX%\Lib
mkdir %PREFIX%\Lib\site-packages
xcopy /I /E /Y %BUILT%\direct                     %PREFIX%\Lib\site-packages\direct
xcopy /I /E /Y %BUILT%\panda3d                    %PREFIX%\Lib\site-packages\panda3d
xcopy /I /E /Y %BUILT%\panda3d.dist-info          %PREFIX%\Lib\site-packages\panda3d.dist-info
xcopy /I /E /Y %BUILT%\pandac                     %PREFIX%\Lib\site-packages\pandac

del %PREFIX%\Library\bin\cg.dll
del %PREFIX%\Library\bin\cgGL.dll
del %PREFIX%\Library\bin\cgD3D9.dll
del %PREFIX%\Library\bin\cgD3D10.dll
del %PREFIX%\Library\bin\cgD3D11.dll
del %PREFIX%\Library\bin\*.pdb
del %PREFIX%\Library\lib\*.pdb
del %PREFIX%\Lib\site-packages\panda3d\*.pdb
