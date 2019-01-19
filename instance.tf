data "aws_ami" "centos" {
   most_recent = true
   filter {
      name = "product-code"
      values = [ "aw0evgkw8e5c1q413zgy5pjce" ]
   }
}

resource "aws_key_pair" "main" {
   key_name = "main key"
   public_key = "${var.ssh_public_key}"
}

resource "aws_instance" "web" {
   subnet_id = "${aws_subnet.public_subnet.id}"
   key_name = "${aws_key_pair.main.key_name}"
   ami = "${data.aws_ami.centos.id}"
   instance_type = "t2.micro"
}

output "public_ip" {
   value = "${aws_instance.web.public_ip}"
}
