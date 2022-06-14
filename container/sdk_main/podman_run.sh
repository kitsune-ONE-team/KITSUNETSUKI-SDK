#!/bin/sh

podman run \
       --tty --interactive \
       --name sdk_main \
       --volume /home/${USERNAME}/Dev/kitsunetsuki:/home/${USERNAME}/Dev/kitsunetsuki:z \
       --volume /home/${USERNAME}/Dev/vtuber_webcam:/home/${USERNAME}/Dev/vtuber_webcam:z \
       --volume /home/${USERNAME}/Dev/yonnji:/home/${USERNAME}/Dev/yonnji:z \
       --volume /home/${USERNAME}/Dev/kdata:/home/${USERNAME}/Dev/kdata:z \
       --env HOME=/home/${USERNAME} \
       docker.io/yonnji/sdk:main \
       bash --init-file /etc/profile

podman rm sdk_main
