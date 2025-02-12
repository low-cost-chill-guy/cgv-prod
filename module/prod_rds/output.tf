#aws_rds_variable
output "write_instance_az_a_endpoint" {
  value = aws_rds_writer_az_a.endpoint
}

output "read_instance_az_a_endpoint" {
  value = aws_rds_reader_az_a.endpoint
}

output "write_instance_az_c_endpoint" {
  value = aws_rds_writer_az_c.endpoint
}

output "read_instance_az_c_endpoint" {
  value = aws_rds_reader_az_c.endpoint
}
