#!/usr/bin/env bash

echo Adding mongodb repository key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo Adding mongodb repository
sudo echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list

echo "Updating apt packages information"
sudo apt-get update

echo "Installing mongodb"
sudo apt-get install -y mongodb-org

echo "Launching mongodb service"
sudo systemctl start mongod

echo "Making service autolaunching"
sudo systemctl enable mongod
