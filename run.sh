#!/bin/bash

while getopts 'p:c:n:w:' flag; do
	case "${flag}" in
		p) PLUGIN_PATH=${OPTARG} ;;
		c) COMMAND=${OPTARG} ;;
		n) INCLUDE_NODE_MODULES=${OPTARG} ;;
		w) WORKDIR=${OPTARG} ;;
	esac
done

CWD=$(pwd)

WORKDIR='/usr/src/plugsier/plugsier-scripts/'
	
# Define the volumes to mount
PLUGSIER_SCRIPTS_VOLUME="$CWD""/plugsier-scripts:/usr/src/plugsier/plugsier-scripts"
PLUGIN_VOLUME="$PLUGIN_PATH:/usr/src/plugsier/plugin"

# Build the string of volumes we want for this container.
VOLUME_STRING="-v $PLUGSIER_SCRIPTS_VOLUME -v $PLUGIN_VOLUME"
		
if [ "$INCLUDE_NODE_MODULES" = "0" ]; then

	if [ -f "$PLUGIN_PATH/package.json" ];
	then
		VOLUME_STRING="$VOLUME_STRING -v /usr/src/plugsier/plugin/node_modules"
	fi

	# Loop through each wp-module in the plugin, and create a fake volume where the node_modules directory lives.
	# so that it doesn't get mounted (to speed up lint times dramatically).
	for DIR in "$PLUGIN_PATH"/wp-modules/*; do
		# If this module has a package.json file.
		if [ -f "$DIR/package.json" ];
		then
			MODULE_DIR_NAME="${DIR##*/}"
			VOLUME_STRING="$VOLUME_STRING -v /usr/src/plugsier/plugin/wp-modules/$MODULE_DIR_NAME/node_modules"
		fi
	
	done
fi

# Run the docker container.
echo '-------'
echo 'Starting the Plugsier docker container, built specifically for this job.'
echo '-------'
echo "docker run $VOLUME_STRING -it -d plugsier"
echo '-------'
echo "Running Command inside Docker Container at location $WORKDIR:"
echo $COMMAND
echo '-------'
CONTAINER_ID=$(docker run $VOLUME_STRING -it -d plugsier)

echo '!!!theContainerId!!!'$CONTAINER_ID


# Run the command passed-in.
docker exec -w $WORKDIR $CONTAINER_ID $COMMAND
THEEXITCODE=$?
echo '!!!theExitCode!!!'$THEEXITCODE

# Stop and remove this container when finished.
docker stop $CONTAINER_ID;
docker rm $CONTAINER_ID;

# Remove any unused volumes.
docker volume prune -f;

exit $THEEXITCODE