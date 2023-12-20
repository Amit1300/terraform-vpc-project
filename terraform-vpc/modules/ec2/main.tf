resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count         = length(var.ec2_names)
  associate_public_ip_address = true
  subnet_id     = var.subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
    #!/bin/bash

    # Update package information
    sudo apt update

    # Install Apache
    sudo apt install -y apache2

    # Create a simple HTML page
    echo "<!DOCTYPE html>
    <html>
    <head>
        <title>My Simple Web Page</title>
    </head>
    <body>
        <h1>Hello, this is a simple web page!</h1>
    </body>
    </html>" | sudo tee /var/www/html/index.html

    # Adjust permissions
    sudo chown -R www-data:www-data /var/www/html

    # Restart Apache
    sudo service apache2 restart
  EOF

    tags = {
    Name = var.ec2_names[count.index]
  }
}
