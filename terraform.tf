terraform {
  /* vcs 연동시 제외
  cloud {
    organization = "hognod1"

    workspaces {
      name = "terraform-cloud"
    }
  }
*/
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
    }
  }

  required_version = ">= 1.1.0"
}
/*
resource "aws_security_group" "do_kim-TFE" {
  name = "do_kim-TFE"
  tags = {
    Name = "do_kim-TFE"
  }

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
}
*/

locals {
  sg_csv   = file("./csv_file.csv")
  sg_rules = csvdecode(local.sg_csv)
}

resource "aws_security_group" "sg" {
  for_each  = { for sg in local.sg_rules : sg.key => sg }
  rule_type = each.value.rule_type
  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol
  src_type  = each.value.src_type
  src       = each.value.src
}
