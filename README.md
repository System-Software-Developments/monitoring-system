# Monitoring Infrastructure

Monitoring infrastructure  used by Datawire.

# Setup

Ensure you..

1. Have *at least* [Forge](https://forge.sh) v0.3.23 installed.
2. Access to a Kubernetes cluster.

# Deployment

**WARNING**

Deployment is a bit more convoluted than just a simple `forge deploy` as of Forge `0.3.23` because there is an ordering of events that needs to happen for this to work and Forge does not yet allow explicitly ordered deployments.

In order to deploy do the following:

```bash
kubectl create ns monitoring-system
COMPONENT_DIRS=( "./grafana" "./prometheus-operator" "./prometheus" )
for i in "${COMPONENT_DIRS[@]}" ; do
   if [ -d "$i" ]; then
     pushd "$i"
     forge deploy
     popd
   fi
done
```
