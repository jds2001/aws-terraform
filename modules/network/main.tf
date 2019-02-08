resource "aws_vpc" "main" {
   cidr_block = "172.18.0.0/16"
   enable_dns_hostnames = "true"
}

resource "aws_subnet" "public_subnet" {
   vpc_id = "${aws_vpc.main.id}"
   cidr_block = "172.18.0.0/24"
   map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "gw" {
   vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route" "internet" {
   route_table_id = "${aws_vpc.main.main_route_table_id}"
   destination_cidr_block = "0.0.0.0/0"
   gateway_id = "${aws_internet_gateway.gw.id}"
}

resource "aws_default_security_group" "default" {
   vpc_id = "${aws_vpc.main.id}"
   ingress {
      cidr_blocks = ["96.126.108.98/32", "66.175.210.226/32"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
   }
   ingress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
   }
   ingress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 443
      to_port = 443
      protocol = "tcp"
   }
   egress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = -1
   }
}
