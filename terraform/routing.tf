data "aws_availability_zones" "available" {}


resource "aws_internet_gateway" "cp2-gw" {
   vpc_id = "${aws_vpc.cp2-network.id}"
    tags {
        Name = "Generate cp2 internal getway"
    }
}
resource "aws_network_acl" "all" {
   vpc_id = "${aws_vpc.cp2-network.id}"
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "open acl"
    }
}
resource "aws_route_table" "cp2-public" {
  vpc_id = "${aws_vpc.cp2-network.id}"
  tags {
      Name = "Public"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.cp2-gw.id}"
    }
}
resource "aws_eip" "cp2-Nat" {
    vpc      = true
}
resource "aws_nat_gateway" "cp2-nat-gw" {
    allocation_id = "${aws_eip.cp2-Nat.id}"
    subnet_id = "${aws_subnet.cp2-nat-gw.id}"
    depends_on = ["aws_internet_gateway.cp2-gw"]
}
resource "aws_route_table" "cp2-private" {
  vpc_id = "${aws_vpc.cp2-network.id}"
  tags {
      Name = "Private"
  }
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.cp2-nat-gw.id}"
  }
}