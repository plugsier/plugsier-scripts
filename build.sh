#!/bin/bash

# Run setup.
. ./setup.sh

# Loop through each wp-module in the plugin.
for DIR in "$plugindir"/wp-modules/*; do
	# If this module has a package.json file.
	if [ -f "$DIR/package.json" ];
	then
		# Go to the directory of this wp-module.
		cd "$DIR";
		# Run npm install for this module.
		npm install;
		
		# Run the build script for this module.
		npm run build;
	fi

done

# Finish with a wait command, which lets a kill (cmd+c) kill all of the process created in this loop.
wait;