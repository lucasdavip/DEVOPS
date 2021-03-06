variable "instance_type" {
  type        = string
  description = "Tipo de instancia"
}

variable "tagname" {
  type        = string
  description = "Nome da instancia"
}

variable "vpc_id" {
  type        = string
  description = "ID da vpc"
}

variable "cidr_block_443" {
  type        = list(string)
  description = "Bloco para liberacao publica do rundeck no https"
}

variable "cidr_block_4440" {
  type        = list(string)
  description = "Bloco para liberação publica do rundeck porta padrao"
}

variable "cidr_block_ssh" {
  type        = list(string)
  description = "Bloco para liberacao publica do ssh"
}

variable "az" {
  type        = string
  description = "AZ"
}

variable "volume_size" {
  type        = number
  description = "Tamanho do disco do rundeck"
}

variable "device_name" {
  type        = string
  description = "volume name"
}

variable "key_ssh" {
  type        = string
  description = "Chave ssh .pem"
}
