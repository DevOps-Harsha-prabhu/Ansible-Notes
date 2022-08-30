terraform {
  backend "s3" {
    bucket = "stacksimplify-terraformbucket1"
    key    = "terraform-Docker-swarm-ansible.tfstate"
    region = "us-east-1"
  }
}