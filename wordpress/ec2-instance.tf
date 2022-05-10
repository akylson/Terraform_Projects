# Creating EC2 Instance, download wordpress and configure environment for wordpress
 
resource "aws_instance" "wordpress-ec2" {
  ami               = "ami-0022f774911c1d690"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "wordpress"
  vpc_security_group_ids = [aws_security_group.wordpress-sg.id]
  subnet_id = aws_subnet.public-subnet-1.id

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo amazon-linux-extras install php7.4 -y   
              sudo yum install mysql -y          
              sudo cd /var/www/html/
              sudo wget https://wordpress.org/latest.zip
              sudo unzip latest.zip
              sudo mkdir /var/www/html/blog
              sudo cp -r wordpress/* /var/www/html/blog/
              sudo chown -R apache /var/www
              sudo chgrp -R apache /var/www
              sudo chmod 2775 /var/www
              sudo find /var/www -type d -exec sudo chmod 2775 {} \;
              sudo find /var/www -type f -exec sudo chmod 0644 {} \;
              sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/httpd/conf/httpd.conf
              sudo systemctl enable  httpd.service
              sudo systemctl start httpd 
              EOF

  tags = {
    Name = "Amazon linux 2 server"
  }

}

