![logo](icon.png)

Bullet Physics SDK
==================

http://bulletphysics.org


Building conda package
----------------------

```
git clone https://github.com/Yonnji/KITSUNETSUKI-SDK.git
cd conda/bullet
conda build .
conda install bullet --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install bullet
```
