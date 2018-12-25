#!/bin/bash

echo "aptgrade: update              "
apt-get update
echo "aptgrade: upgrade"
apt-get -y upgrade
echo ""
