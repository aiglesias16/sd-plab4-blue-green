variable "name" {
  description = "Nombre del ALB."
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subredes donde desplegar el ALB."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para el ALB."
  type        = list(string)
}

variable "internal" {
  description = "Si el ALB es interno (true) o externo (false)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags adicionales para el ALB."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID de la VPC donde se crean los target groups."
  type        = string
}

variable "blue_weight" {
  description = "Peso para el target group blue."
  type        = number
  default     = 50
}

variable "green_weight" {
  description = "Peso para el target group green."
  type        = number
  default     = 50
}
