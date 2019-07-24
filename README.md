# devops-interview

## Terraform Task

Write a terraform script that creates resources in Google Cloud which includes:

* A VPC with subnets
* Firewall rules for the VPC to allow SSH
* A public Cloud DNS zone with your specified subdomain (Adding NS records to parent domain can be manual)
* Managed Google Cloud Certificate for your `api.${subdomain}` (Google doesn't allow wildcard managed cert)
* A GCE instance (VM) under one of the created subnets (Debian or Ubuntu) with proper startup_script
* A HTTPS load balancer for the GCE instance that connects to the instance's TCP port 3000 with the created google cloud certificate
