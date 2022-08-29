
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
# adding ansadmin user
sudo useradd -m -p ansadmin -s /bin/bash ansadmin
sudo usermod -a -G sudo ansadmin
sudo echo ansadmin:ansadmin | chpasswd
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart

# adding users to sudoers file
sudo echo 'ansadmin  ALL=(ALL:ALL) ALL' >> /etc/sudoers

# public key adding under ansadmin user. 
sudo cat 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1cdT8hFsndOBDS5ryIsZzJGsmf5UaCXHnUkjqgZcN7RLM2ZkMR33hDi9jP07DTdKSBUQ98L3YhkRMCxDq2gRH0//IwT1asBst2shnx3tCKLVZxeHX3VQRWt2CrvA8eqJE4/JUJNxlNJMjdXjKy2QmlG/f2uv+RLblkXvMVa2p4KPzpH3NNTKVYSpi/RkWlZBnxPuBHglpN9HBFRNXLj0fVYnvenDRMUYWtZd2v2of4UYKo/DPV5LPwDMc05+dIEbHu63yyxaVv+V66sJ49mzXg70BIZd73gE2EzK4OzF/6E6VJuKMwkKMqVJUxx3gZeLJA2W0sDKoz0gQtruQ1nGj4ItNbOyvBMSRxn0MmzAAZijIbv0DcD20mEcmolnItH0yAaqSkCQtaWDiPQ0H1r6yJaooDgmSiYqf2rxYmMCRo6krW0WuanExBtCx1yDsDcnzETIAGTzAZ+Jo07EdbJlVQyWYSHo2ZSV8lKJu+/w8W1fSLQFW5P7be+Dr4YUQRN8= root@Ansible-terraform-host' >> /home/ansadmin/.ssh/authorized_keys
sudo chown ansadmin:ansadmin /home/ansadmin/.ssh/authorized_keys
sudo chmod 644 /home/ansadmin/.ssh/authorized_keys
EOF
}
