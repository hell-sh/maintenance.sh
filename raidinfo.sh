#!/bin/bash

cmd1() { cat /proc/mdstat | grep "\]\(F\)"; }
if [ "$(cmd1)" == "" ]; then
	echo "No hard drive has failed.      "
	cmd2() { cat /proc/mdstat | grep "resync"; }
	if [ "$(cmd2)" != "" ]; then
		echo "A RAID resync is in progress. "
	fi
else
	ex='!'
	echo "/$ex\\ A hard drive has failed!  "
fi
