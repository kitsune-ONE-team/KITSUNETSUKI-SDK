if "%ARCH%" == "64" (
    call %VSBT_PATH% x64 %WINDOWS_SDK_VERSION%
) else (
    call %VSBT_PATH% x86 %WINDOWS_SDK_VERSION%
)
color 0f

if not exist bld (
   mkdir bld
)

cd bld
cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%\Lib\site-packages" ^
    -DINSTALL_PY=ON ^
    ..

nmake
nmake install

cd ..

del /F /S %PREFIX%\Lib\site-packages\kphys\core.lib
