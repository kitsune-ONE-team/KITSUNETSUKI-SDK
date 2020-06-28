KITSUNETSUKI SDK
================

KITSUNETSUKI SDK is a game development environment for the KITSUNETSUKI project.

KITSUNETSUKI project is a multiplayer-focused arena
third-person shooter (TPS) game in anime style.

KITSUNETSUKI project: https://www.patreon.com/kitsunetsuki


What's Inside
-------------

* ![logo](conda/bullet/icon_32.png) [Bullet Physics SDK](conda/bullet) (prebuilt with headers included)
* ![logo](conda/panda3d/icon_32.png) [Modified Panda3D Game Engine](conda/panda3d) (prebuilt with headers included)
* ![logo](conda/panda3d/icon_32.png) [RenderPipeline](https://github.com/kitsune-ONE-team/RenderPipeline)
* ![logo](conda/kcc/icon_32.png) [KITSUNETSUKI Character Controller](conda/kcc)
* ![logo](conda/kcc/icon_32.png) [KITSUNETSUKI Asset Tools](https://github.com/kitsune-ONE-team/KITSUNETSUKI-Asset-Tools)
* ![logo](conda/blender/blender_icon_32x32.png) [Blender](conda/blender) (as a Python module)
* ![logo](conda/blender/blender_icon_32x32.png) [Blender 3rd party libraries](conda/blender-thirdparty) for building blender-python

Files and directories structure
-------------------------------

* [conda](conda) - conda package recipes for anaconda/miniconda
* [README.md](README.md) - this file
* [ksdk.yml](ksdk.yml) - conda environment file
* [jenkins.win.bat](jenkins.win.bat) - Jenkins job building script (Windows)
* [jenkins.lyn.sh](jenkins.lyn.sh) - Jenkins job building script (Linux)
* [jenkins.pipeline](jenkins.pipeline) - Jenkins Pipeline file for building multiple jobs


SDK Requirements
----------------

You have to install those software packages to use the prebuild SDK.

* Anaconda3 or Miniconda3 (version 4.8+, Python 3.8) - https://conda.io/en/latest/miniconda.html


Installing
----------

```
conda env create kitsune.one/ksdk
```


Updating
--------

```
conda env update -n ksdk kitsune.one/ksdk
```


Using
-----

```
conda activate ksdk
```


Uninstalling
------------

```
conda env remove -n ksdk
```


Building Requirements (Windows)
-------------------------------

You have to install those software packages if you want to modify and build your own SDK.

* Visual Studio Build Tools 2017


Building Requirements (Linux)
-----------------------------

You have to install those software packages if you want to modify and build your own SDK.

* Ubuntu 16.04
* Glu
* Mesa
* Ogg
* OpenAL
* Vorbis
* Xv


Automated building environment
------------------------------

You can use [Jenkins](https://www.jenkins.io/)
to automatically build conda packages and upload them to the anaconda cloud.

You can use included jenkins scripts as templates for your jenkins jobs.
