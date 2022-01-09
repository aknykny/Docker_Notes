## once linux sistemmi update edelim
sudo yum update - y

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

## //BURASI BIRAZ EXTRA: BIR container a yereldeki bir programi yeniden container icersinde olmasini istiyorsak soketleme islemi yapmamiz gerekiyor. yereldeki konumunu kontainer icerisine gostermemiz gerekiyor, burada container icerisinde yeniden docker kurmak yerine, yerelde kurulu olan dokcer in path ini gostererek bunu gerceklestirdik

## -- docker container uzerinden jenkins i calistiriyorsak, container icerisine Docker parametrelerini gondermek icin ec2 daki docker in path ini container a volum olarak gosteriyoruz
	sudo docker run -p 8080:8080 -p 5000:5000 -d -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:lts

## bir container e root user olarak baglanmak icin  -u 0 parametresi ile giris yapiyoruz
 	docker exec -it -u 0 07f bash

## sonra bu docker soket e  yazma hakki veriyoruz
	chmod 666 var/run/docker.sock
