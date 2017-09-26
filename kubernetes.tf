variable "nginx_version" {}

provider "kubernetes" {
  host     = "https://${google_container_cluster.primary.endpoint}"
  username = "${var.master_username}"
  password = "${var.master_password}"
}


resource "kubernetes_service" "example" {
  depends_on = ["null_resource.get_cluster_credentials"]
  metadata {
    name = "terraform-example"
  }
  spec {
    selector {
      app = "${kubernetes_pod.example.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      port = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "example" {
  depends_on = ["null_resource.get_cluster_credentials"]
  metadata {
    name = "terraform-example"
    labels {
      app = "MyApp"
    }
  }

  spec {
    container {
      image = "${var.nginx_version}"
      name  = "example"
    }
  }
}
