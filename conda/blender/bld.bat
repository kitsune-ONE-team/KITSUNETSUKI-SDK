if "%ARCH%" == "64" (
    rem call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64
    set CMAKETARGET="NMake Makefiles"
    set WINLIBS=win64_vc15
) else (
    rem call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x86
    set CMAKETARGET="NMake Makefiles"
    set WINLIBS=win64_vc15
)
color 0f

if not exist lib\win64_vc14 (
mkdir lib
cd lib
D:\Apps\Subversion\bin\svn co ^
    https://svn.blender.org/svnroot/bf-blender/trunk/lib/win64_vc15 ^
    win64_vc14
cd ..
)

:: remove included python
rd /s /q %WINLIBS%\python

:: remove included zlib
rd /s /q %WINLIBS%\zlib

mkdir blender\bld
cd blender\bld
cmake -G %CMAKETARGET% ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -DCMAKE_INSTALL_PREFIX=%PREFIX%\Lib\site-packages ^
    -DPYTHON_INCLUDE_DIR=%CONDA_PREFIX%\include ^
    -DPYTHON_LIBRARY=%CONDA_PREFIX%\libs\python38.lib ^
    -DPYTHON_VERSION=3.8 ^
    -DWITH_AUDASPACE=OFF ^
    -DWITH_CYCLES=ON ^
    -DWITH_DRACO=OFF ^
    -DWITH_GLEW_ES=OFF ^
    -DWITH_GLEW_MX=OFF ^
    -DWITH_GLU=OFF ^
    -DWITH_INSTALL_PORTABLE=OFF ^
    -DWITH_JACK=OFF ^
    -DWITH_LLVM=OFF ^
    -DWITH_MOD_OCEANSIM=OFF ^
    -DWITH_OPENAL=OFF ^
    -DWITH_OPENCOLLADA=OFF ^
    -DWITH_OPENCOLORIO=OFF ^
    -DWITH_OPENIMAGEDENOISE=OFF ^
    -DWITH_OPENMP=OFF ^
    -DWITH_OPENSUBDIV=OFF ^
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
xcopy /I /E /Y %PREFIX%\Lib\site-packages\%PKG_VERSION% %PREFIX%\%PKG_VERSION%
rd /s /q %PREFIX%\Lib\site-packages\%PKG_VERSION%
