output "security_group_fxp0_id" {
  value = aws_security_group.fxp0.id
}

output "security_group_ge000_id" {
  value = aws_security_group.ge-000.id
}

output "public_ips_fxp0" {
  value = aws_eip.eip_fxp0.*.public_ip
}

output "public_ips_ge000" {
  value = aws_eip.eip_ge000.*.public_ip
}

output "config_vsrx" {
  value = data.template_file.user_data.*.template
}