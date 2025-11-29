variable "vpc_id" {
  description = "ID de la VPC donde se creará el Internet Gateway."
  type        = string
}

variable "tags" {
  description = "Tags adicionales para el Internet Gateway."
  type        = map(string)
  default     = {}
}
