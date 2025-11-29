variable "subnet_id" {
  description = "ID de la subnet pública donde se creará el NAT Gateway."
  type        = string
}

variable "tags" {
  description = "Tags adicionales para el NAT Gateway."
  type        = map(string)
  default     = {}
}
