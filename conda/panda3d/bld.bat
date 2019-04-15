if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    set BUILT=%SRC_DIR%\built_x64
    set WINLIBS=thirdparty\win-libs-vc14-x64
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
    set BUILT=%SRC_DIR%\built
    set WINLIBS=thirdparty\win-libs-vc14
)
color 0f

:: remove included bullet
rmdir /S /Q %WINLIBS%\bullet

:: remove included openssl
rmdir /S /Q %WINLIBS%\openssl

python makepanda/makepanda.py ^
    --nothing ^
    --use-bullet ^
    --use-contrib ^
    --use-deploytools ^
    --use-direct ^
    --use-egg ^
    --use-freetype ^
    --use-gl ^
    --use-nvidiacg ^
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
    --threads=2 ^
    --verbose ^
    --msvc-version=14.1 ^
    --windows-sdk=10 ^
    --python-incdir %CONDA_PREFIX%\include ^
    --python-libdir %CONDA_PREFIX%\lib ^
    --bullet-incdir %CONDA_PREFIX%\include ^
    --bullet-libdir %CONDA_PREFIX%\lib ^
    --openssl-incdir %CONDA_PREFIX%\include ^
    --openssl-libdir %CONDA_PREFIX%\lib

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

mkdir %PREFIX%\Library
xcopy /I /E /Y %BUILT%\bin %PREFIX%\Library\bin
xcopy /I /E /Y %BUILT%\etc %PREFIX%\Library\etc
xcopy /I /E /Y %BUILT%\lib %PREFIX%\Library\lib

mkdir %PREFIX%\Library\include
xcopy /I /E /Y %BUILT%\include %PREFIX%\Library\include\panda3d

mkdir %PREFIX%\Library\share
mkdir %PREFIX%\Library\share\panda3d
xcopy /I /E /Y %BUILT%\models %PREFIX%\Library\share\panda3d\models

mkdir %PREFIX%\Lib
mkdir %PREFIX%\Lib\site-packages
xcopy /I /E /Y %BUILT%\direct %PREFIX%\Lib\site-packages\direct
xcopy /I /E /Y %BUILT%\panda3d %PREFIX%\Lib\site-packages\panda3d
xcopy /I /E /Y %BUILT%\pandac %PREFIX%\Lib\site-packages\pandac
