variable "rule_type" {} # ingress / egress
variable "protocol" {} # tcp / udp / icmp
variable "from_port" {}
variable "to_port" {}
variable "src_type" {} # cidr(list) / pl(list) / sg
variable "src" {}

resource "aws_security_group" "sg" {
  
  ingress {
    from_port = var.from_port
    to_port = var.to_port
    protocol = var.protocol
    cidr_blocks = [var.src]
  }
}
