# Printing out Outputs 

output "my_server_ip" {
  value = aws_instance.wordpress-ec2.public_ip
}

output "db_access_from_ec2" {
  value = "mysql -h ${aws_db_instance.wordpress_db.address} -P ${aws_db_instance.wordpress_db.port} -u username -p password"
}

output "access" {
  value = "http://${aws_instance.wordpress-ec2.public_ip}/blog/index.php"
}

