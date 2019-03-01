if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
)
color 0f

set THIRDPARTY=%PREFIX%\blender-thirdparty

python %RECIPE_DIR%\boost.py
if "%ARCH%" == "64" (
   %HOME%\boost_1_65_1-msvc-14.1-64.exe /DIR=%THIRDPARTY%\boost /SILENT
) else (
   %HOME%\boost_1_65_1-msvc-14.1-32.exe /DIR=%THIRDPARTY%\boost /SILENT
)

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

cd ilmbase
cmake -G "NMake Makefiles" ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    .
nmake
nmake install
cd ..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

cd openexr
cmake -G "NMake Makefiles" ^
    -DILMBASE_PACKAGE_PREFIX=%THIRDPARTY% ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    .
nmake
nmake install
cd ..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

mkdir oiio\bld
cd oiio\bld
cmake -G "NMake Makefiles" ^
    -DBUILDSTATIC=1 ^
    -DBOOST_CUSTOM=1 ^
    -DBoost_VERSION=1.65.1 ^
    -DBoost_INCLUDE_DIRS=%THIRDPARTY%\boost ^
    -DBoost_LIBRARY_DIRS=%THIRDPARTY%\boost\lib%ARCH%-msvc-14.1 ^
    -DILMBASE_HOME=%THIRDPARTY% ^
    -DOPENEXR_HOME=%THIRDPARTY% ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    -DUSE_FFMPEG=OFF ^
    -DUSE_PYTHON=OFF ^
    -DOIIO_BUILD_TESTS=OFF ^
    ..
nmake
nmake install
cd ..\..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)
