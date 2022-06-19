output "id" {
    description = "vpc id"
    value = aws_vpc.this.id
}

output "private_subnet_ids" {
    description = "private subnet id"
    value = [for subnet in aws_subnet.private: subnet.id]
}