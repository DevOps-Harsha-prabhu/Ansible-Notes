## generate inventory file for Ansible
#resource "local_file" "hosts_cfg" {
#  content = templatefile("hosts.tpl",
#    {
#      Ansible_client1 = aws_instance.Ansible-clients-1[*].public_ip
#      Ansible_client2 = aws_instance.Ansible-clients-2[*].public_ip
#    }
#  )
#  filename = "/etc/ansible/hosts.cfg"
#}
#
#