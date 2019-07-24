# devops-interview

## Terraform Task

Write a terraform script that creates resources in Google Cloud which includes:

* A VPC with subnets
* Firewall rules for the VPC to allow SSH
* A public Cloud DNS zone with your specified subdomain (Adding NS records to parent domain can be manual)
* Managed Google Cloud Certificate for your `api.${subdomain}` (Google doesn't allow wildcard managed cert)
* A GCE instance (VM) under one of the created subnets (Debian or Ubuntu) with proper startup script
* A HTTPS load balancer for the GCE instance that connects to the instance's TCP port 3000 with the created google cloud certificate

Implement each of vpc, dns, instance and cert as a terraform module

The modules are then invoked by a `main.tf` file in the root of the directory

The instance startup script should prepare the machine with the some packages such as python and ansible

## Infra Code

The infra code already contains a set of terraform code for use with AWS. You can use this for reference

Your implementation should work in a similar way
