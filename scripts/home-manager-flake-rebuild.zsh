#!/usr/bin/env zsh

if [ ! -z $1 ]; then
	export USERNAME=$1
else
	export USERNAME=$USER
fi

home-manager --flake .#$USERNAME switch