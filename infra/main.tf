module "vpc" {
  source = "./aws/vpc"
  name   = "ros"
  cidr   = "10.100.0.0/16"
}

module "route53" {
  source                         = "./aws/route53"
  root_domain                    = "perxtech.org"
  sub_domain                     = "ros"
  root_domain_managed_in_route53 = true
}


module "acm" {
  source                    = "./aws/acm"
  domain_name               = "ros.perxtech.org"
  route53_domain_name       = substr(module.route53.this.name, 0, length(module.route53.this.name)-1)
  route53_dns_record_count  = 1
  subject_alternative_names = ["*.ros.perxtech.org"]
}


module "ec2" {
  source           = "./aws/ec2"
  name_prefix      = "ros"
  vpc_id           = module.vpc.this.vpc_id
  subnet_ids       = module.vpc.this.public_subnets
  aws_cert_arn     = module.acm.this.arn
  lb_dns_hostnames = ["api.ros.perxtech.org"]
  route53_zone_id  = module.route53.this.zone_id
  ec2_key_pair     = "perx_admin"
}

output "vpc" {
  value = module.vpc.this
}

output "route53" {
  value = module.route53.this
}

output "acm" {
  value = module.acm.this
}

output "ec2" {
  value = module.ec2.this
}

output "ec2-eip" {
  value = module.ec2.eip
}
