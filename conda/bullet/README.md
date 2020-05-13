![logo](icon.png)

Bullet Physics SDK
==================

Bullet Physics SDK: http://bulletphysics.org
Conda package: https://anaconda.org/kitsune.ONE/bullet


Building conda package
----------------------

```
git clone https://github.com/kitsune-ONE-team/KITSUNETSUKI-SDK.git
conda build conda/bullet
conda install bullet --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install bullet
```
