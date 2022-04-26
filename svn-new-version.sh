#!/bin/bash

# Run setup.
. ./setup.sh

# Use the passed-in svn username and password, fallback to environment vars.
if [ -z "$username" ]; then
	SVN_USERNAME=$username;
fi
if [ -z "$password" ]; then
	SVN_PASSWORD=$password;
fi

# Get the version of the plugin from the plugin header.
VERSION=$(grep 'Version:' "$wpcontentdir"/plugins/"$plugindirname"/"$plugindirname".php | awk -F: '{print $2}' | sed 's/^\s//')

# Store the current directory so we can get back to it at the end of this script when we delete the temporary directory.
CURDIR=$(pwd);

# Build the plugin.
#sh build.sh -p $plugindirname -n $namespace -t $textdomain;

# Zip the plugin.
#sh zip.sh -p $plugindirname -n $namespace -t $textdomain;

# In the future, here we could spin up an wp-env site for smoke testing, and pause for approval.

# Create a directory in the drive root to temporary store the SVN repo.
TMPSVNDIR="$wpcontentdir"/temp-svn-"$plugindirname";
echo $TMPSVNDIR;
mkdir -p "$TMPZIPDIR";
cd "$TMPSVNDIR";
