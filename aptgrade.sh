#!/bin/bash

echo -ne "aptgrade: update              \r"
echo ""
apt-get update
echo "aptgrade: upgrade"
apt-get -y upgrade
echo ""
