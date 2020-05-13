![logo](icon.png)

Modified Panda3D Game Engine
============================

Panda3D: http://panda3d.org/

Conda package: https://anaconda.org/kitsune.ONE/panda3d


Building conda package
----------------------

```
git clone https://github.com/kitsune-ONE-team/KITSUNETSUKI-SDK.git
conda build conda/panda3d
conda install panda3d --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install panda3d-kitsunetsuki
```
