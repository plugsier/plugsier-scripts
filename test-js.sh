#!/bin/bash

# Run setup.
. ./setup.sh
. ./setup-node.sh

npm run test:js -- --roots "$plugindir"
