call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat"
color 0f

cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%PREFIX%\Lib\site-packages" ^
    .

nmake
nmake install

del /F /S %PREFIX%\Lib\site-packages\kcc.lib
