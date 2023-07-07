if "%ARCH%" == "64" (
    call %VSBT_PATH% x64 %WINDOWS_SDK_VERSION%
    set THIRDPARTY=win64_vc15
) else (
    call %VSBT_PATH% x86 %WINDOWS_SDK_VERSION%
    set THIRDPARTY=win64_vc15
)
set PYTHON_VERSION=3.10
set PYTHONVERSION=310

color 0f

:: remove included python
if exist lib\%THIRDPARTY%\python (
    rd /s /q lib\%THIRDPARTY%\python
)

mkdir lib\%THIRDPARTY%\python
mkdir lib\%THIRDPARTY%\python\%PYTHONVERSION%
mkdir lib\%THIRDPARTY%\python\%PYTHONVERSION%\bin
copy /V /Y %CONDA_PREFIX%\python%PYTHONVERSION%.dll lib\%THIRDPARTY%\python\%PYTHONVERSION%\bin
copy /V /Y %CONDA_PREFIX%\python3.dll               lib\%THIRDPARTY%\python\%PYTHONVERSION%\bin

robocopy /E %RECIPE_DIR%\boost lib\%THIRDPARTY%\boost

if not exist blender\bld (
    mkdir blender\bld

    cd blender
    patch -p1 -i %RECIPE_DIR%\platform.patch
    cd ..
)

cd blender\bld
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%PREFIX%\Lib\site-packages ^
    -DPYTHON_LIBRARY=%CONDA_PREFIX%\libs\python%PYTHONVERSION%.lib ^
    -DPYTHON_INCLUDE_DIR=%CONDA_PREFIX%\include ^
    -DPYTHON_NUMPY_INCLUDE_DIRS=%CONDA_PREFIX%\Lib\site-packages\numpy\core\include ^
    -DPYTHON_VERSION=%PYTHON_VERSION% ^
    -DTEST_PYTHON_EXE=%CONDA_PREFIX%\python.exe ^
    -DWITH_AUDASPACE=ON ^
    -DWITH_CODEC_AVI=ON ^
    -DWITH_CODEC_FFMPEG=ON ^
    -DWITH_CODEC_SNDFILE=ON ^
    -DWITH_CYCLES=ON ^
    -DWITH_CYCLES_EMBREE=ON ^
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
    -DWITH_OPENIMAGEDENOISE=ON ^
    -DWITH_OPENIMAGEIO=OFF ^
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

cd ..\..

robocopy /E %PREFIX%\Lib\site-packages\blender.crt %PREFIX%\Lib\site-packages\bpy\blender.crt
rd /s /q %PREFIX%\Lib\site-packages\blender.crt
