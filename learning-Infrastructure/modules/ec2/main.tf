module "vpc" {
  source = "../vpc"
  
}



resource "aws_key_pair" "jenkins" {
  key_name   = "jenkins"
  public_key = file("~/.ssh/jenkins.pub")

  tags = {
    Name = "devJenkinsKeyPair"
  }
}
  

resource "aws_instance" "dev_jenkins"{
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id = module.vpc.learn_dev_subnet_id
    vpc_security_group_ids = [module.vpc.learn_dev_sg_id]
    key_name = aws_key_pair.jenkins.key_name
    associate_public_ip_address = true
    tags = {
        Name = "dev_jenkins"
    }
    # use user data to install jenkins

    user_data = file("/media/onesmus/d42c9065-8792-4148-a205-cc0a748da294/dev/IaaC/learning-Infrastructure/jenskinsUserData.tpl")


    # depends on the vpc module
    depends_on = [module.vpc]

}


resource "aws_instance" "dev_kubernetes"{
    ami = data.aws_ami.ubuntu.id
    # add instance type with 3 vCPUs and 4GB RAM
    instance_type = "t3.medium"
    subnet_id = module.vpc.learn_dev_subnet_id
    vpc_security_group_ids = [module.vpc.learn_dev_sg_id]
    key_name = aws_key_pair.jenkins.key_name
    associate_public_ip_address = true
    tags = {
        Name = "dev_kubernetes"
    }
    
    user_data = file("/media/onesmus/d42c9065-8792-4148-a205-cc0a748da294/dev/IaaC/learning-Infrastructure/kubernetesUserData.tpl")

}


resource "aws_instance" "dev_node01"{
    ami = data.aws_ami.ubuntu.id
    # add instance type with 3 vCPUs and 4GB RAM
    instance_type = "t3.medium"
    subnet_id = module.vpc.learn_dev_subnet_id
    vpc_security_group_ids = [module.vpc.learn_dev_sg_id]
    key_name = aws_key_pair.jenkins.key_name
    associate_public_ip_address = true
    tags = {
        Name = "dev_node01"
    }
    
    user_data = file("/media/onesmus/d42c9065-8792-4148-a205-cc0a748da294/dev/IaaC/learning-Infrastructure/nodeUserData.tpl")

}