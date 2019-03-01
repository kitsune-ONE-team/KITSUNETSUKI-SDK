3rd party libraries for building blender-python
===============================================

* IlmBase - http://www.openexr.com/
* OpenEXR - http://www.openexr.com/
* Boost - https://www.boost.org/
* OpenImageIO - https://github.com/OpenImageIO/oiio


Building conda package
----------------------

```
git clone https://github.com/Yonnji/KITSUNETSUKI-SDK.git
cd conda/blender-thirdparty
conda build .
conda install blender-thirdparty --use-local
```


Installing prebuild conda package
---------------------------------

```
conda config --add channels kitsune.one
conda install blender-thirdparty
```
