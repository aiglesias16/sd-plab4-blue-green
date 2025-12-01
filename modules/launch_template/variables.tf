variable "name" {
  description = "Nombre del Launch Template."
  type        = string
}

variable "image_id" {
  description = "ID de la AMI para las instancias EC2."
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para la instancia."
  type        = list(string)
}

variable "key_name" {
  description = "Nombre de la clave SSH (opcional)."
  type        = string
  default     = null
}

variable "user_data" {
  description = "Script de inicialización (opcional)."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags adicionales para el Launch Template."
  type        = map(string)
  default     = {}
}
