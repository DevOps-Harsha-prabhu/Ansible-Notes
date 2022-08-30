resource "null_resource" "cluster" {
  count = 1
  provisioner "file" {
    source      = "user_data.sh"
    destination = "/tmp/user_data.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terraform-key.pem")
      host        = element(aws_instance.Ansible-Host.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/user_data.sh",
      "#sudo /tmp/user_data.sh",
      "sudo apt update",
      "sudo apt install software-properties-common -y",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "sudo apt update",
      "sudo apt install -y unzip net-tools",
      "sudo wget https://releases.hashicorp.com/terraform/1.2.8/terraform_1.2.8_linux_amd64.zip",
      "sudo unzip terraform_1.2.8_linux_amd64.zip",
      "rm -rf terraform_1.2.8_linux_amd64.zip",
      "sudo mv terraform /usr/local/bin",
      "curl https://get.docker.com/ | bash"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terraform-key.pem")
      host        = element(aws_instance.Ansible-Host.*.public_ip, count.index)
    }
  }
}

