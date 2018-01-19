
resource "aws_subnet" "cp2-public-nat-gw" {
  vpc_id = "${aws_vpc.cp2-network.id}"
  cidr_block = "${var.subnet-public-nat-gw-CIDR}"
  tags {
        Name = "cp2-public-nat-gw"
  }
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
}
resource "aws_route_table_association" "cp2-public-nat-gw" {
    subnet_id = "${aws_subnet.cp2-public-nat-gw.id}"
    route_table_id = "${aws_route_table.cp2-public.id}"
}
resource "aws_subnet" "cp2-private-nat-gw" {
  vpc_id = "${aws_vpc.cp2-network.id}"
  cidr_block = "${var.subnet-private-nat-gw-CIDR}"
  tags {
        Name = "cp2-private-nat-gw"
  }
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}
resource "aws_route_table_association" "cp2-private-nat-gw" {
    subnet_id = "${aws_subnet.cp2-private-nat-gw.id}"
    route_table_id = "${aws_route_table.cp2-private.id}"
}