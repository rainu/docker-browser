#!/bin/bash

DOCKER_IMAGE="rainu/chromium"
CUR_USER_ID=$(id -u)
DOCKER_NAME="chromium-$CUR_USER_ID"

HOST_PROFILE="$HOME/.docker/$DOCKER_IMAGE"

read -r -d '' DOCKER_COMMON_RUN_PARAMS <<EOF
--env LANG=$LANG 
--env LANGUAGE=$LANGUAGE 
--env DISPLAY=$DISPLAY 
--env PULSE_SERVER="unix:/tmp/pulse-unix" 
--volume /tmp/.X11-unix:/tmp/.X11-unix 
--volume /run/user/$CUR_USER_ID/pulse/native:/tmp/pulse-unix 
EOF

execute()
{
        SCRIPT=$(mktemp)

        echo $@ > $SCRIPT
        chmod +x $SCRIPT

        $SCRIPT
        RC=$?
        rm $SCRIPT

        return $RC
}

if [ "$1" = "-p" ]; then
	DOCKER_NAME="chromium-$CUR_USER_ID-persistent"
	DOCKER_CONTAINER_EXISTS=$(docker ps -a | grep $DOCKER_NAME | wc -l)

	if [ "$DOCKER_CONTAINER_EXISTS" == "0" ]; then
		mkdir -p $HOST_PROFILE
		chmod 777 $HOST_PROFILE

		execute docker run \
		    --detach \
		    --name "$DOCKER_NAME" \
		    --volume $HOST_PROFILE:/home/browser/.chromium \
		    $DOCKER_COMMON_RUN_PARAMS \
		    $DOCKER_IMAGE
	else
		execute docker start $DOCKER_NAME
	fi

	execute docker attach $DOCKER_NAME
	exit $?
fi

execute docker run --rm -i $DOCKER_COMMON_RUN_PARAMS $DOCKER_IMAGE
