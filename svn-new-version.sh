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

# Pull the SVN repo from wp.org into that directory.
svn co https://plugins.svn.wordpress.org/"$plugindirname" --depth=empty .;
svn up trunk
svn up tags --depth=empty
svn up tags/"$VERSION"
cd trunk;

# Remove everything from the trunk directory.
#rm -rf * .* *.*;

# Unzip the built/zipped file to the trunk directory of the SVN repo.
unzip -d "$TMPSVNDIR"/trunk "$wpcontentdir"/plugins/"$plugindirname"/"$plugindirname"."$VERSION".zip

svn propset svn:ignore -F .svnignore .;
cd ../;
svn stat | { grep -E '^\?' || true; } | awk '{print $2}' | xargs -r svn add
svn stat | { grep -E '^\!' || true; } | awk '{print $2}' | xargs -r svn rm
echo "Here is the svn stat about to be checked in:"
svn stat --verbose

# Remove this tag in case it already exists.
svn rm tags/"$VERSION";

# Copy trunk into the tag folder we are creating.
svn cp trunk tags/"$VERSION";

# Send the files up to the WP repo.
svn ci -m "$SLUG: syncing with code from Github" --no-auth-cache --non-interactive --username "{$SVN_USERNAME}" --password "{$SVN_PASSWORD}";
cd $CURDIR;
#rm -rf $TMPSVNDIR;
echo 'Done!';
