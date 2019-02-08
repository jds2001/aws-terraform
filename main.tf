provider "aws" {
   access_key = "${var.aws_access_key}"
   secret_key = "${var.aws_secret_key}"
   region = "us-east-1"
}

module "network" {
	source = "./modules/network"
}

module "ci_server" {
	source = "./modules/instance"

	ssh_public_key = "${var.ssh_public_key}"
	subnet_id = "${module.network.subnet_id}"
}

output "ci_public_ip" {
	value = "${module.ci_server.public_ip}"
}
