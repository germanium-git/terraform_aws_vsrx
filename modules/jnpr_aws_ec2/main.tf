provider "aws" {
  region = var.aws_region
}

resource "aws_eip" "eip_fxp0" {
  count             = 2
  vpc               = true
  network_interface = var.interfaces_fxp0_ids[count.index]
}

resource "aws_eip" "eip_ge000" {
  count             = 2
  vpc               = true
  network_interface = var.interfaces_ge000_ids[count.index]
}


data "template_file" "user_data" {
  count     = 2
  template  = templatefile("${path.module}/vsrx.tmpl",
  {
    hostname = var.vsrxcfg[count.index].host-name
    st0      = var.vsrxcfg[count.index].st0
    neighbor = var.vsrxcfg[count.index].neighbor
    onprem   = var.vsrxcfg[count.index].onprem
    localid  = var.vsrxcfg[count.index].localid
    defgw    = var.vsrxcfg[count.index].defgw
  })
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "test_profile"
  role = "CWLogsRole"
}

resource "aws_instance" "vsrx" {
  count                   = 2
  ami                     = var.aws_vsrx_amis[var.aws_region]
  instance_type           = var.vsrx_instance_types[var.aws_region]
  key_name                = var.key_name
  user_data               = data.template_file.user_data.*.template[count.index]
  depends_on              = [aws_eip.eip_fxp0, aws_eip.eip_ge000]
  disable_api_termination = false
  iam_instance_profile    = aws_iam_instance_profile.iam_profile.name

  network_interface {
    device_index = 0
    network_interface_id = var.interfaces_fxp0_ids[count.index]
  }
  network_interface {
    device_index = 1
    network_interface_id = var.interfaces_ge000_ids[count.index]
  }
  network_interface {
    device_index = 2
    network_interface_id = var.interfaces_ge001_ids[count.index]
  }

  tags = {
    Name = "vsrx-${count.index}-${var.vpc_name}"
  }
}

resource "aws_eip_association" "eip_assoc_ge000" {
  count                 = 2
  allocation_id         = aws_eip.eip_ge000[count.index].id
  network_interface_id  = var.interfaces_ge000_ids[count.index]
}

resource "aws_eip_association" "eip_assoc_fxp0" {
  count                 = 2
  allocation_id         = aws_eip.eip_fxp0[count.index].id
  network_interface_id  = var.interfaces_fxp0_ids[count.index]
}

data "aws_iam_role" "cwlogsrole" {
  name = "CWLogsRole"
}