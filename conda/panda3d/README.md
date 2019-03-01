![logo](icon.png)

Panda3D Game Engine
===================

http://panda3d.org/


Building conda package
----------------------

```
git clone https://github.com/Yonnji/KITSUNETSUKI-SDK.git
cd conda/panda3d
conda build .
conda install panda3d-kitsunetsuki --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install panda3d-kitsunetsuki
```
