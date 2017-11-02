---
# TERRAFORM AND GKE
## BEST FRIENDS
---
## ABOUT ME

* I'm new in the city so this is my first talk in Krakow and first in English too
* I work with the Flywire engineering team in Valencia (Spain) as SRE
* Flywire is a crossborder payment platform (http://www.flywire.com)
* We have been playing with Kubernetes for at least for 10 months
---
## TODAY'S OBJECTIVES

* Show how we can use GKE and Terraform to manage our Kubernetes
* Ghost Blog example

---

## AGENDA

* Quick review of GKE and Terraform
* Quick code review
* Demo

Estimated time 30 minutes + questions

---

## GKE

Google Container Engine is a managed environment for deploying containerized applications.
(https://cloud.google.com/container-engine/)

It uses Kubernetes as engine

Is anyone using GKE or interested on it?

---

## KUBERNETES

Kubernetes is an open-source system for automating deployment, scaling and management of containerized applications
(https://en.wikipedia.org/wiki/Kubernetes)

Is anyone using Kubernetes or interested on it?

---

## WHY CONTAINERS?

* Environmental consistency across development, testing, and production: Runs the same on a laptop as it does in the cloud
* Quick and easy rollbacks: just use the previous version of the container
* Cloud and OS distribution portability: Run Debian containers into RedHat host

---

## AND MORE ABOUT CONTAINERS
* Application-centric management: Focus your eforts in the app not into the system
* Resource isolation: One app one container with his libaries
* Resource utilization: High efficiency and density

(https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

---

## WHY KUBERNETES?

* Deploy your applications quickly: Hunders or thoursands of pods at sametime
* Deploy imutable applications: Read Only containers
* Scale your applications on the fly: Rescale your app pods
* Roll out new features seamlessly: Rolling updates, Blue Green stategy, etc
* Limit hardware usage to required resources only

(https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

---

## AND THERE ARE MORRE REASONS ...

* Portable: public, private, hybrid, multi-cloud
* Extensible: modular, pluggable, hookable, composable
* Self-healing: auto-placement, auto-restart, auto-replication, auto-scaling

(https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

---

## KUBERNETES OVERVIEW

* Scheduler/Controller Manager: Workload and resources
* API server: Interaction with the user
* Kubelet: Agent
* ETCD: Persistency/state/database
* Masters/Workers: Nodes/GCE instances

---

## KUBERNETES OVERVIEW

![alt kubernetes_schema](https://github.com/pollosp/gke/raw/master/images/kubernetes.png "Kubernetes schema")

---
## KUBERNETES BASIC OBJECTS

* POD
* ConfigMap
* Secret
* Service
* Deployment

---
## TERRAFORM

Terraform is an infrastructure as code software by HashiCorp.
It allows users to define a datacenter infrastructure in a high-level configuration language, from which it can create an execution plan to build the infrastructure in a service provider such as AWS
(https://en.wikipedia.org/wiki/Terraform_(software) )

Is anyone using Terraform or interested on it?

---
### TERRAFORM PROVIDERS

A provider is responsible for understanding API interactions and exposing resources. Providers generally are an IaaS (e.g. AWS, GCP, Microsoft Azure, OpenStack), PaaS (e.g. Heroku), or SaaS services (e.g. Terraform Enterprise, DNSimple, CloudFlare).
(https://www.terraform.io/docs/providers/index.html)

---

Example:

```hcl
provider "google" {
  credentials = "${file("account.json")}"
  project     = "my-gce-project"
  region      = "us-central1"
}
```

---

### TERRAFORM RESOURCES

Resources are a components of your infrastructure.
Like virtual machine, container, email provider, DNS record, or database provider.
(https://www.terraform.io/docs/configuration/resources.html)

---
Example:

```hcl
resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  image = "debian-8-jessie-v20170523"
  labels {
    environment = "dev"
  }
}
```

---

### OTHER TERRAFORM CONFIG ITEMS

* Variables
* Local Values
* Output
* Environment Variables
* Modules
* Data

---
## SHOW ME THE CODE (DEMO)
---
### GKE with TERRAFROM
---
### KUBERNETES with TERRAFORM
---
## QUESTIONS?
---
## THANKS
