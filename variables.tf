variable "aws_region" {
  type = map(string)
  default = {
    tvpc1 = "eu-north-1"
  }
}

variable "vpc_name" {
  type = string
  default = "tvpc1"
}

variable "vpc_nets" {
  type = map(string)
  default = {
    tvpc1 = "10.10.128.0/17"
  }
}

variable "vpc_vsrx_subnet_outside" {
  type    = map(list(string))
  default = {
    tvpc1 = [ "10.10.128.0/24", "10.10.144.0/24" ]
  }
}

variable "vpc_vsrx_subnet_inside" {
  type    = map(list(string))
  default = {
    tvpc1 = [ "10.10.130.0/24", "10.10.146.0/24" ]
  }
}

variable "vpc_vsrx_subnet_mng" {
  type    = map(list(string))
  default = {
    tvpc1 = [ "10.10.129.0/24", "10.10.145.0/24" ]
  }
}

variable "aws_vsrx_amis" {
  description = "vSRX Next Generation Firewall BYOL"
  type = map(string)
  default = {
    eu-west-1   = "ami-05a0e75e4d438fb7a"
    eu-north-1  = "ami-0ab415f9d575ac4dd"
  }
}

variable "vsrx_instance_types" {
  description = "Flavor of vSRX image"
  type = map(string)
  default = {
    eu-west-1   = "c5.large"
    eu-north-1  = "c5.large"
  }
}

variable "vsrx_user" {
  default = "root"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "mykey"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "./key/id_rsa.pub"
}

variable "vsrx_host_name" {
  type = map(list(string))
  default = {
    tvpc1 = [ "host-transit1-1", "host-transit1-2"]
  }
}

variable "mymngip" {
  type = map(list(string))
  default = {
    tvpc1 = ["131.207.242.5/32", "185.230.172.74/32"]
  }
}

variable "vsrxcfg" {
  type = list(map(string))
  default = [
    { host-name = "vsrx1"
      st0       = "169.254.43.46/30"
      neighbor  = "169.254.43.45"
      defgw     = "10.10.128.1"
      onprem    = "185.230.172.74"
      localid   = "1.2.3.4"
    },
    { host-name = "vsrx2"
      st0       = "169.254.43.50/30"
      neighbor  = "169.254.43.49"
      defgw     = "10.10.144.1"
      onprem    = "185.230.172.74"
      localid   = "5.6.7.8"
    }
  ]
}
