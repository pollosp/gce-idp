---
# TERRAFORM AND GKE
## BEST FRIENDS
---
## ABOUT ME

* I'm Omar Lopez
* I'm new in the city so this is my first talk in Krakow and my first in English too
* I'm working as SRE at Flywire
* Flywire is a crossborder payment platform (http://www.flywire.com)
* We have been playing with Kubernetes for at least 10 months

---
## TODAY'S OBJECTIVES

* Show how we can use GKE and Terraform together
* Run a sample application in GKE

---

## AGENDA

* Quick review of GKE and Terraform
* Quick code review
* Demo

Estimated time 35 minutes + questions

---
## CODE

![QR](https://github.com/pollosp/gke/raw/simple/images/QR.png "QR")

### https://github.com/pollosp/gke/tree/simple

---
## GKE

Google Container Engine is a managed environment for deploying containerized applications.
(https://cloud.google.com/container-engine/)

It uses Kubernetes as engine

Is anyone using GKE or interested in it?

---

## KUBERNETES

Kubernetes is an open-source system for automating deployment, scaling and management of containerized applications
(https://en.wikipedia.org/wiki/Kubernetes)

Is anyone using Kubernetes or interested in it?

---

## WHY CONTAINERS?

* Environmental consistency across development, testing and production: Runs the same on a laptop as it does in the cloud
* Quick and easy rollbacks: just use the previous version of the container
* Cloud and OS distribution portability: Run Debian containers into Red Hat host

---

## AND MORE ABOUT CONTAINERS
* Application-centric management: Focus your efforts on the app not on the system
* Resource isolation: One app one container with its libraries
* Resource utilization: High efficiency and density

(https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

---

## WHY KUBERNETES?

* Deploy your applications quickly: Hundreds or thousands of pods at the same time
* Deploy immutable applications: Read Only containers
* Scale your applications on the fly: Rescale your app pods
* Roll out new features seamlessly: Rolling updates, Blue Green strategy, etc.
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

* Scheduler/Controller Manager: Workload and resources mangement
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

Is anyone using Terraform or interested in it?

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
## QUESTIONS?
---
## THANKS
