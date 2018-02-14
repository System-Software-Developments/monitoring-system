# Monitoring Infrastructure

Monitoring infrastructure  used by Datawire.

# Setup

Ensure you..

1. Have *at least* [Forge](https://forge.sh) v0.3.23 installed.
2. Access to a Kubernetes cluster.

# Explanation

This repo contains:

* A configuration of Grafana
* A configuration of the Prometheus Operator
* The configuration necessary to configure a Prometheus object & ServiceMonitor to monitor Argonath

The Argonath Prometheus object and Service Monitor need to be deployed in the `argonath` namespace, and they need to be deployed *after* the CRD is created. The correct ordering is below.

# Deployment

**WARNING**

Deployment is a bit more convoluted than just a simple `forge deploy` as of Forge `0.3.23` because there is an ordering of events that needs to happen for this to work and Forge does not yet allow explicitly ordered deployments.

In order to deploy do the following:

```bash
kubectl create ns monitoring-system
COMPONENT_DIRS=( "./grafana" "./prometheus-operator" "./prom-argonath" "./argonath" )
for i in "${COMPONENT_DIRS[@]}" ; do
   if [ -d "$i" ]; then
     pushd "$i"
     forge deploy
     popd
   fi
done
```

Alternatively run `./deploy.sh`

## Grafana

1. Run the `deploy.sh` script.
2. In Grafana, configure the data source to point to http://prometheus-stable.argonath.svc.cluster.local:9090
3. Import the dashboard from https://grafana.com/dashboards/4698
