provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "default" {
  cidr_block = var.vpc_nets

  tags = {
    Name = var.vpc_name
  }
}

data "aws_availability_zones" "azs" {}

resource "aws_subnet" "vsrx-subnet-outside" {
  count             = 2
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.vpc_vsrx_subnet_outside[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "vsrx-subnet${count.index}-${var.vpc_name}"
  }
}


resource "aws_subnet" "vsrx-subnet-inside" {
  count             = 2
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.vpc_vsrx_subnet_inside[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "vsrx-subnet${count.index}-${var.vpc_name}"
  }
}

resource "aws_subnet" "vsrx-subnet-mng" {
  count             = 2
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.vpc_vsrx_subnet_mng[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "vsrx-subnet${count.index}-${var.vpc_name}"
  }
}


resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "igw-${var.vpc_name}"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_network_interface" "fxp0" {
  count             = 2
  subnet_id         = aws_subnet.vsrx-subnet-mng.*.id[count.index]
  security_groups   = [var.security_group_fxp0_id]
}

resource "aws_network_interface" "ge000" {
  count             = 2
  subnet_id         = aws_subnet.vsrx-subnet-outside.*.id[count.index]
  security_groups   = [var.security_group_ge000_id]
  source_dest_check = false
}

resource "aws_network_interface" "ge001" {
  count             = 2
  subnet_id         = aws_subnet.vsrx-subnet-inside.*.id[count.index]
  source_dest_check = false
}