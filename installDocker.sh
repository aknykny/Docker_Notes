sudo yum update - y
sudo  amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod  -aG  docker ec2-user
newgrp docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose