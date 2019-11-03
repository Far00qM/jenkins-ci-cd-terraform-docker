variable "access_key"{}
variable "secret_key"{}
variable "aws_region" {}
variable "dev_instance_type" {}
variable "dev_ami" {}
variable "cidrs_subnet1" {}
variable "cidrs_subnet2" {}
variable "key_name" {}
variable "vpc_name" {}

variable "public_key_path" {}
variable "private_key_path" {}
variable "cidrs" {
  type = "map"
}
