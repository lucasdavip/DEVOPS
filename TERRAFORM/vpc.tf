module "create_vpc" {
  source      = "./modules/network/vpc"
  cidr_block  = var.cidr_block_vpc
  environment = var.environment
  project     = var.project
}
