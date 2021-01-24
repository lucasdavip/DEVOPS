resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name        = "vpc-${var.environment}-${var.project}"
    Environment = var.environment
    Project     = var.project
  }
}

