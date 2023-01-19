#!/bin/bash

# Install dependencies.
if [ ! -d node_modules ]; then
	npm install
fi

# Loop through each wp-module in the plugin, and install their dependencies.
for DIR in "$plugindir"/wp-modules/*; do
	# If this module has a package.json file.
	if [ -f "$DIR"/package.json ]; then
		# Go to the directory of this wp-module.
		cd "$DIR";

		# Run npm install for this module.
		if [ ! -d node_modules ]; then
			npm install;
		fi
		
		cd - > /dev/null
	fi
done
