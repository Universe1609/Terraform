variable "SG_id_1" {
  default = "aws_security_group.SG-1.id"
}

variable "SG_id_2" {
  description = "id del segundo grupo de seguridad"
  default     = "aws_security_group.SG-2.id"
}

variable "vpc_id" {
  description = "id de la VPC"
  default     = "vpc-0bb9abd25ce31b901"
}
