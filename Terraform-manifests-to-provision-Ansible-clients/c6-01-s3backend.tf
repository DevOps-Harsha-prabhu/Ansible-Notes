terraform {
  backend "s3" {
    bucket = "stacksimplify-terraformbucket1"
    key    = "terraform-Ansible-clients.tfstate"
    region = "us-east-1"
  }
}