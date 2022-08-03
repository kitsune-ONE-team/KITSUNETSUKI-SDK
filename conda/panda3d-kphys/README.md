![logo](icon.png)

Physics extensions for Panda3D
==============================

Physics extensions for Panda3D originally made for the KITSUNETSUKI project game.

KITSUNETSUKI project: https://k.kitsune.one/

Conda package: https://anaconda.org/kitsune.ONE/panda3d-kphys


Building conda package
----------------------

```
git clone https://github.com/kitsune-ONE-team/KITSUNETSUKI-SDK.git
conda build conda/panda3d-kphys
conda install panda3d-kphys --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install panda3d-kphys
```
