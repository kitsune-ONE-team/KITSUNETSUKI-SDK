if "%ARCH%" == "64" (
    call %VSBT_PATH% x64 %WINDOWS_SDK_VERSION%
    set THIRDPARTY=lib\win64_vc15
) else (
    call %VSBT_PATH% x86 %WINDOWS_SDK_VERSION%
    set THIRDPARTY=lib\win64_vc15
)
set PYTHON_VERSION=3.10
set PYTHONVERSION=310

color 0f

:: remove included python
if exist %THIRDPARTY%\python (
    rd /s /q %THIRDPARTY%\python
)

mkdir %THIRDPARTY%\python
mkdir %THIRDPARTY%\python\%PYTHONVERSION%
mkdir %THIRDPARTY%\python\%PYTHONVERSION%\bin
copy /V /Y %CONDA_PREFIX%\python%PYTHONVERSION%.dll %THIRDPARTY%\python\%PYTHONVERSION%\bin
copy /V /Y %CONDA_PREFIX%\python3.dll               %THIRDPARTY%\python\%PYTHONVERSION%\bin

robocopy /E %RECIPE_DIR%\boost %THIRDPARTY%\boost

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
    -DWITH_DRACO=ON ^
    -DWITH_FREESTYLE=ON ^
    -DWITH_HEADLESS=ON ^
    -DWITH_INSTALL_PORTABLE=OFF ^
    -DWITH_JACK=ON ^
    -DWITH_LLVM=OFF ^
    -DWITH_MEM_JEMALLOC=ON ^
    -DWITH_MOD_OCEANSIM=ON ^
    -DWITH_OPENAL=ON ^
    -DWITH_OPENCOLLADA=ON ^
    -DWITH_OPENCOLORIO=ON ^
    -DWITH_OPENIMAGEDENOISE=ON ^
    -DWITH_OPENIMAGEIO=ON ^
    -DWITH_OPENMP=ON ^
    -DWITH_OPENSUBDIV=ON ^
    -DWITH_PYTHON_INSTALL=OFF ^
    -DWITH_PYTHON_INSTALL_NUMPY=OFF ^
    -DWITH_PYTHON_MODULE=ON ^
    -DWITH_SDL=ON ^
    -DWITH_TBB=ON ^
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

copy /V /Y %THIRDPARTY%\MaterialX\bin\*.dll   %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\OpenImageIO\bin\*.dll %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\boost\lib\*.dll       %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\dpcpp\bin\*.dll       %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\ffmpeg\lib\*.dll      %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\imath\bin\*.dll       %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\level-zero\bin\*.dll  %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\opencolorio\bin\*.dll %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\openexr\bin\*.dll     %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\openvdb\bin\*.dll     %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\tbb\bin\*.dll         %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\embree\bin\*.dll      %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\openal\lib\*.dll      %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\sdl\lib\*.dll         %PREFIX%\Library\bin
copy /V /Y %THIRDPARTY%\fftw3\lib\*.dll       %PREFIX%\Library\bin
