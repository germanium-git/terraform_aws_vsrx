# Create Transit VPC
module "jnpr_aws_vpc" {
  source                  = "./modules/jnpr_aws_vpc"
  vpc_name                = var.vpc_name
  aws_region              = var.aws_region[var.vpc_name]
  vpc_nets                = var.vpc_nets[var.vpc_name]
  vpc_vsrx_subnet_outside = var.vpc_vsrx_subnet_outside[var.vpc_name]
  vpc_vsrx_subnet_inside  = var.vpc_vsrx_subnet_inside[var.vpc_name]
  vpc_vsrx_subnet_mng     = var.vpc_vsrx_subnet_mng[var.vpc_name]
  security_group_fxp0_id  = module.jnpr_aws_ec2.security_group_fxp0_id
  security_group_ge000_id = module.jnpr_aws_ec2.security_group_ge000_id
  ipoffset                = var.ipoffset
}

# Create vSRX EC2 instances
module "jnpr_aws_ec2" {
  source                  = "./modules/jnpr_aws_ec2"
  vpc_name                = var.vpc_name
  aws_region              = var.aws_region[var.vpc_name]
  jnpr_vpc_id             = module.jnpr_aws_vpc.vpc_default_id
  interfaces_fxp0_ids     = module.jnpr_aws_vpc.interfaces_fxp0_ids
  interfaces_ge000_ids    = module.jnpr_aws_vpc.interfaces_ge000_ids
  interfaces_ge001_ids    = module.jnpr_aws_vpc.interfaces_ge001_ids
  aws_vsrx_amis           = var.aws_vsrx_amis
  vsrx_instance_types     = var.vsrx_instance_types
  vsrx_user               = var.vsrx_user
  key_name                = module.key.key_name
  mymngip                 = var.mymngip
  vsrxcfg                 = var.vsrxcfg
  vpc_vsrx_subnet_outside = var.vpc_vsrx_subnet_outside[var.vpc_name]
  vpc_vsrx_subnet_inside  = var.vpc_vsrx_subnet_inside[var.vpc_name]
  ipoffset                = var.ipoffset
}

# Create SSH key
module "key" {
  source                  = "./modules/key"
  key_name                = var.key_name
  key_path                = var.key_path
  aws_region              = var.aws_region[var.vpc_name]
}