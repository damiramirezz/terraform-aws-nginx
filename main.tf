resource "aws_instance" "webserver" {
  ami                         = "ami-09d56f8956ab235b3"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.webserver-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id

  provisioner "remote-exec" {
    inline = [
      "sudo apt install nginx git",
      "sudo systemctl stop apache2",
      "sudo systemctl start nginx",
      "git clone https://github.com/damiramriez/page-favos.git",
      "sudo mv -v ~/coder-favos/* /var/www/html/"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name           = "webserver",
    environment    = "testing",
    owner          = "dramirez@edrans.com",
    costCenter     = "SITEOPS",
    tagVersion     = "1",
    role           = "training",
    project        = "terraform",
    expirationDate = "2022-06-07T12:00:00.000Z"
  }
}