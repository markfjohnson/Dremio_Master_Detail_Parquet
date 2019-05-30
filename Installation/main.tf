

provider "aws" {
  region = "us-west-1"
}

locals {
  image_id  = "ami-074e2d6769f445be5"
  keyname   = "westncal"
  ambari_image_id = "ami-00c78c2850f7381f0"
  hdp_agent_image_id = "ami-03a11e4666b75ab76"
  dremio_coord_image_id = "ami-08f9068051ec5bfbf"
}
// Define the Hadoop cluster
resource "aws_instance" "ambari" {
  ami = "${local.ambari_image_id}"
  key_name = "${local.keyname}"
  instance_type = "t2.medium"
    ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = true
  }
  count = 1
  tags = {
    Name = "Ambari"
  }
  security_groups = [
    "${aws_security_group.dremio-yarn-sec-grp.id}"]
  tags = {
    Name = "ambari-${count.index +1}"
  }
  subnet_id = "${aws_subnet.subnet-dremio-yarm.id}"
}

resource "aws_instance" "hdp-agent" {
  ami = "${local.hdp_agent_image_id}" #centos7 base
  key_name = "${local.keyname}"

  instance_type = "t2.2xlarge"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = true
  }

  count = 6
  security_groups = [
    "${aws_security_group.dremio-yarn-sec-grp.id}"]
  tags = {
    Name = "HDP-Agent-${count.index +1}"
  }
  subnet_id = "${aws_subnet.subnet-dremio-yarm.id}"
}
//
//resource "aws_instance" "hdp-master" {
//  ami = "${local.hdp_agent_image_id}" #centos7 base
//  key_name = "${local.keyname}"
//
//  instance_type = "t2.xlarge"
//  ebs_block_device {
//    device_name = "/dev/sda1"
//    volume_type = "gp2"
//    volume_size = 100
//    delete_on_termination = true
//  }
//
//  count=1
//  security_groups = [
//    "${aws_security_group.dremio-yarn-sec-grp.id}"]
//  tags = {
//    Name = "HDP-Master-${count.index +1}"
//  }
//  subnet_id = "${aws_subnet.subnet-dremio-yarm.id}"
//}

// Define the Dremio Coordinator edge node
resource "aws_instance" "master_coordinator" {
  ami = "${local.dremio_coord_image_id}"
  key_name = "${local.keyname}"
  instance_type = "t2.2xlarge"
    ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = true
  }
  count = 1
  tags = {
    Name = "D_Master_YARN-${count.index +1}"
  }
  security_groups = [
    "${aws_security_group.dremio-yarn-sec-grp.id}"]

  subnet_id = "${aws_subnet.subnet-dremio-yarm.id}"


}



resource "aws_instance" "executor" {
  ami = "${local.image_id}"
  key_name = "${local.keyname}"

  instance_type = "m4.2xlarge"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 20
    delete_on_termination = true
  }

  count =1
  security_groups = [
    "${aws_security_group.dremio-yarn-sec-grp.id}"]
  tags = {
    Name = "D_Executor-${count.index +1}"
  }
  subnet_id = "${aws_subnet.subnet-dremio-yarm.id}"
}



# Output variables.
# Dremio components
output "master_public_ip" {
  value = "${aws_instance.master_coordinator.*.public_ip}"
}
output "master_public_dns" {
  value = "${aws_instance.master_coordinator.*.public_dns}"
}
output "master_private_ip" {
  value = "${aws_instance.master_coordinator.*.private_ip}"
}
output "master_private_dns" {
  value = "${aws_instance.master_coordinator.*.private_dns}"
}
output "executor_public_ip" {
  value = "${aws_instance.executor.*.public_ip}"
}
output "executor_public_dns" {
  value = "${aws_instance.executor.*.public_dns}"
}
output "executor_private_ip" {
  value = "${aws_instance.executor.*.private_ip}"
}
output "executor_private_dns" {
  value = "${aws_instance.executor.*.private_dns}"
}

# HDP Components
output "ambari_public_ip" {
  value = "${aws_instance.ambari.*.public_ip}"
}
output "ambari_private_ip" {
  value = "${aws_instance.ambari.*.private_ip}"
}
output "ambari_private_dns" {
  value = "${aws_instance.ambari.*.private_dns}"
}


output "hdp_agent_public_ip" {
  value = "${aws_instance.hdp-agent.*.public_ip}"
}

output "hdp_agent_private_ip" {
  value = "${aws_instance.hdp-agent.*.private_ip}"
}


output "hdp_agent_private_dns" {
  value = "${aws_instance.hdp-agent.*.private_dns}"
}

output "hdp_agent_public_dns" {
  value = "${aws_instance.hdp-agent.*.public_dns}"
}


//output "hdp_master_public_ip" {
//  value = "${aws_instance.hdp-master.*.public_ip}"
//}
//
//output "hdp_master_private_ip" {
//  value = "${aws_instance.hdp-master.*.private_ip}"
//}
//
//
//output "hdp_master_private_dns" {
//  value = "${aws_instance.hdp-master.*.private_dns}"
//}
//
//output "hdp_master_public_dns" {
//  value = "${aws_instance.hdp-master.*.public_dns}"
//}



