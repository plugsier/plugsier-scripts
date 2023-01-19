#!/bin/bash

# Run setup.
. ./setup.sh

# Duplicate the wp-env-boiler.json file and call it .wp-env, and put custom values into it for this plugin
cp wp-env-boiler.json .wp-env.json

# Modify the .wp-env.json file in the plugsier-scripts directory so it maps the plugin path into the docker container.
sed -i.bak "s/PATH_TO_PLUGIN/$pluginpathonhost/g" .wp-env.json

# Start wp-env
npx -p @wordpress/env wp-env start


# Run PHPunit inside wp-env, targeting the plugin in question.
if [ "$multisite" = "1" ]; then
	npx -p @wordpress/env wp-env run phpunit "WP_MULTISITE=1 phpunit -c /var/www/html/wp-content/plugsier-scripts/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname"
else
	npx -p @wordpress/env wp-env run phpunit "phpunit -c /var/www/html/wp-content/plugsier-scripts/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname"
fi
