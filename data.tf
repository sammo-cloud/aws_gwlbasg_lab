data "aws_vpc" "vpc_egress" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  tags = {
    Name = "${var.project_name}-GWLB-VPCStack-*"
  }
}

data "aws_subnet" "sn_egress_gwlbe_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags = {
    Name = "GWLBe subnet 1"
  }
}

data "aws_subnet" "sn_egress_gwlbe_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags =  {
    Name = "GWLBe subnet 2"
  }
}

data "aws_subnet" "sn_egress_natgw_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags =  {
    Name = "NAT subnet 1"
  }
}

data "aws_subnet" "sn_egress_natgw_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags =  {
    Name = "NAT subnet 2"
  }
}

data "aws_subnet" "sn_egress_tgw_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags =  {
    Name = "TGW subnet 1"
  }
}

data "aws_subnet" "sn_egress_tgw_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags =  {
    Name = "TGW subnet 2"
  }
}

data "aws_subnet" "sn_egress_public_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  vpc_id = data.aws_vpc.vpc_egress.id
  tags =  {
    Name = "Public subnet 1"
  }
}

data "aws_route_table" "rt_egress_gwlbe_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_gwlbe_a.id
}

data "aws_route_table" "rt_egress_gwlbe_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_gwlbe_b.id
}

data "aws_route_table" "rt_egress_natgw_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_natgw_a.id
}

data "aws_route_table" "rt_egress_natgw_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_natgw_b.id
}

data "aws_route_table" "rt_egress_tgw_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_tgw_a.id
}

data "aws_route_table" "rt_egress_tgw_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_tgw_b.id
}

data "aws_route_table" "rt_egress_public" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  subnet_id = data.aws_subnet.sn_egress_public_a.id
}

data "aws_vpc_endpoint_service" "endpoint_service_gwlb" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  service_type = "GatewayLoadBalancer"
}

data "aws_route" "r_egress_tgw_a_tointernet" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  route_table_id = data.aws_route_table.rt_egress_tgw_a.id
  destination_cidr_block = "0.0.0.0/0"
}

data "aws_route" "r_egress_tgw_b_tointernet" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  route_table_id = data.aws_route_table.rt_egress_tgw_b.id
  destination_cidr_block = "0.0.0.0/0"
}

data "aws_subnet" "sn_gwlb_tgwha_a" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
  filter {
    name   = "tag:Name"
    values = ["TGW subnet 1"]
  }
}

data "aws_subnet" "sn_gwlb_tgwha_b" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
 filter {
    name   = "tag:Name"
    values = ["TGW subnet 2"]
  }
}

data "aws_instance" "ins_management" {
  depends_on = [
    aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack,
  ]
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-management-server"]
  }
}
