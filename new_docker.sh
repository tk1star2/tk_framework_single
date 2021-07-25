#!/bin/bash
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
XFILE=/run/user/1000

TK_DATAPATH=/home/tkay/Desktop/DATA
TK_XAUTH=$XAUTHORITY
TK_DOWNLOAD=/home/tkay/Downloads
TK_USB=/media/tkay
TK_WORKSPACE=/home/tkay/Desktop/CONTAINER_WORKSPACE
DOCKER_HOME=/root

USER=tkay
CONTAINER_NAME=tk_ENV1

echo "TK XAUTH is " $TK_XAUTH
echo "TK DATAPATH is " $TK_DATAPATH

nvidia-docker run --privileged=true \
    --security-opt seccomp=tk_default.json \
	--cap-add=SYS_ADMIN \
	-d \
	-p 6006:6006 \
	-p 8888:8888 \
    -p 8080:8080 \
	-p 1000:22 \
	-p 45555:1001 \
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=$TK_AUTH \
	-e XDG_RUNTIME_DIR=$XFILE \
	--env="QT_X11_NO_MITSHM=1"\
	--net=host \
	--workdir=$DOCKER_HOME \
	--ipc=host \
	--shm-size=16g \
	-v $XFILE:$XFILE:rw \
	-v $XSOCK:$XSOCK:rw \
	-v $TK_XAUTH:$XAUTH:rw \
	-v $TK_DATAPATH:$DOCKER_HOME/DATASET:ro \
	-v $TK_DOWNLOAD:$DOCKER_HOME/DOWNLOAD:ro \
	-v $TK_USB:$DOCKER_HOME/usb:rw \
	-v $TK_WORKSPACE:$DOCKER_HOME/workspace:rw \
	--name $CONTAINER_NAME \
	-it nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04 bash

docker cp ./X11 $CONTAINER_NAME:$DOCKER_HOME
docker cp ~/.vimrc $CONTAINER_NAME:$DOCKER_HOME
docker cp ~/.vim $CONTAINER_NAME:$DOCKER_HOME
docker cp ~/.tmux.conf $CONTAINER_NAME:$DOCKER_HOME
docker cp ./environment.txt $CONTAINER_NAME:$DOCKER_HOME
sudo xhost +local:root
#sudo cp /home/tkay/.Xauthority /root/
#sudo xhost +local:root


