#!/usr/bin/env bash

source functions.sh

# set_manager
# pkginstall "git-credential-manager"

arg="git-credential-manager"
jq ".$arg.apt" packages.json
