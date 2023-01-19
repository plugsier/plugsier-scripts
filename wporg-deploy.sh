#!/bin/bash

# Run setup.
while getopts 'p:n:t:f:s' flag; do
	case "${flag}" in
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
		s) svnurl=${OPTARG} ;;
	esac
done

# The plugin is mounted as a volume into the Docker container at /usr/src/plugsier/plugin
plugindir=/usr/src/plugsier/plugin

mkdir local-plugin-dir

svn co $svnurl local-plugin-dir

$plugindir