if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
)
color 0f

set THIRDPARTY=%PREFIX%\blender-thirdparty
rem set BOOST=%THIRDPARTY%\boost
set BOOST=D:\boost

if not exist %BOOST% (
    if "%ARCH%" == "64" (
       call boost_1_70_0-unsupported-msvc-14.2-64.exe /DIR=%BOOST% /SILENT /LOG="boost.log"
    ) else (
       call boost_1_70_0-unsupported-msvc-14.2-32.exe /DIR=%BOOST% /SILENT /LOG="boost.log"
    )
)

mkdir %THIRDPARTY%
mkdir %THIRDPARTY%\boost
xcopy /I /E /Y %BOOST%\boost %THIRDPARTY%\boost\boost
xcopy /I /E /Y %BOOST%\lib%ARCH%-msvc-14.2 %THIRDPARTY%\boost\lib%ARCH%-msvc-14.2

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

cd openexr
cmake -G "NMake Makefiles" ^
    -DOPENEXR_BUILD_PYTHON_LIBS=NO ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    -DBoost_INCLUDE_DIR=%BOOST% ^
    -DBoost_INCLUDE_DIRS=%BOOST% ^
    -DBoost_LIBRARY_DIRS=%BOOST%\lib%ARCH%-msvc-14.2 ^
    -DBoost_VERSION=1.70.0 ^
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
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    -DBOOST_CUSTOM=1 ^
    -DBUILDSTATIC=1 ^
    -DBoost_INCLUDE_DIR=%BOOST% ^
    -DBoost_INCLUDE_DIRS=%BOOST% ^
    -DBoost_LIBRARY_DIRS=%BOOST%\lib%ARCH%-msvc-14.2 ^
    -DBoost_VERSION=1.70.0 ^
    -DILMBASE_HOME=%THIRDPARTY% ^
    -DJPEG_ROOT=%CONDA_PREFIX%\Library ^
    -DOIIO_BUILD_TESTS=OFF ^
    -DOPENEXR_HOME=%THIRDPARTY% ^
    -DOpenEXR_ROOT=%THIRDPARTY% ^
    -DPNG_ROOT=%CONDA_PREFIX%\Library ^
    -DUSE_FFMPEG=OFF ^
    -DUSE_PYTHON=OFF ^
    ..
nmake
nmake install
cd ..\..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

mkdir clew\bld
cd clew\bld
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    -DBUILD_TESTS=OFF ^
    -DBUILD_SHARED_LIBRARY=OFF ^
    ..
make
make install
cd ..\..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)

mkdir OpenSubdiv\bld
cd OpenSubdiv\bld
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%THIRDPARTY% ^
    -DNO_CLEW=1 ^
    -DNO_CUDA=1 ^
    -DNO_DOC=1 ^
    -DNO_EXAMPLES=1 ^
    -DNO_OMP=1 ^
    -DNO_OPENCL=1 ^
    -DNO_OPENGL=1 ^
    -DNO_PTEX=1 ^
    -DNO_TBB=1 ^
    -DNO_TUTORIALS=1 ^
    ..
nmake
nmake install
cd ..\..

if "%ERRORLEVEL%" == "1" (
    exit /B 1
)
