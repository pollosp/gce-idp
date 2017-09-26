GOOGLE_CREDENTIALS_FILE ?= XXX
GOOGLE_PROJECT ?= gke-terraform
GOOGLE_REGION ?= europe-west3
GKE_CLUSTERNAME ?= staggingcluster
GKE_CLUSTER_ZONE  ?= europe-west3-a
GKE_ADDITIONAL_ZONE1 ?= europe-west3-b
GKE_ADDITIONAL_ZONE2 ?= europe-west3-c
GKE_USER ?= omar
GKE_PASSWORD ?= Hello123
NGINX_VERSION ?= nginx:1.7.9

plan:
	terraform plan -var="google_credentials_file=$(GOOGLE_CREDENTIALS_FILE)" \
		-var="google_project=$(GOOGLE_PROJECT)" \
		-var="google_region=$(GOOGLE_REGION)" \
		-var="cluster_name=$(GKE_CLUSTERNAME)" \
		-var="cluster_zone=$(GKE_CLUSTER_ZONE)" \
		-var="cluster_additional_zone1=$(GKE_ADDITIONAL_ZONE1)" \
		-var="cluster_additional_zone2=$(GKE_ADDITIONAL_ZONE2)" \
		-var="master_username=$(GKE_USER)" \
		-var="master_password=$(GKE_PASSWORD)" \
		-var="nginx_version=$(NGINX_VERSION)"
apply:
	terraform apply -var="google_credentials_file=$(GOOGLE_CREDENTIALS_FILE)" \
		-var="google_project=$(GOOGLE_PROJECT)" \
		-var="google_region=$(GOOGLE_REGION)" \
		-var="cluster_name=$(GKE_CLUSTERNAME)" \
		-var="cluster_zone=$(GKE_CLUSTER_ZONE)" \
		-var="cluster_additional_zone1=$(GKE_ADDITIONAL_ZONE1)" \
		-var="cluster_additional_zone2=$(GKE_ADDITIONAL_ZONE2)" \
		-var="master_username=$(GKE_USER)" \
		-var="master_password=$(GKE_PASSWORD)" \
		-var="nginx_version=$(NGINX_VERSION)"

destroy:
	terraform apply -var="google_credentials_file=$(GOOGLE_CREDENTIALS_FILE)" \
		-var="google_project=$(GOOGLE_PROJECT)" \
		-var="google_region=$(GOOGLE_REGION)" \
		-var="cluster_name=$(GKE_CLUSTERNAME)" \
		-var="cluster_zone=$(GKE_CLUSTER_ZONE)" \
		-var="cluster_additional_zone1=$(GKE_ADDITIONAL_ZONE1)" \
		-var="cluster_additional_zone2=$(GKE_ADDITIONAL_ZONE2)" \
		-var="master_username=$(GKE_USER)" \
		-var="master_password=$(GKE_PASSWORD)" \
		-var="nginx_version=$(NGINX_VERSION)"

get_cluster_credentials:
	gcloud config set project gke-terraform  \
	gcloud config set compute/zone $(GKE_CLUSTER_ZONE) \
        gcloud container clusters get-credentials $(GKE_CLUSTERNAME)

deploy_ksonnet: get_cluster_credentials
	jsonnet --ext-str var1_value=$(KSONNET_VALUE) ./ksonnet/example.jsonnet > ./deployments/deployment.json
	kubectl apply -f deployments/deployment.json
	rm deployments/deployment.json
