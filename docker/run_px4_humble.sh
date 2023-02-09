#!/bin/bash
sudo xhost +si:localuser:root

USER=ros2_dev
XSOCK=/tmp/.X11-unix

XAUTH=/tmp/.docker.xauth
xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
if [ ! -f $XAUTH ]
then
    echo XAUTH file does not exist. Creating one...
    touch $XAUTH
    chmod a+r $XAUTH
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    fi
fi

# Prevent executing "docker run" when xauth failed.
if [ ! -f $XAUTH ]
then
  echo "[$XAUTH] was not properly created. Exiting..."
  exit 1
fi

docker run --rm -it \
--env=LOCAL_USER_ID="$(id -u)" \
-v `pwd`/PX4-Autopilot:/home/$USER/dev_ws/PX4-Autopilot:rw \
-v `pwd`/ros2_ws:/home/$USER/dev_ws/ros2_ws:rw \
--env="XAUTHORITY=$XAUTH" \
--volume="$XAUTH:$XAUTH" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--env="QT_X11_NO_MITSHM=1" \
--env="DISPLAY=$DISPLAY" \
--network host \
--privileged \
--gpus all \
--name=px4-ros-humble px4_humble bash

sudo xhost -si:localuser:root
