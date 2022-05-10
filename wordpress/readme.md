# AWS - Wordpress with Terraform

What is <b>WordPress</b>? At its core, WordPress is the simplest, most popular way to create your own website or blog. In fact, WordPress powers over 35.2% of all the websites on the Internet. Yes – more than one in four websites that you visit are likely powered by WordPress.
<br><br>
<b>WordPress</b> is an open-source content management system. A content management system is basically a tool that makes it easy to manage important aspects of your website – like content – without needing to know anything about programming.
<br><br>
The end result is that <b>WordPress</b> makes building a website accessible to anyone – even people who aren’t developers. Many years ago, WordPress was primarily a tool to create a blog, rather than more traditional websites. That hasn’t been true for a long time, though. Nowadays, thanks to changes to the core code, as well as WordPress’ massive ecosystem of plugins and themes, you can create any type of website with WordPress.

What we did here : 

1) Created a VPC named ‘wordpress-vpc’
2) Created an Internet Gateway named ‘wordpress_igw’.
3) Created a route table named ‘wordpess-rt’ and added Internet Gateway route to it.
4) Created 3 public and 3 private subnets in the us-east region. Associated them with the ‘wordpess-rt’ route table. 
5 Created a security group named ‘wordpress-sg’ and opened HTTP, HTTPS, SSH ports to the Internet. Defined port numbers in a variable named ‘ingress_ports’.
6) Created a key pair named ‘ssh-key’
7) Created an EC2 instance named ‘wordpress-ec2’. Used Amazon Linux 2 AMI, t2.micro, ‘wordpress-sg’ security group, ‘ssh-key’ key pair, public subnet 1.
8) Created a security group named ‘rds-sg’ and opened MySQL port and allowed traffic only from ‘wordpress-sg’ security group.
9) Created a MySQL DB instance named ‘mysql’: 20GB, gp2, t2.micro instance class, username=admin, password=adminadmin. Used ‘aws_db_subnet_group’ resource to define private subnets where the DB instance will be created.
