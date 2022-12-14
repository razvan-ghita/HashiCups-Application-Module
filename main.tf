provider "aws" {
  region  = var.region
}

module "frontend" {
  source = "git::http://18.221.178.213/server-team/terraform-aws-server-module.git"
  name              = "frontend"
  tags              = { Owner = "jdoe@hashicorp.com", CostCenter = "12345", Environment = var.environment }
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.10"
  upstream_ip       = "10.140.101.11"

}

module "public_api" {
  source = "git::http://18.221.178.213/server-team/terraform-aws-server-module.git"
  name              = "public_api"
  tags              = { Owner = "jdoe@hashicorp.com", CostCenter = "12345", Environment = var.environment }
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.11"
  upstream_ip       = "10.140.101.12"

}

module "product_api" {
  source = "git::http://18.221.178.213/server-team/terraform-aws-server-module.git"
  name              = "product_api"
  tags              = { Owner = "jdoe@hashicorp.com", CostCenter = "12345", Environment = var.environment }
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.12"
  upstream_ip       = "10.140.101.13"

}

module "postgres" {
  source = "git::http://18.221.178.213/server-team/terraform-aws-server-module.git"
  name              = "postgres"
  tags              = { Owner = "jdoe@hashicorp.com", CostCenter = "12345", Environment = var.environment }
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.13"
  upstream_ip       = "10.140.101.14"
}

module "network" {
  source = "git::http://18.221.178.213/network-team/terraform-aws-network-module.git"
  name            = "Hashicups"
  private_subnets = ["10.140.1.0/24", "10.140.2.0/24", "10.140.3.0/24"]
  public_subnets  = ["10.140.101.0/24", "10.140.102.0/24", "10.140.103.0/24"]
  cidr_block      = "10.140.0.0/16"
}
