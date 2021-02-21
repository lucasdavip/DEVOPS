module "create_vpc" {
  source      = "./modules/network/vpc"
  cidr_block  = var.cidr_block_vpc
  environment = var.environment
  project     = var.project
}

module "create_subnets" {
  source      = "./modules/network/subnet"
  vpc_id      = module.create_vpc.vpc_id
  subnets     = var.subnets
  environment = var.environment
  project     = var.project
}
