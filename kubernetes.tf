#variable "ghost_version" {}

#provider "kubernetes" {
#  host     = "https://${google_container_cluster.primary.endpoint}"
#  username = "${var.master_username}"
#  password = "${var.master_password}"
#}


#resource "kubernetes_service" "ghost-service" {
#  metadata {
#    name = "ghost-service"
#  }
#  spec {
#    selector {
#      app = "${kubernetes_pod.ghost-blog.metadata.0.labels.app}"
#    }
#    session_affinity = "ClientIP"
#    port {
#      port = 8080
#      target_port = 2368
#    }
#
#    type = "LoadBalancer"
#  }
#}
#
#resource "kubernetes_pod" "ghost-blog" {
#  metadata {
#    name = "ghost-blog"
#    labels {
#      app = "ghost-blog"
#    }
#  }
#
#  spec {
#    container {
#      image = "${var.ghost_version}"
#      name  = "ghost-blog"
#      resources {
#           requests{
#             cpu = "100m" //https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu
#             memory = "100Mi"
#          }
#       }
#    }
#  }
#}
#
#output "lb_ip" {
#  value = "${kubernetes_service.ghost-service.load_balancer_ingress.0.ip}"
#}
