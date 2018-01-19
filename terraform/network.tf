resource "aws_vpc" "cp2-network" {
    cidr_block = "${var.vpc-fullcidr}"
    tags {
      Name = "Cp2 vpc"
    }
}