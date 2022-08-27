
resource "aws_instance" "Ansible-clients" {
  #count                       = length(var.public_cidr_block)
  count                       = 2
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name        = "Ansible-client-${count.index + 1}"
    Deployed_by = local.Deployed_by
    owner       = local.owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
  user_data = <<-EOF
#! /bin/bash
sudo su - 
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
cat 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC169CGYGQztS3W/gw978AmiTBx7GR+olqsQ0GLj9VQWs8MxYVHecgk01bz6q7FVI+Ocsr8QZ+7Gw0kAkSgAc4CYNO8u3Y7+W+faBkvgPvV1CcvKrWQzkv7F7blCXYq8EwOq74M8lrccIvrajH7Tz1nzSpqTJijpG0s9PLWgrvZwQQsLb8xFEF5zUiUU8U9iFJbXF5yOt77AzoKEzN0H29T49IMJqRUstoDsiB7O0pKWBdsbF1DdUpF+NzT3+adqbRjIca2AEUEYKnHBnEL+C5KZOggs4wwEuQ0kDRw1KWty62CbuH6cbyrdwgiCSWKzyL2dItzDa+G2HXIFOnlW98adoaRExCRn4bd34kx6A9BQS1YBjo8T2rOvZXLWqAJTNIFwD8Xv4i2qlJywXUmA31r6c3MqFwbrO3A2tRrK85Gb67zHVlTGQ+3U3yJwaxgoWWSH6YE3dzT3/lFnB5VZA7kBNhHDFnaiENrx7skrC1OocAkIv0XBsei3tKpEbAeUhk= root@ansible-terraform-host' >> /home/ubuntu/.ssh/authorized_keys
chmod 400 /home/ubuntu/.ssh/authorized_keys
EOF
}
