resource "aws_subnet" "subnets" {
  vpc_id     = var.vpc_id
  for_each   = toset(var.subnets)
  cidr_block = each.value
  tags = {
    Name        = "subnet-${var.environment}-${var.project}"
    Environment = var.environment
    Project     = var.project
  }
}

