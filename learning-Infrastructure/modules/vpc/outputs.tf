

output "learn_dev_vpc_id" {
  value = aws_vpc.learn_dev_vpc.id
}

output "learn_dev_subnet_id" {
  value = aws_subnet.learn_dev_subnet.id
}

output "learn_dev_sg_id" {
  value = aws_security_group.learn_dev_sg.id
}


output "learn_dev_igw_id" {
  value = aws_internet_gateway.learn_dev_igw.id
}

