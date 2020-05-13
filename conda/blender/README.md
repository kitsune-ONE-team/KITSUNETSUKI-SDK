![logo](blender_icon_128x128.png)

Blender as Python module
========================

Blender: https://docs.blender.org/api/
Conda package: https://anaconda.org/kitsune.ONE/blender


Building conda package
----------------------

```
git clone https://github.com/kitsune-ONE-team/KITSUNETSUKI-SDK.git
conda build conda/blender
conda install python-blender --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install python-blender
```
