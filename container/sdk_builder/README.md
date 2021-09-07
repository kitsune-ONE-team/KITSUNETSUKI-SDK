KITSUNETSUKI SDK builder image
==============================


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
podman pull docker.io/yonnji/sdk:builder
```

or

```
docker pull docker.io/yonnji/sdk:builder
```


Running image
-------------

You will need [https://github.com/containers/podman-compose](podman-compose) for podman
or [https://docs.docker.com/compose/](docker-compose) for docker.

```
podman-compose up -d
```

or

```
docker-compose up -d
```


Initial image setup
-------------------

Install Jenkins at http://localhost:8080

Go the Jenkins user settings and create new API token.

Create jenkins_jobs/jenkins_jobs.ini file (copy from jenkins_jobs/jenkins_jobs.ini.example)
and fill the Jenkins username and API token.

Enter the container:

```
docker exec -it sdk_builder_jenkins_1 bash
```

or

```
podman exec -it sdk_builder_jenkins_1 bash
```

Activate conda (inside the container):

```
source /etc/profile
conda activate
```

Login into Anaconda Cloud (inside the container):

```
anaconda login
```

Upload jobs into Jenkins (inside the container):

```
jenkins-jobs update ~/.config/jenkins_jobs/jobs.yml
```


Stopping image
--------------

```
podman-compose up -d
```

or

```
docker-compose up -d
```
