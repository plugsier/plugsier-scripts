#!/bin/bash

while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
		h) pluginpathonhost=${OPTARG} ;;
	esac
done

# The plugin is mounted as a volume into the Docker container at /usr/src/plugsier/plugin
plugindir=/usr/src/plugsier/plugin
