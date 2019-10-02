#!/bin/bash

export JAVA_HOME="/usr/local/openjdk-8"

bash <(curl -s https://detect.synopsys.com/detect.sh) "$*"
