variable "name" {
  description = "Nombre del Security Group."
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el Security Group."
  type        = string
}

variable "ingress" {
  description = "Reglas de entrada (ingress) para el Security Group."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    security_groups = list(string)
    description = string
  }))
  default = []
}

variable "egress" {
  description = "Reglas de salida (egress) para el Security Group."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "tags" {
  description = "Tags adicionales para el Security Group."
  type        = map(string)
  default     = {}
}

variable "security_groups" {
  description = "Lista de security groups permitidos en las reglas de entrada."
  type        = list(string)
  default     = []
}
