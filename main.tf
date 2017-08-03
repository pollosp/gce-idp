provider "google" {
    credentials = "${file("/Users/omar/Downloads/reverseproxy-c769275b50ba.json")}"
    project = "reverseproxy-175718"
    region = "us-west1"
}

resource "google_compute_instance" "proxy" {
    name = "test"
    machine_type = "f1-micro"
    zone = "us-west1-a"

   tags = ["http-load"]

   disk {
     image = "projects/debian-cloud/global/images/family/debian-8"
   }

   network_interface {
     network = "default"

     access_config {
       // Ephemeral IP
     }
   }

   provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]
    connection {
      type     = "ssh"
      user     = "omarlopez"
    }
  }
}

resource "google_compute_instance_group" "proxy-resources" {
  name = "proxy-resources"
  zone = "us-west1-a"

  instances = ["${google_compute_instance.proxy.self_link}"]

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_health_check" "health-check" {
  name = "health-check"

  http_health_check {
  }
}

resource "google_compute_backend_service" "proxy-service" {
  name = "proxy-service"
  protocol = "HTTP"

  backend {
    group = "${google_compute_instance_group.proxy-resources.self_link}"
    balancing_mode = "frequency"
    max_rate_per_instance = 120
  }

  health_checks = ["${google_compute_health_check.health-check.self_link}"]
}


resource "google_compute_url_map" "web-map" {
  name = "web-map"
  default_service = "${google_compute_backend_service.proxy-service.self_link}"

  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name = "allpaths"
    default_service = "${google_compute_backend_service.proxy-service.self_link}"
  }
}

//openssl req  -nodes -new -x509  -keyout server.key -out server.cert

resource "google_compute_ssl_certificate" "proxy-cert" {
  name        = "proxy-cert"
  description = "description"
  private_key = "${file("../server.key")}"
  certificate = "${file("../server.cert")}"
}

resource "google_compute_target_https_proxy" "https-lb-proxy" {
  name             = "test-proxy"
  description      = "a description"
  url_map = "${google_compute_url_map.web-map.self_link}"
  ssl_certificates = ["${google_compute_ssl_certificate.proxy-cert.self_link}"]
}

resource "google_compute_target_http_proxy" "http-lb-proxy" {
  name = "http-lb-proxy"
  url_map = "${google_compute_url_map.web-map.self_link}"
}

resource "google_compute_global_address" "external-address" {
  name = "external-address"
}

resource "google_compute_global_forwarding_rule" "http" {
  name = "http-content-gfr"
  target = "${google_compute_target_http_proxy.http-lb-proxy.self_link}"
  ip_address = "${google_compute_global_address.external-address.address}"
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https" {
  name = "https-content-gfr"
  target = "${google_compute_target_https_proxy.https-lb-proxy.self_link}"
  ip_address = "${google_compute_global_address.external-address.address}"
  port_range = "443"
}

resource "google_compute_firewall" "default" {
  name = "wwww-firewall-allow-internal-only"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags = ["http-load"]
}

