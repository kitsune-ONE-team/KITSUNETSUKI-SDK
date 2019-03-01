KITSUNETSUKI Game Runtime
=========================

https://www.patreon.com/kitsunetsuki


Building conda package
----------------------

```
git clone https://github.com/Yonnji/KITSUNETSUKI-SDK.git
cd conda/runtime
conda build .
conda install kitsunetsuki-runtime --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install kitsunetsuki-runtime
```
