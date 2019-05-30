resource "aws_security_group" "dremio-yarn-sec-grp" {
  name = "allow-all-sg-dremio-yarn"
  vpc_id = "${aws_vpc.dremio_yarn.id}"

  ingress {
    description = "SSH"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  ingress {
    description = "Ambari"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }
  ingress {
    description = "Zookeeper"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 2181
    to_port = 2181
    protocol = "tcp"
  }
  ingress {
    description = "TimelineClient"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8188
    to_port = 8188
    protocol = "tcp"
  }
  ingress {
    description = "WebHCat"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 50111
    to_port = 50111
    protocol = "tcp"
  }
  ingress {
    description = "DataNodes"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 50010
    to_port = 50010
    protocol = "tcp"
  }
  ingress {
    description = "YARN Resource Mgr"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8032
    to_port = 8032
    protocol = "tcp"
  }
  ingress {
    from_port = 0
    to_port = 8
    protocol = "icmp"
        cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
        cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description = "NameNodeWebUI"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 50070
    to_port = 50070
    protocol = "tcp"
  }
  ingress {
    description = "NameNodeMeta"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8020
    to_port = 8020
    protocol = "tcp"
  }
  ingress {
    description = "dremio"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 9047
    to_port = 9047
    protocol = "tcp"
  }

  ingress {
    description = "dremio"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 9083
    to_port = 9083
    protocol = "tcp"
  }

  ingress {
    description = "ODBC"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 31010
    to_port = 31010
    protocol = "tcp"
  }
  ingress {
    description = "DremioInterNode"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 45678
    to_port = 45678
    protocol = "tcp"
  }
  ingress {
    description = "XXX"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8670
    to_port = 8670
    protocol = "tcp"
  }
  ingress {
    description = "DremioInterNode"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8440
    to_port = 8441
    protocol = "tcp"

  }
  ingress {
    description = "DremioInterNode"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 50075
    to_port = 50075
    protocol = "tcp"

  }
  ingress {
    description = "SmartSense"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 9060
    to_port = 9060
    protocol = "tcp"
  }
  ingress {
    description = "Ranger_http"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 6080
    to_port = 6080
    protocol = "tcp"
  }
  ingress {
    description = "Ranger_https"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 6182
    to_port = 6182
    protocol = "tcp"
  }

  ingress {
    description = "SmartSense"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 9060
    to_port = 9060
    protocol = "tcp"
  }

  ingress {
    description = "XX"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 10000
    to_port = 10000
    protocol = "tcp"
  }
    ingress {
    description = "ResourceManager"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8088
    to_port = 8088
    protocol = "tcp"
  }
      ingress {
    description = "YARNConnection"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8050
    to_port = 8050
    protocol = "tcp"
  }
    ingress {
    description = "ResourceManager"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 2888
    to_port = 2888
    protocol = "tcp"
  }
      ingress {
    description = "ResourceManager"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 3888
    to_port = 3888
    protocol = "tcp"
  }

     ingress {
    description = "ResourceManager"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
  }

     ingress {
    description = "ATS"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 6188
    to_port = 6188
    protocol = "tcp"
  }
    // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

//network.tf
resource "aws_vpc" "dremio_yarn" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "dremio"
  }
}
//subnets.tf
resource "aws_subnet" "subnet-dremio-yarm" {
  cidr_block = "${cidrsubnet(aws_vpc.dremio_yarn.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.dremio_yarn.id}"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1b"
  depends_on = [
    "aws_internet_gateway.test-env-gw"]
}

resource "aws_eip" "ip-test-env" {
  vpc = true
  public_ipv4_pool = "amazon"
}

//gateways.tf
resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.dremio_yarn.id}"
  tags {
    Name = "dremio-gw"
  }
}

//subnets.tf
resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.dremio_yarn.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
  tags {
    Name = "test-env-route-table"
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id = "${aws_subnet.subnet-dremio-yarm.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}