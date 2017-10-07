GOOGLE_CREDENTIALS_FILE ?= /Users/omar/Downloads/gke-terraform-15ab4be2a2ea.json
GOOGLE_PROJECT ?= gke-terraform
GOOGLE_REGION ?= europe-west3
GKE_CLUSTERNAME ?= staggingcluster
GKE_CLUSTER_ZONE  ?= europe-west3-a
GKE_ADDITIONAL_ZONE1 ?= europe-west3-b
GKE_ADDITIONAL_ZONE2 ?= europe-west3-c
GKE_USER ?= omar
GKE_PASSWORD ?= Hello123
NGINX_VERSION ?= nginx:1.7.9
ENVIRONMENT ?= prod
REPLICAS ?= 10

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
	terraform destroy -var="google_credentials_file=$(GOOGLE_CREDENTIALS_FILE)" \
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

deploy:
	jsonnet --ext-str replicas=$(REPLICAS) \
	        --ext-str port=2368 \
		--ext-str enviroment=$(ENVIRONMENT) \
		ksonnet/ghost.jsonnet > deployments/ghost-deploymet.json
	kubectl apply -f deployments/ghost-deployment.json
