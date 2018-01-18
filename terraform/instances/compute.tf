resource "aws_instance" "cp2-instance" {
  ami = "${var.ami}"
  instance_type = "${var.cp2_instance_type}"
  tags {
    Name = "HelloWorld"
  }
  security_groups = [ "${aws_security_group.my_security_group.id}" ]
}