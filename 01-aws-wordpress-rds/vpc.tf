# Creating AWS VPC for Our Wordpress 

resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "wordpress-vpc"
  }
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "wordpress-igw" {
  vpc_id = aws_vpc.wordpress-vpc.id
  tags = {
    Name = "wordpress-igw"
  }
}


# Creating NAT Gateway for Private Subnets with EIP
resource "aws_eip" "nat_gw_eip" {
  vpc = true
}
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id
}


# Creating a Route Table for public subnets 
resource "aws_route_table" "wordpress-rt" {
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress-igw.id
  }
  tags = {
    Name = "Wordpress routetable"
  }
}

# Creating Route Table for private subnets
resource "aws_route_table" "my_vpc_us_east_1a_nated" {
    vpc_id = aws_vpc.wordpress-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw.id
    }
    tags = {
        Name = "Main Route Table for NAT-ed subnet"
    }
}

# Creating public subnets and attaching it to our VPC 
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-3"
  }
}

# Creating private subnets and attaching it to our VPC 

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-3"
  }
}


# Assign our subnets to Route table 
resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.wordpress-rt.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.wordpress-rt.id
}
resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.wordpress-rt.id
}

resource "aws_route_table_association" "private-subnet-1" {
    subnet_id = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.my_vpc_us_east_1a_nated.id
}
resource "aws_route_table_association" "private-subnet-2" {
    subnet_id = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.my_vpc_us_east_1a_nated.id
}
resource "aws_route_table_association" "private-subnet-3" {
    subnet_id = aws_subnet.private-subnet-3.id
    route_table_id = aws_route_table.my_vpc_us_east_1a_nated.id
}

