
resource "aws_instance" "Ansible-Host" {
  #count                       = length(var.public_cidr_block)
  count                       = 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_admin.name
  tags = {
    Name        = "Ansible-terraform-Host"
    Deployed_by = local.Deployed_by
    owner       = local.owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}
