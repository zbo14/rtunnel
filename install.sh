#!/bin/bash -e

cd "$(dirname $0)"

chmod u+x rtunnel

ln -s $PWD/rtunnel /usr/local/bin
