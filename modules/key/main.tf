provider "aws" {
  region = var.aws_region
}

# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name   = var.key_name
  public_key = file(var.key_path)
}