#vpc
resource "aws_vpc" "my_vpc" {
    cidr_block =var.vpc_cidr
    instance_tenancy = "default"
  tags = {
    Name= "my_vpc"
  }
}


#subnet

resource "aws_subnet" "subnets" {
  
  vpc_id = aws_vpc.my_vpc.id
  count=length(var.subnet_cidr)
  cidr_block = var.subnet_cidr[count.index]
  map_public_ip_on_launch = true
   availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = var.subnet_names[count.index]
  }
}


#internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

#route table

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    "Name" = "MyRouteTable"
  }
}
  # Route Table Association
resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id

  
}