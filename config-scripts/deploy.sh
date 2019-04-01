#!/usr/bin/env bash

echo Downloading app source code
git clone -b monolith https://github.com/express42/reddit.git

cd reddit

echo Installing bundler packages
bundle install

echo Launching app
puma -d

echo App port $(ps aux | grep -Eo "puma.*:([0-9]{3,5})" | cut -d: -f3)
