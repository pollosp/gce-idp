# gce-idp
Handling Gke credentials
https://deis.com/blog/2016/first-kubernetes-cluster-gke/

# Environment variables

```sh
#!/bin/bash
export GOOGLE_CREDENTIALS_FILE="/Users/omar/Downloads/gke-terraform-fabaee7395c6.json"
export GOOGLE_PROJECT="gke-terraform"
export GOOGLE_REGION="europe-west3"
export GKE_CLUSTERNAME="stagging_cluster"
export GKE_CLUSTER_ZONE="europe-west3-a"
export GKE_ADDITIONAL_ZONE1="europe-west3-b"
export GKE_ADDITIONAL_ZONE2="europe-west3-c"
export GKE_USER="jose"
export GKE_PASSWORD="Hello123"
```

# Port Forward
`kubectl port-forward kubernetes-dashboard-1914926742-x8fsc 9090:9090 -n kube-system`

# KSONNET COMMANDS
`$ksonnet\>` `jsonnet --ext-str replicas=20 --ext-str port=2368 --ext-str enviroment=prod example.jsonnet > deploymet.json`
