data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "sg_rundeck" {
  name        = var.tagname
  description = "Possibilita trafego do rundeck"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_443
  }

  ingress {
    description = "Porta padrao do rundeck"
    from_port   = 4440
    to_port     = 4440
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_4440
  }

  ingress {
    description = "Porta ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_block_ssh
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgrundeck"
  }
}

resource "aws_instance" "rundeck" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_rundeck.id]
  key_name               = var.key_ssh
  availability_zone      = var.az


  tags = {
    Name = var.tagname
  }

  depends_on = [
    aws_security_group.sg_rundeck
  ]
}

resource "aws_ebs_volume" "rundeck" {
  availability_zone = var.az
  size              = var.volume_size
  tags = {
    Name = var.tagname
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.rundeck.id
  instance_id = aws_instance.rundeck.id

  depends_on = [
    aws_ebs_volume.rundeck,
    aws_instance.rundeck
  ]
}

resource "null_resource" "configurandoAnsibleHost" {

  provisioner "local-exec" {
    command = "echo ${aws_instance.rundeck.public_ip} >> ../ansible/hosts"
  }

  depends_on = [
    aws_ebs_volume.rundeck,
    aws_instance.rundeck,
    aws_volume_attachment.ebs_att
  ]
}

resource "null_resource" "configurandoRundeck" {

  provisioner "local-exec" {
    command = "ansible-playbook --private-key ../lgomes.pem -i ../ansible/hosts ../ansible/create_rundeck.yml"
  }

  depends_on = [null_resource.configurandoAnsibleHost]
}
