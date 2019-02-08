resource "aws_key_pair" "main" {
   key_name = "main key"
   public_key = "${var.ssh_public_key}"
}

resource "aws_instance" "web" {
   subnet_id = "${var.subnet_id}"
   key_name = "${aws_key_pair.main.key_name}"
   ami = "${data.aws_ami.centos.id}"
   instance_type = "${var.instance_type}"
   root_block_device {
      delete_on_termination = true
      volume_size = 8
      volume_type = "gp2"
   }
/*   provisioner "remote-exec" {
      connection {
         type = "ssh"
         user = "centos"
      }
      inline = [ "echo hello world" ]
   }
   provisioner "local-exec" {
      command = "ansible-playbook --ssh-common-args='-o StrictHostKeyChecking=no' -u centos -i ${self.public_ip}, update.yml"
   } */
}
