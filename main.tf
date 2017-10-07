# Set the variable value in *.tfvars file
# or using -var="google_credentials_file=..." CLI option
variable "google_credentials_file" {}
variable "google_project" {}
variable "google_region" {}
variable "cluster_name" {}
variable "cluster_zone" {}
variable "cluster_additional_zone1" {}
variable "cluster_additional_zone2" {}
variable "master_username" {}
variable "master_password" {}

provider "google" {
    credentials = "${file("${var.google_credentials_file}")}"
    project = "${var.google_project}"
    region = "${var.google_region}"
}

resource "google_container_cluster" "primary" {
  name               = "${var.cluster_name}"
  zone               = "${var.cluster_zone}"
  initial_node_count = 2

  additional_zones = [
    "${var.cluster_additional_zone1}",
    "${var.cluster_additional_zone2}",
  ]

  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }
}

resource "null_resource" "get_cluster_credentials" {

  triggers = {
     google_cluster="${google_container_cluster.primary.id}"
  }

  provisioner "local-exec" {
    command = "sleep 120 && gcloud config set project gke-terraform && gcloud config set compute/zone europe-west3-a && gcloud container clusters get-credentials ${var.cluster_name}"
  }
}
