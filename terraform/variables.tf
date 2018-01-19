variable "cp2_instance_type" {
  type = "string"
}
variable “region” {
  type    = "string"
}
variable "cp2-ami" {
  type = "string"
}
variable "credentialsfile" {
  type = "string"
}
variable "vpc-fullcidr" {
  type = "string"
}
variable "subnet-public-nat-gw-CIDR" {
  type = "string"
}
variable "subnet-private-nat-gw-CIDR" {
  type = "string"
}
variable "key_name" {
  type = "string"
  description = "the ssh key to use in the EC2 machines"
}