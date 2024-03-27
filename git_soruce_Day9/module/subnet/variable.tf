variable "private_subnet_cidr" {
  default = "198.168.1.0/24"
}

variable "public_subnet_cidr" {
  default = "198.168.2.0/24"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_id" {}
