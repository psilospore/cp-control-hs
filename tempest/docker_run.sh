DOCKER_IMAGE=tempest_in_action
IMAGE_VERSION=latest
CONTAINER_NAME=tempestpy

SRC_DIR=../../cp-control
CONTAINER_SRC_DIR=/opt/cp-control
LOGRESULTS_DIR=./logresults
CONTAINER_LOGRESULTS_DIR=/opt/logresults

sudo docker run \
--name "$CONTAINER_NAME" \
--mount "type=bind,src=$SRC_DIR,dst=$CONTAINER_SRC_DIR" \
--mount "type=bind,src=$LOGRESULTS_DIR,dst=$CONTAINER_LOGRESULTS_DIR" \
--rm \
-p "6006:6006" \
-p "8888:8888" \
--shm-size=4.86gb \
--entrypoint sh \
"$DOCKER_IMAGE:$IMAGE_VERSION" \
-c "./tempest/test.py"
