# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tpl",
    {
      Ansible_client1 = aws_instance.Ansible-clients.public_ip[0]
      Ansible_client2 = aws_instance.Ansible-clients.public_ip[1]
    }
  )
  filename = "/etc/ansible/hosts.cfg"
}

