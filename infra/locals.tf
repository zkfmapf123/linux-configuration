locals {
  network_name = "linux"
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

  public_ip = "0.0.0.0/0"
  
  // Architecture => ARM(64)
  ec2_machine = {
    "t4g.small" : "ami-0e3a9423b7b281ba8"
  }
}