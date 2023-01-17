#!/bin/bash

# Install dependencies.
if [ ! -d vendor ]; then
	composer install
fi