provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_id = var.vpc_id
}

module "ec2-instances" {
  source = "./modules/ec2-instances"

  #Pasamos el ID de los GS del modulo VPC al modulo EC2
  SG_id_1 = module.vpc.security_group_id_1
  SG_id_2 = module.vpc.security_group_id_2

  subnet_1 = module.vpc.subnet_id_1
}

module "ELB" {
  source = "./modules/ELB"

  SG_id_1     = module.vpc.security_group_id_1
  subnet_1    = module.vpc.subnet_id_1
  instancia_1 = module.ec2-instances.instancia_1
  instancia_2 = module.ec2-instances.instancia_2
}

module "S3" {
  source = "./modules/S3"
}

module "IAM" {
  source = "./modules/IAM"
}

module "RDS" {
  source = "./modules/rds_instace"
}

module "AUTO-SCALING" {
  source = "./modules/AUTO-SCALING"
}

