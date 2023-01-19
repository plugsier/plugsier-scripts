#!/bin/bash

# Run setup.
. ./setup.sh
. ./setup-php.sh

# Check if this plugin has it's own standards in a phpcs.xml
#if [ -f "$plugindir"/phpcs.xml ]; then
 # To do: use the local phpcs.xml file.
#fi

# Duplicate the phpcs.xml boiler, and call it phpcs.xml.
cp phpcs-boiler.xml phpcs.xml

# Modify the phpcs.xml file in the plugsier-scripts module to contain the namespace and text domain of the plugin in question.
sed -i.bak "s/MadeWithPlugsier/$namespace/g" phpcs.xml
sed -i.bak "s/madewithplugsier/$textdomain/g" phpcs.xml

# Run the phpcs command from the wp-content directory.
if [ "$fix" = "1" ]; then
	./vendor/bin/phpcbf -q "$plugindir" --basepath="$wpcontentdir"
	./vendor/bin/phpcs -q "$plugindir";
else
	./vendor/bin/phpcs -q "$plugindir";
fi