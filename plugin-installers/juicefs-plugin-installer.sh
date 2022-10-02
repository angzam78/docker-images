#!/bin/sh

NAME=juicefs
REGISTRY=registry.viraqua.net
PLUGIN=juicefs-volume-plugin
VERSION=1.0.0
ARCH=`dpkg --print-architecture`

PLUGINREFERENCE=$REGISTRY/$PLUGIN:$VERSION-$ARCH

evaluate() {
  ret=$?
  if [ $ret -eq 0 ]
  then
    echo $1
  else
    echo $2
  fi
  return $ret
}

check() {
  echo -n "Checking for $NAME plugin... "
  docker plugin inspect $NAME > /dev/null 2>&1
  evaluate "present" "missing"
}

install() {
  echo -n "Installing $NAME plugin... "
  docker plugin install --alias $NAME --grant-all-permissions $PLUGINREFERENCE > /dev/null 2>&1
  evaluate "success" "failed"
}

if [ "$1" = "healthcheck" ]
then
  installed=`docker plugin inspect $NAME --format "{{.PluginReference}}" 2> /dev/null`
  if [ "$PLUGINREFERENCE" = "$installed" ]
  then
    exit 0
  else
    exit 1
  fi
fi

check

if [ $? -eq 1 ]
then
  install
fi
