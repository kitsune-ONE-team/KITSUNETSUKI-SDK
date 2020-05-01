if "%ARCH%" == "64" (
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64
    set WINLIBS=thirdparty\win-libs-vc14-x64
) else (
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x86
    set WINLIBS=thirdparty\win-libs-vc14
)
color 0f

:: remove included bullet
rmdir /S /Q %WINLIBS%\bullet

:: remove included openssl
rmdir /S /Q %WINLIBS%\openssl

set BUILT=%RECIPE_DIR%\built

python makepanda/makepanda.py ^
    --bullet-incdir %CONDA_PREFIX%\include ^
    --bullet-libdir %CONDA_PREFIX%\lib ^
    --openssl-incdir %CONDA_PREFIX%\include ^
    --openssl-libdir %CONDA_PREFIX%\lib ^
    --png-incdir %CONDA_PREFIX%\include ^
    --png-libdir %CONDA_PREFIX%\lib ^
    --python-incdir %CONDA_PREFIX%\include ^
    --python-libdir %CONDA_PREFIX%\lib ^
    --vorbis-incdir %CONDA_PREFIX%\include ^
    --vorbis-libdir %CONDA_PREFIX%\lib ^
    --zlib-incdir %CONDA_PREFIX%\include ^
    --zlib-libdir %CONDA_PREFIX%\lib ^
    --msvc-version=14.1 ^
    --nothing ^
    --threads=2 ^
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
    --verbose ^
    --windows-sdk=10 ^
    --outputdir %BUILT%

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

python makepanda/makewheel.py ^
    --verbose ^
    --outputdir %BUILT%

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
xcopy /I /E /Y %BUILT%\panda3d.dist-info %PREFIX%\Lib\site-packages\panda3d.dist-info
xcopy /I /E /Y %BUILT%\pandac %PREFIX%\Lib\site-packages\pandac
