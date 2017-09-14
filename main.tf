provider "google" {
    credentials = "${file("/Users/omar/Downloads/gke-terraform-fabaee7395c6.json")}"
    project = "gke-terraform"
    region = "europe-west3"
}

resource "google_container_cluster" "primary" {
  name               = "marcellus-wallace"
  zone               = "europe-west3-a"
  initial_node_count = 2

  additional_zones = [
    "europe-west3-b",
    "europe-west3-c",
  ]

  master_auth {
    username = "omar"
    password = "gatoperro"
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
     google_cluester="${google_container_cluster.primary.id}"
  }

  provisioner "local-exec" {
    command = "gcloud config set project gke-terraform && gcloud config set compute/zone europe-west3-a && gcloud container clusters get-credentials marcellus-wallace"
  }
}
