resource "aws_instance" "cp2-app" {
  ami           = "${var.cp2-ami}"
  instance_type = "${var.cp2-instance-type}"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.cp2-nat-gw.id}"
  vpc_security_group_ids = ["${aws_security_group.cp2-sp.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "cp2-app"
  }
  user_data = "/home/vof/start_cp.sh"
}
