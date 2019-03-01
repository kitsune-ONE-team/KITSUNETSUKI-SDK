if "%ARCH%" == "64" (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
) else (
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
)
color 0f

cmake -G "NMake Makefiles" ^
    -DBUILD_BULLET2_DEMOS=OFF ^
    -DBUILD_BULLET3=OFF ^
    -DBUILD_CPU_DEMOS=OFF ^
    -DBUILD_DEMOS=OFF ^
    -DBUILD_EXTRAS=OFF ^
    -DBUILD_MULTITHREADING=OFF ^
    -DBUILD_OPENGL3_DEMOS=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%\Library" ^
    -DINSTALL_LIBS=ON ^
    -DUSE_MSVC_RUNTIME_LIBRARY_DLL=ON

nmake
nmake install
