output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_id"{
    value = aws_subnet.publicsubnet.id
}
output "subnet_id1"{
    value = aws_subnet.privatesubnet.id
}
output "nat_gateway_id" {
    value = aws_nat_gateway.natgw.id
}