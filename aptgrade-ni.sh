#!/bin/bash

echo "aptgrade (non-interactive): update"
apt-get update
echo "aptgrade (non-interactive): upgrade"
apt-get -y upgrade
echo ""
