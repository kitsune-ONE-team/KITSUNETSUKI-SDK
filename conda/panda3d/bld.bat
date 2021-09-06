if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x64
    set THIRDPARTY=thirdparty\win-libs-vc14-x64
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x86
    set THIRDPARTY=thirdparty\win-libs-vc14
)
color 0f

:: remove included libs
rmdir /S /Q %THIRDPARTY%\bullet
rmdir /S /Q %THIRDPARTY%\openssl

set BUILT=built

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
