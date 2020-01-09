call "D:\Apps\Miniconda3_x64\Scripts\activate" base

python appx.py

call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64

makepri createconfig /v /o /cf priconfig.xml /dq en-US

makepri new /v /o /of resources.pri ^
    /cf priconfig.xml ^
    /pr kitsunetsuki ^
    /mn appxmanifest.xml ^
    /in appxmanifest.xml ^
    /mf appx

makeappx pack /v /o /p kitsunetsuki.msix ^
    /m kitsunetsuki\appxmanifest.xml ^
    /f resources.map.txt
