data "aws_ami" "centos" {
   most_recent = true
   filter {
      name = "product-code"
      values = [ "aw0evgkw8e5c1q413zgy5pjce" ]
   }
}

variable "instance_type" {
   default = "t2.micro"
}

variable "ssh_public_key" {}

variable "subnet_id" {}
