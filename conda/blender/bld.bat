if "%ARCH%" == "64" (
    rem call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64
    set CMAKETARGET="NMake Makefiles"
    set WINLIBS=lib\win64_vc14
) else (
    rem call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
    call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x86
    set CMAKETARGET="NMake Makefiles"
    set WINLIBS=lib\windows_vc14
)
color 0f

:: remove included python
rd /s /q %WINLIBS%\python

mkdir blender\bld
cd blender\bld
cmake -G %CMAKETARGET% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%PREFIX:\=^/%/Lib/site-packages ^
    -DMSVC_VERSION=1910 ^
    -DPYTHON_INCLUDE_DIR=%CONDA_PREFIX:\=^/%/include ^
    -DPYTHON_LIBRARY=%CONDA_PREFIX:\=^/%/libs/python37.lib ^
    -DPYTHON_VERSION=3.7 ^
    -DWITH_AUDASPACE=OFF ^
    -DWITH_CYCLES=ON ^
    -DWITH_GLEW_ES=OFF ^
    -DWITH_GLEW_MX=OFF ^
    -DWITH_GLU=OFF ^
    -DWITH_INSTALL_PORTABLE=OFF ^
    -DWITH_LLVM=OFF ^
    -DWITH_OPENCOLLADA=OFF ^
    -DWITH_OPENCOLORIO=OFF ^
    -DWITH_OPENIMAGEDENOISE=OFF ^
    -DWITH_OPENSUBDIV=OFF ^
    -DWITH_PYTHON_INSTALL=OFF ^
    -DWITH_PYTHON_INSTALL_NUMPY=OFF ^
    -DWITH_PYTHON_MODULE=ON ^
    -DWITH_STATIC_LIBS=OFF ^
    -DWITH_TBB=OFF ^
    -DWITH_SDL=OFF ^
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
