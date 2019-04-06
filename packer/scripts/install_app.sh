#!/usr/bin/env bash
set -e

APP_USER=redditapp
APP_DIR=/app
UNIT_SOURCE=/tmp/redditapp.service
UNIT_DEST=/etc/systemd/system/redditapp.service

mv ${UNIT_SOURCE} ${UNIT_DEST}
useradd -U ${APP_USER}
git clone -b monolith https://github.com/express42/reddit.git ${APP_DIR}
cd ${APP_DIR} && bundle install
chown -R ${APP_USER}:${APP_USER} ${APP_DIR}
