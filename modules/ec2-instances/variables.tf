variable "ami" {
  default = "ami-0bde1eb2c18cb2abe"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "SG_id_1" {
  description = "id del grupo de seguridad SG-1"
  type        = string
}

variable "SG_id_2" {
  description = "id del grupo de seguridad SG-2"
  type        = string
}

variable "subnet_1" {
  description = "id de la subnet 1"
  type        = string
}
