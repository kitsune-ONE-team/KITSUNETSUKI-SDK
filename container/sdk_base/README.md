KITSUNETSUKI base SDK image
===========================

KITSUNETSUKI SDK container image.


Building image
--------------

You can skip it if you want to use prebuilt images.

```
podman build -f Dockerfile
```

or

```
docker build -f Dockerfile
```


Downloading prebuilt image
--------------------------

```
podman pull docker.io/yonnji/sdk:base
```

or

```
docker pull docker.io/yonnji/sdk:base
```


Running with toolbox
----------------------

You will need [https://github.com/containers/toolbox](toolbox) for it.


Create a toolbox using container image (toolbox name would be "sdk_base"):

```
toolbox create -i docker.io/yonnji/sdk:base
```


Enter the toolbox:

```
toolbox enter sdk_base
```


Create a new conda environment:

```
conda env create kitsune.one/sdk
```


Running with podman-compose
------------------------

You will need [https://github.com/containers/podman-compose](podman-compose) for it.


Create and run container:

```
podman-compose run sdk
```


Create a new conda environment:

```
conda env create kitsune.one/sdk
```
