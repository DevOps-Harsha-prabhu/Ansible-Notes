resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tpl",
    {
      server1 = aws_instance.Docker-swarm-master-1.public_ip
      server2 = aws_instance.Docker-swarm-master.0.public_ip
      server3 = aws_instance.Docker-swarm-master.1.public_ip
      server4 = aws_instance.Docker-swarm-workder-nodes.0.public_ip
      server5 = aws_instance.Docker-swarm-workder-nodes.1.public_ip
      server6 = aws_instance.Docker-swarm-workder-nodes.2.public_ip
    }
  )
  filename = "/etc/ansible/hosts.cfg"
}
