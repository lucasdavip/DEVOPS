variable "cidr_block" {
  type        = string
  description = "Endereço da rede"
}

variable "environment" {
  type        = string
  description = "Ambiente DEV/QA/STG/PROD etc..."
}

variable "project" {
  type        = string
  description = "Nome do projeto"
}
