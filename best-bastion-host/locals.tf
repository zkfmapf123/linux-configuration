locals {
  network_name = "bastion"
  vpc_cidr     = "10.0.0.0/16"
  region       = "ap-northeast-2"
  public_cidr = {
    "a" : "10.0.1.0/24",
    "b" : "10.0.2.0/24"
  }

  publics = {
    for k, v in local.public_cidr :
    "${local.region}${k}" => v
  }

  public_ip = "218.39.50.99/32"
  ami       = "ami-0c9c942bd7bf113a2"
}