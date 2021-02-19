output "vpc_default_id" {
  value = aws_vpc.default.id
}

output "interfaces_fxp0_ids" {
  value = aws_network_interface.fxp0.*.id
}

output "interfaces_ge000_ids" {
  value = aws_network_interface.ge000.*.id
}

output "interfaces_ge001_ids" {
  value = aws_network_interface.ge001.*.id
}

output "fxp0_ip" {
  value = aws_network_interface.fxp0.*.private_ip
}

output "ge000_ip" {
  value = aws_network_interface.ge000.*.private_ip
}

output "ge001_ip" {
  value = aws_network_interface.ge001.*.private_ip
}