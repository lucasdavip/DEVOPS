resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    name        = "vpc-${var.environment}-${var.project}"
    environment = var.environment
    project     = var.project
  }
}

