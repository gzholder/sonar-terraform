# Create VPC
resource "aws_vpc" "sonar_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Sonar VPC"
  }
}

# Create Internet Gateway to allow Internet access
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.sonar_vpc.id

  tags = {
    Name = local.internet_gateway_name
  }
}

# Create a public and private subnet
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.sonar_vpc.id
# cidr_block              = element(var.public_subnet_cidrs, count.index)
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.a_zones[count.index]

  tags = {
    Name = "Public Subnet ${count.index +1 }"
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.sonar_vpc.id
# cidr_block              = element(var.public_subnet_cidrs, count.index)
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = var.a_zones[count.index]

  tags = {
    Name = "Private Subnet ${count.index +1 }"
  }
}

resource "aws_eip" "elastic_ip" {
  tags = {
    Name = "sonar_elastic_ip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id     = aws_eip.elastic_ip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnets[0].id

  tags = {
    Name = "sonar_nat_gateway"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}


# Create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.sonar_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate Route Table
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

