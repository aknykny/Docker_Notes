## once linux sistemmi update edelim
sudo yum update - 

## sonrasinda docker i sisteme yukleyelim
sudo  amazon-linux-extras install docker -y

## docker i baslatiyoruz
sudo systemctl start docker

## docker i system her basladiginda baslamasi icin
sudo systemctl enable docker

## user i usergroup a eklemek icin
sudo usermod  -aG  docker ec2-user

## grup u aktif hale getirmis oluyoruz.. her zaman shell e erisimimizi saglamis oluyoruz. dolayisiyla her defasinda docker komutu yazarken sudo ile birlikte yazmaktan kurtulmus oluyoruz
$ newgrp docker

## docker compose u kuruyoruz
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

## docker i executable yapiyoruz
bash'''
sudo chmod +x /usr/local/bin/docker-compose
