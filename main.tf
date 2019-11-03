provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

data "aws_availability_zones" "available" {}

module "base" {
  source =  "./base/"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  aws_region = "${var.aws_region}"
  vpc_name    = "${var.vpc_name}"
  dev_instance_type = "${var.dev_instance_type}"
  dev_ami = "${var.dev_ami}"

  key_name = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"

  cidrs_subnet1 = "${var.cidrs_subnet1}"
  cidrs_subnet2 = "${var.cidrs_subnet2}"
  cidrs = "${var.cidrs}"
  }
