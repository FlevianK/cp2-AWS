variable "ami" {
  type    = "string"
  default = ""
}

variable "cp2_instance_type" {
  type    = "string"
  default = "t2.micro"
}

variable “access_key” {}

variable “secret_key” {}

variable “region” {
  type    = "string"
  default = “us-east-1”
}
