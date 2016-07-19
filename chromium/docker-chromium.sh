#!/bin/bash

####
# Variables
####

DOCKER_IMAGE="rainu/chromium"

CUR_USER_ID=$(id -u)

HOST_PROFILE="$HOME/.docker/$DOCKER_IMAGE"

CHROMIUM_ARGS="--no-sandbox"
DOCKER_ARGS=""

DOCKER_NAME="chromium-$CUR_USER_ID"
read -r -d '' DOCKER_RUN_PARAMS <<EOF
--env LANG=$LANG
--env LANGUAGE=$LANGUAGE
--env DISPLAY=$DISPLAY
--env PULSE_SERVER="unix:/tmp/pulse-unix"
--volume /tmp/.X11-unix:/tmp/.X11-unix
--volume /run/user/$CUR_USER_ID/pulse/native:/tmp/pulse-unix
--volume /usr/share/icons:/usr/share/icons:ro
EOF

####
# Functions
####

execute() {
	SCRIPT=$(mktemp)

	echo $@ > $SCRIPT
	chmod +x $SCRIPT

	$SCRIPT
	RC=$?
	rm $SCRIPT

	return $RC
}

showHelp() {
echo 'Starts the Chromium docker container.

docker-chromium.sh [OPTIONS...]

Options:
	-h, -help
		Shows this help text
	-p, --persistent
		History and custom settings are stored in a host directory (volume)
	-D, --docker
		Additional argument to docker command
    -x, --xarg
		Argument(s) for the underlying Chromium
'
	exit 0
}

appendDevices() {
	declare -a DRI_DEVICES
	for d in `find /dev/dri -type c` ; do
	        DRI_DEVICES+=(--device "${d}")
	done
	for d in `find /dev/ -name "*video*" -type c`; do
	        DRI_DEVICES+=(--device "${d}")
	done

	DOCKER_ARGS="$DOCKER_ARGS ${DRI_DEVICES[@]}"
}

readArguments() {
	while [[ $# > 0 ]]; do
		key="$1"

		case $key in
		    -p|--persistent)
		    PERSISTENT="true"
		    DOCKER_NAME="$DOCKER_NAME-persistent"
		    ;;
		    -x|-xargs)
		    CHROMIUM_ARGS=$CHROMIUM_ARGS" $2"
		    shift
		    ;;
		    -D|--docker)
		    DOCKER_ARGS=$DOCKER_ARGS" $2"
		    shift
		    ;;
		    -h|--help)
		    showHelp
		    ;;
		    *)
			    # unknown option
		    ;;
		esac
		shift # past argument or value
	done
}

####
# Main
####

appendDevices
readArguments "$@"

if [ "$PERSISTENT" = "true" ]; then
	DOCKER_CONTAINER_EXISTS=$(docker ps -a | grep $DOCKER_NAME | wc -l)

	if [ "$DOCKER_CONTAINER_EXISTS" == "0" ]; then
		mkdir -p $HOST_PROFILE
		chmod 777 $HOST_PROFILE

		execute docker run \
		    --detach \
		    --name "$DOCKER_NAME" \
		    --volume $HOST_PROFILE:/home/browser/.chromium \
		    $DOCKER_RUN_PARAMS \
		    $DOCKER_ARGS \
		    $DOCKER_IMAGE \
		    $CHROMIUM_ARGS
	else
		execute docker start $DOCKER_NAME
	fi

	execute docker attach $DOCKER_NAME
	exit $?
fi

execute docker run --rm -i $DOCKER_RUN_PARAMS $DOCKER_ARGS $DOCKER_IMAGE $CHROMIUM_ARGS
