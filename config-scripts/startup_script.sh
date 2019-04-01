#!/usr/bin/env bash

echo Adding mongodb repository key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo Adding mongodb repository
sudo echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list

echo "Updating apt packages information"
sudo apt-get update

echo "Installing ruby, bundler, mongodb and dependencies"
sudo apt-get install -y mongodb-org ruby-full ruby-bundler build-essential

echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundler -v)"

echo "Launching mongodb service"
sudo systemctl start mongod

echo "Making service autolaunching"
sudo systemctl enable mongod

echo Downloading app source code
git clone -b monolith https://github.com/express42/reddit.git

cd reddit

echo Installing bundler packages
bundle install

echo Launching app
puma -d

echo App port $(ps aux | grep -Eo "puma.*:([0-9]{3,5})" | cut -d: -f3)
