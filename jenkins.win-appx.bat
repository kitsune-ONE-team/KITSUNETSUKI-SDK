rem d:\Apps\Miniconda3_x64\Scripts\conda env remove --yes --prefix env
rem d:\Apps\Miniconda3_x64\Scripts\conda create --yes --prefix env
rem d:\Apps\Miniconda3_x64\Scripts\activate ./env

call "D:\Apps\Miniconda3_x64\Scripts\activate" base
python appx.py

call "D:\Apps\Visual Studio\IDE\VC\Auxiliary\Build\vcvarsall.bat" x64
makepri new /v /pr kitsunetsuki /cf kitsunetsuki\priconfig.xml
makeappx pack /v /o /d kitsunetsuki /p kitsunetsuki.msix
