if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x64
    set WINLIBS=win64_vc15
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x86
    set WINLIBS=win64_vc15
)
color 0f

rem copy /V /Y %RECIPE_DIR%\export.h lib\%WINLIBS%\OpenImageIO\include\OpenImageIO

:: remove included python
rd /s /q lib\%WINLIBS%\python

mkdir lib\%WINLIBS%\python
mkdir lib\%WINLIBS%\python\39
mkdir lib\%WINLIBS%\python\39\bin
copy /V /Y %CONDA_PREFIX%\python39.dll lib\%WINLIBS%\python\39\bin
copy /V /Y %CONDA_PREFIX%\python3.dll lib\%WINLIBS%\python\39\bin

robocopy /E %RECIPE_DIR%\boost lib\%WINLIBS%\boost

if not exist blender\bld (
   cd blender
   mkdir bld
   patch -p1 -i %RECIPE_DIR%\platform.patch
   cd ..
)

cd blender

rem rd /s /q release\scripts\addons
rem rd /s /q release\scripts\addons_contrib
rem rd /s /q release\datafiles\locale
rem rd /s /q source\tools

robocopy /E ..\blender_extras\release\scripts\addons release\scripts\addons
robocopy /E ..\blender_extras\release\scripts\addons_contrib release\scripts\addons_contrib
robocopy /E ..\blender_extras\release\datafiles\locale release\datafiles\locale
robocopy /E ..\blender_extras\source\tools source\tools

cd bld
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%PREFIX%\Lib\site-packages ^
    -DPYTHON_INCLUDE_DIR=%CONDA_PREFIX%\include ^
    -DPYTHON_LIBRARY=%CONDA_PREFIX%\libs\python39.lib ^
    -DPYTHON_VERSION=3.9 ^
    -DWITH_AUDASPACE=OFF ^
    -DWITH_CODEC_FFMPEG=OFF ^
    -DWITH_CYCLES=OFF ^
    -DWITH_CYCLES_EMBREE=OFF ^
    -DWITH_DRACO=OFF ^
    -DWITH_FREESTYLE=OFF ^
    -DWITH_GLEW_ES=OFF ^
    -DWITH_GLEW_MX=OFF ^
    -DWITH_GLU=OFF ^
    -DWITH_HEADLESS=ON ^
    -DWITH_INSTALL_PORTABLE=OFF ^
    -DWITH_JACK=OFF ^
    -DWITH_LLVM=OFF ^
    -DWITH_MEM_JEMALLOC=OFF ^
    -DWITH_MOD_OCEANSIM=OFF ^
    -DWITH_OPENAL=OFF ^
    -DWITH_OPENCOLLADA=OFF ^
    -DWITH_OPENCOLORIO=OFF ^
    -DWITH_OPENIMAGEDENOISE=OFF ^
    -DWITH_OPENIMAGEIO=ON ^
    -DWITH_OPENMP=OFF ^
    -DWITH_OPENSUBDIV=ON ^
    -DWITH_PYTHON_INSTALL=OFF ^
    -DWITH_PYTHON_INSTALL_NUMPY=OFF ^
    -DWITH_PYTHON_MODULE=ON ^
    -DWITH_SDL=OFF ^
    -DWITH_STATIC_LIBS=OFF ^
    -DWITH_TBB=OFF ^
    ..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

nmake
nmake install

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

copy /V /Y bin\bpy.pyd %PREFIX%\Lib\site-packages
robocopy /E %PREFIX%\Lib\site-packages\%PKG_VERSION% %PREFIX%\%PKG_VERSION%
rd /s /q %PREFIX%\Lib\site-packages\%PKG_VERSION%

cd ..

copy /V /Y lib\%WINLIBS%\gmp\lib\*.dll %PREFIX%\DLLs
