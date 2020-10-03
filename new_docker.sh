#!/bin/bash
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
XFILE=/run/user/1000

TK_DATAPATH=/home/tk1star2/Desktop/DATA
TK_XAUTH=$XAUTHORITY
TK_DOWNLOAD=/home/tk1star2/Downloads
TK_USB=/media/tk1star2
TK_WORKSPACE=/home/tk1star2/Desktop/CONTAINER_WORKSPACE
DOCKER_HOME=/root/

USER=tkay
CONTAINER_NAME=tk_ENV1

echo "TK XAUTH is " $TK_XAUTH
echo "TK DATAPATH is " $TK_DATAPATH

nvidia-docker run --privileged=true \
	-d \
	-p 6006:6006 \
	-p 8888:8888\
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=$TK_AUTH \
	-e XDG_RUNTIME_DIR=$XFILE \
	--env="QT_X11_NO_MITSHM=1"\
	--net=host \
	--workdir=$DOCKER_HOME \
	--ipc=host \
	--shm-size=16g \
	-v $XSOCK:$XSOCK:rw \
	-v $TK_XAUTH:$XAUTH:rw \
	-v $TK_DATAPATH:$DOCKER_HOME/DATASET:ro \
	-v $TK_DOWNLOAD:$DOCKER_HOME/DOWNLOAD:ro \
	-v $TK_USB:$DOCKER_HOME/usb:rw \
	-v $TK_WORKSPACE:$DOCKER_HOME/workspace:rw \
	--name $CONTAINER_NAME \
	-it nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 bash

docker cp ./X11 $CONTAINER_NAME:$DOCKER_HOME
docker cp ~/.vimrc $CONTAINER_NAME:$DOCKER_HOME
docker cp ~/.vim $CONTAINER_NAME:$DOCKER_HOME
docker cp ~/.tmux.conf $CONTAINER_NAME:$DOCKER_HOME
docker cp ./environment.txt $CONTAINER_NAME:$DOCKER_HOME
sudo xhost +local:root
#sudo cp /home/tk1star2/.Xauthority /root/
#sudo xhost +local:root


