provider "aws" {
  region = local.region
  access_key = "AKIAVS45HY5QR4HT475V"
  secret_key = "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"
}

locals {
  name   = "new-local"
  region = "ca-central-1"

}

module "test1" {
  source = "./vpc_modules"
  main_vpc_cidr = "10.0.0.0/16"
  public_subnets = "10.0.1.0/24"
  private_subnets = "10.0.2.0/24"
}

module "test2" {
  source = "./ec2_modules/"
  vpc_id = module.test1.vpc_id
  subnet_id = module.test1.subnet_id
  subnet_id1=module.test1.subnet_id1
}

/*resource "aws_instance" "example1" {
  ami         = "ami-00f881f027a6d74a0"
  instance_type = "t2.micro"
lifecycle {
  create_before_destroy = true
  prevent_destroy = true
}
}*/

