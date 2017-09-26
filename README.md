# gce-idp
Handling Gke credentials
https://deis.com/blog/2016/first-kubernetes-cluster-gke/

# Envieronment variables
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
