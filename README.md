KITSUNETSUKI SDK
================

KITSUNETSUKI SDK is a game development environment for the KITSUNETSUKI project.

KITSUNETSUKI project is a multiplayer-focused arena
third-person shooter (TPS) game in anime style.

KITSUNETSUKI project: https://k.kitsune.one/


Running SDK container
---------------------

Start container:
```
cd container
podman-compose up -d
```

Build or rebuild, and then start container:
```
cd container
podman-compose up -d --build
```


Jenkins jobs
------------

You need SDK container already running.

Create a config file in *~/.config/jenkins_jobs/jenkins_jobs.ini*:
```
[jenkins]
user=your_username_in_jenkins
password=your_api_token_in_jenkins
url=http://localhost:8080
timeout=30
```

Install or update jobs:
```
cd container
podman-compose exec sdk bash
~/jenkins-jobs/update.sh
```
