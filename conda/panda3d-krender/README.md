![logo](icon.png)

Custom Deferred Render Pipeline for Panda3D
==============================

Deferred Render Pipeline for the Panda3D game engine
originally made for the KITSUNETSUKI project game.

KITSUNETSUKI project: https://k.kitsune.one/

Conda package: https://anaconda.org/kitsune.ONE/panda3d-krender


Building conda package
----------------------

```
git clone https://github.com/kitsune-ONE-team/KITSUNETSUKI-SDK.git
conda build conda/panda3d-krender
conda install panda3d-krender --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install panda3d-krender
```
