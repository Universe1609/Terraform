data "aws_vpc" "my_vpc" {
  id = var.vpc_id
}

# data "aws_subnet" "subnet-1"{
#   id = var.subnet_id
# }


#--------------------------------------------------------------------------------------
resource "aws_subnet" "my_subnet_1" {
  vpc_id            = data.aws_vpc.my_vpc.id
  availability_zone = "us-east-2a"
  cidr_block        = cidrsubnet(data.aws_vpc.my_vpc.cidr_block, 4, 1)
  tags = {
    Name = var.subnet_1_name
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id            = data.aws_vpc.my_vpc.id
  availability_zone = "us-east-2b"
  cidr_block        = cidrsubnet(data.aws_vpc.my_vpc.cidr_block, 4, 2)
  tags = {
    Name = var.subnet_2_name
  }
}
#--------------------------------------------------------------------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.my_vpc.id
  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = data.aws_vpc.my_vpc.id
}

#-------------------------------------------------------------------
resource "aws_route" "r" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt-1" {
  subnet_id      = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "rt-2" {
  subnet_id      = aws_subnet.my_subnet_2.id
  route_table_id = aws_route_table.my_route_table.id
}

#---------------------------------------------------------------------


resource "aws_security_group" "SG-1" {
  name   = "SG-1"
  vpc_id = data.aws_vpc.my_vpc.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #[aws_vpc.my_vpc.cidr_block]
  security_group_id = aws_security_group.SG-1.id
}

resource "aws_security_group" "SG-2" {
  name   = "SG-2"
  vpc_id = data.aws_vpc.my_vpc.id
}

resource "aws_security_group_rule" "deny_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG-2.id
}
