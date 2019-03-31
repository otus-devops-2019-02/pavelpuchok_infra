#!/usr/bin/env bash

echo "Updating apt packages information"
sudo apt-get update

echo "Installing ruby, bundler and dependencies"
sudo apt-get install -y ruby-full ruby-bundler build-essential

echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundler -v)"

echo "Done"
