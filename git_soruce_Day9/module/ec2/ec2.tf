resource "aws_instance" "public_ec2" {
  instance_type          = var.type
  ami                    = var.ami
  key_name               = var.ssh_key
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
  tags = {
    Name = "public_ec2"
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      //Here I created a new key pair with the ED25519 algo for provisioner_key
      private_key = file("C:\Users\shasingh\Documents\TF\workspace_Day8\module\ec2\provisioner_key.pem")
      host        = self.public_ip
      timeout     = "1m"
      agent       = false
    }
    inline = [
      "echo '\n************CLONING GIT-REPO****************' ",
      "sudo git clone https://github.com/inboxtoshashi/mail.git /var/www/html",
      "echo '************CLONING COMPLETED****************' ",
      "echo '************Running master.sh to install requirements****************' ",
      "sudo sh /var/www/html/master.sh",
      "echo '************Installation completed****************\n' ",
      "echo",
      "echo '**************EXITING PROVISIONR***************' ",
      "echo"
    ]
  }
}

/**
resource "aws_instance" "private_ec2" {
  instance_type = var.type
  ami = var.ami
  key_name = var.ssh_key
  subnet_id = var.private_subnet_id
  tags = {
    Name = "private_ec2"
  }
}
**/