terraform {
  backend "s3" {
    bucket = "stacksimplify-terraformbucket1"
    key    = "terraform-Ansible.tfstate"
    region = "us-east-1"
  }
}