#!/usr/bin/env bash

kubectl create ns monitoring-system
COMPONENT_DIRS=( "./grafana" "./prometheus-operator" "./prom-argonath" "./argonath")
for i in "${COMPONENT_DIRS[@]}" ; do
   if [ -d "$i" ]; then
     pushd "$i"
     forge deploy
     popd
   fi
done
