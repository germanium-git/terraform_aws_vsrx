output "public_ips_fxp0" {
  value = module.jnpr_aws_ec2.public_ips_fxp0
}

output "public_ips_ge000" {
  value = module.jnpr_aws_ec2.public_ips_ge000
}


output "fxp0_ip" {
  value = module.jnpr_aws_vpc.fxp0_ip
}

output "ge000_ip" {
  value = module.jnpr_aws_vpc.ge000_ip
}

output "key_id" {
  value = module.key.key_id
}

output "key_name" {
  value = module.key.key_name
}
