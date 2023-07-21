provider "aws" {
  region     = "us-east-1"
 
}


module "dev_vpc" {
  source = "./modules/vpc"

}

module "dev_ec2" {
  source = "./modules/ec2"
}
