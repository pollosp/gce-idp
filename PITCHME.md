---
# TERRAFROM GKE and KSONNET BEST FRIENDS
---
## ABOUT ME

I'm new in the city so this is my first talk in krakow and in english
I work remotely with the Flywire engeneering team in Valencia (Spain) as SRE 
We have been playing with Kubernetes for at leat 9 month
---
## AGENDA

* Fast review of GKE, Terraform and KSONNET 
* Code review 
* Fast demo 
Estimated time 30 minutes + questions 
---
## GKE

Google Container Engine is a managed environment for deploying containerized applications. 
(https://cloud.google.com/container-engine/)

Anyone is familiar with GKE and GCE? 
---
## TERRAFORM

Terraform is an infrastructure as code software by HashiCorp. It allows users to define a datacenter infrastructure in a high-level configuration language, from which it can create an execution plan to build the infrastructure in a service provider such as AWS
(https://en.wikipedia.org/wiki/Terraform_(software) )

Anyone is familiar with Terraform? 
---
### PROVIDERS

Terraform is used to create, manage, and manipulate infrastructure resources.
Examples of resources include physical machines, VMs, network switches, containers, etc. 
Almost any infrastructure noun can be represented as a resource in Terraform.
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
### RESOURCES
---
The most important thing you'll configure with Terraform are resources.
Resources are a component of your infrastructure. 
It might be some low level component such as a physical server, virtual machine, or container. 
Or it can be a higher level component such as an email provider, DNS record, or database provider.
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
### OTHER CONFIG ITEMS

* Modules
* Data
* Variables
* Local Values
* Output
* Environment Variables
* ETC
---
## KSONET 

A Jsonnet library that compiles to Kubernetes YAML
(http://ksonnet.heptio.com/)
Anyone is familiar with KSONNET? 
---
### JSONNET 

Jsonnet is a domain specific configuration language that helps you define JSON data. 
Jsonnet lets you compute fragments of JSON within the structure, bringing the same benefit to structured data that templating languages bring to plain text. 
image
(http://jsonnet.org/)
---
## SHOW ME THE CODE (DEMO)
---
### GKE with TERRAFROM
---
### KUBERNETES with TERRAFORM
---
### KUBERNETES with KSONET
---
### QUESTIONS?