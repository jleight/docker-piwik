#!/bin/sh

cp -a "${APP_HOME}/defaults/." "${APP_DATA}/"
ln -fs "${APP_HOME}" /usr/share/nginx/html/piwik

exec /usr/sbin/nginx -g "daemon off;"