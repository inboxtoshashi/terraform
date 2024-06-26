provider "aws" {
  region = "us-east-1"
}

data "aws_ssm_parameter" "parameter" {
  name = "/base/ami"
}

module "vpc_resource" {
  source = "./vpc"
}

module "route_table_resource" {
  source           = "./route_table"
  vpc_id           = module.vpc_resource.vpc_id_result
  gateway_id       = module.aws_internet_gateway.igw_id_result
  public_subnet_id = module.subnet_resource.public_subnet_id_result
}

module "aws_internet_gateway" {
  source = "./igw"
  //passsing vpc_id to igw.tf to attache the vpc with internet_gateway
  vpc_id = module.vpc_resource.vpc_id_result
}

module "subnet_resource" {
  source = "./subnet"
  vpc_id = module.vpc_resource.vpc_id_result
}

module "security_group_resource" {
  source = "./sgroup"
  //passsing vpc_id to sgroup.tf to attache the vpc with security_group
  vpc_id = module.vpc_resource.vpc_id_result
}

/**
module "ec2_resource" {
  source                 = "./ec2"
  ami                    = data.aws_ssm_parameter.parameter.value
  private_subnet_id      = module.subnet_resource.private_subnet_id_result
  public_subnet_id       = module.subnet_resource.public_subnet_id_result
  vpc_security_group_ids = module.security_group_resource.sg_id_result
}
**/

##############################IMPORT-EC2####################################
/**
//to import ec2 which was created manually from AWS dashboard
resource "aws_instance" "imported_ec2" {
  instance_type = "t2.micro"
  ami = "ami-007020fd9c84e18c7"
  key_name = "global"
  subnet_id              = module.subnet_resource.public_subnet_id_result
  vpc_security_group_ids = [module.security_group_resource.sg_id_result]
  tags = {
    Name = "imported_ec2"
  }
}
**/
##########################################################################
