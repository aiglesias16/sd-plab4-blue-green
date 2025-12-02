variable "name" {
  description = "Nombre del Auto Scaling Group."
  type        = string
}

variable "launch_template_id" {
  description = "ID del Launch Template a usar."
  type        = string
}

variable "launch_template_version" {
  description = "Versión del Launch Template."
  type        = string
  default     = "$Latest"
}

variable "vpc_zone_identifier" {
  description = "Lista de IDs de subredes donde desplegar el ASG."
  type        = list(string)
}

variable "min_size" {
  description = "Número mínimo de instancias."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Número máximo de instancias."
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Capacidad deseada de instancias."
  type        = number
  default     = 2
}

variable "target_group_arns" {
  description = "Lista de ARNs de target groups para el ASG."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags adicionales para el ASG."
  type        = map(string)
  default     = {}
}
