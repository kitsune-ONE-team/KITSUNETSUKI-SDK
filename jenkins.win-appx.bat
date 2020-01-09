rem d:\Apps\Miniconda3_x64\Scripts\conda env remove --yes --prefix env
rem d:\Apps\Miniconda3_x64\Scripts\conda create --yes --prefix env
rem d:\Apps\Miniconda3_x64\Scripts\activate ./env

call "D:\Apps\Miniconda3_x64\Scripts\activate" base

python appx.py

call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64

makepri createconfig /v /o /cf kitsunetsuki\priconfig.xml /dq en-US

makepri new /v /o /cf kitsunetsuki\priconfig.xml ^
    /pr kitsunetsuki ^
    /mn kitsunetsuki/appxmanifest.xml ^
    /mf appx

makeappx pack /v /o /p kitsunetsuki.msix ^
    /d kitsunetsuki ^
    /m kitsunetsuki/appxmanifest.xml ^
    /f appx
