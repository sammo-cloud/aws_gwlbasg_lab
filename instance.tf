################################
## Spoke A Instance
################################

resource "aws_instance" "ins_spoke_a" {
    ami                         = "ami-0e3c5f2a606a86873"
    availability_zone           = "${var.aws_region}a"
    ebs_optimized               = false
    instance_type               = "t2.nano"
    monitoring                  = false
    key_name                    = "${var.project_name} TPOT Key"
    subnet_id                   = aws_subnet.sn_spoke_a_public_a.id
    vpc_security_group_ids      = [aws_security_group.sg_spoke_a.id]
    associate_public_ip_address = true
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

  tags = {
    Name = "${var.project_name} Spoke A Instance"
  }
}

resource "aws_security_group" "sg_spoke_a" {
  name        = "${var.project_name}-Permissive"
  description = "${var.project_name} Permissive"
  vpc_id      = aws_vpc.vpc_spoke_a.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name} Spoke A Permissive SG"
  }
}

################################
## Spoke B Instance
################################

resource "aws_instance" "ins_spoke_b" {
    ami                         = "ami-0e3c5f2a606a86873"
    availability_zone           = "${var.aws_region}a"
    ebs_optimized               = false
    instance_type               = "t2.nano"
    monitoring                  = false
    key_name                    = "${var.project_name} TPOT Key"
    subnet_id                   = aws_subnet.sn_spoke_b_public_a.id
    vpc_security_group_ids      = [aws_security_group.sg_spoke_b.id]
    associate_public_ip_address = true
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

  tags = {
    Name = "${var.project_name} Spoke B Instance"
  }
}

resource "aws_security_group" "sg_spoke_b" {
  name        = "${var.project_name}-Permissive"
  description = "${var.project_name} Permissive"
  vpc_id      = aws_vpc.vpc_spoke_b.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name} Spoke B Permissive SG"
  }
}

################################
## Ingress Jumphost Instance
################################

resource "aws_instance" "ins_jumphost" {
  depends_on = [aws_cloudformation_stack.checkpoint_gwlb_cloudformation_stack]
    ami                         = "ami-0e3c5f2a606a86873"
    availability_zone           = "${var.aws_region}a"
    ebs_optimized               = false
    instance_type               = "t2.nano"
    monitoring                  = false
    key_name                    = "${var.project_name} TPOT Key"
    subnet_id                   = aws_subnet.sn_ingress_alb_a.id
    vpc_security_group_ids      = [aws_security_group.sg_jumphost.id]
    associate_public_ip_address = true
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

  timeouts {
    create = "60m"
    delete = "60m"
  }

  tags = {
    Name = "${var.project_name} Jumphost Instance"
  }

connection {
      host        = aws_instance.ins_jumphost.public_ip
      user        = "bitnami"
      type        = "ssh"
      private_key = file("tpot.pem")
      timeout     = "60m"
}

provisioner "file" {
    source      = "tpot.pem"
    destination = "/home/bitnami/tpot.pem"
}

provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/bitnami/tpot.pem"
    ]
  }
}

resource "aws_security_group" "sg_jumphost" {
  name        = "${var.project_name}-Permissive"
  description = "${var.project_name} Permissive"
  vpc_id      = aws_vpc.vpc_ingress.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name} Jumphost Permissive SG"
  }
}

