# Creating RDS - Mysql Database

resource "aws_db_instance" "wordpress_db" {
    allocated_storage = 20
    engine = "mysql"
    storage_type = "gp2"
    db_name = "wordpress"
    engine_version = "8.0.25"
    instance_class = "db.t2.micro"
    username = "admin"
    password = "adminadmin"
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.rds-sg.id]
    db_subnet_group_name = aws_db_subnet_group.mysql.name

}

resource "aws_db_subnet_group" "mysql" {
  name       = "mysql"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]

  tags = {
    Name = "private-subnetGroup"
  }
}



