#!/bin/bash

if [ ! -f /proc/mdstat ]; then
	echo "There is no RAID on this system."
	exit 0
fi
cmd() { grep "active" < /proc/mdstat; }
if [ "$(cmd)" == "" ]; then
	echo "There is no active RAID on this system."
	exit 0
fi
cmd() { grep "\]\(F\)" < /proc/mdstat; }
if [ "$(cmd)" == "" ]; then
	echo "No hard drive has failed.      "
	cmd() { cat /proc/mdstat | grep "resync"; }
	if [ "$(cmd)" != "" ]; then
		echo "A RAID resync is in progress. "
	fi
else
	ex='!'
	echo "/$ex\\ A hard drive has failed!  "
fi
