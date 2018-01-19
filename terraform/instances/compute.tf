resource "aws_instance" "cp2-app" {
  ami           = "${var.ami}"
  instance_type = "${var.cp2-instance-type}"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "cp2-app"
  }
  user_data =  "/home/vof/start_cp.sh"
}