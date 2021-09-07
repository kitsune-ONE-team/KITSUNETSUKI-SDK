if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x64 %WINDOWS_SDK_VERSION%
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" x86 %WINDOWS_SDK_VERSION%
)
color 0f

if not exist bld (
   mkdir bld
)

cd bld
cmake -G "NMake Makefiles" ^
    -DBUILD_BULLET2_DEMOS=OFF ^
    -DBUILD_CPU_DEMOS=OFF ^
    -DBUILD_EGL=OFF ^
    -DBUILD_EXTRAS=ON ^
    -DBUILD_MULTITHREADING=ON ^
    -DBUILD_OPENGL3_DEMOS=OFF ^
    -DBUILD_PYBULLET=OFF ^
    -DBUILD_PYBULLET_NUMPY=OFF ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DBUILD_UNIT_TESTS=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%\Library" ^
    -DINSTALL_LIBS=ON ^
    -DUSE_DOUBLE_PRECISION=OFF ^
    -DUSE_GLUT=OFF ^
    -DUSE_GRAPHICAL_BENCHMARK=OFF ^
    -DUSE_MSVC_RUNTIME_LIBRARY_DLL=ON ^
    ..

nmake
nmake install

cd ..
