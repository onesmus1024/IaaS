

resource "aws_vpc" "learn_dev_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "learn_dev_vpc"
    }
}

resource "aws_subnet" "learn_dev_subnet" {
  vpc_id     = aws_vpc.learn_dev_vpc.id
  cidr_block = "10.0.1.0/24"

    tags = {
        Name = "learn_dev_subnet"
    }
}


resource "aws_security_group" "learn_dev_sg" {
  name        = "learn_dev_sg"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.learn_dev_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "learn_dev_sg"
    }

}

# internet gateway

resource "aws_internet_gateway" "learn_dev_igw" {
  vpc_id = aws_vpc.learn_dev_vpc.id

    tags = {
        Name = "learn_dev_igw"
    }
}

# route table

resource "aws_route_table" "learn_dev_rt" {
  vpc_id = aws_vpc.learn_dev_vpc.id



  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.learn_dev_igw.id
    }

    tags = {
        Name = "learn_dev_rt"
        }

}

# route table association

resource "aws_route_table_association" "learn_dev_rta" {
  subnet_id      = aws_subnet.learn_dev_subnet.id
  route_table_id = aws_route_table.learn_dev_rt.id


}




