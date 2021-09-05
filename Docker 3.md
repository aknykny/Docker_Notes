# Hands-on Docker-03_3 : Bind Mounts - Practice Website

## Learning Outcomes

-   Start a container as an nginx web server
-   Install a development environment from scratch

## Stage -1 

- For AWS EC2 add a security rule for protocol HTTP port 80 and show Nginx Web Server is running on Docker Machine.

```text
http://<public-ip>:80
```

- Run the `nginx` container in detached mod, name it as `web_server`, and open <public-ip> on browser and this will bring the nginx default page.

```bash
docker run -d --name web_server --rm -p 80:80 nginx
```

-- rm parametresi, container durdurulunca image i siler

- Attach the `nginx` container, show the index.html in the /usr/share/nginx/html directory.

```bash
docker exec -it web_server bash
root@312gthvrh4h5:/# cd /usr/share/nginx/html
root@312gthvrh4h5:/usr/share/nginx/html# ls
50x.html  index.html
root@312gthvrh4h5:/usr/share/nginx/html# cat index.html
```

-   Remove the container by using `exit` command on the container


## Stage -2 

- Share and clone the repository link as : https://github.com/erkandormen/javascript-projects

    ```bash
    mkdir website && cd website
    apt-get update -y
    apt-get upgrade -y
    apt-get install git
    git clone https://github.com/erkandormen/javascript-projects
    ls
    cd /reviews
    ls
    ```

- Run an `nginx` container in detached mod, name the container as `nginx_server`, attach the directory `/home/ec2-user/website/javascript-projects/reviews` to `/usr/share/nginx/html` mount point in the container, and open <public-ip> on browser and show the web page.

```bash
docker run -d --name nginx_server -p 8080:80 -v /home/ec2-user/website/javascript-projects/reviews:/usr/share/nginx/html nginx
```

## Stage -3 


- Attach the `nginx` container, show the index.html in the /usr/share/nginx/html directory.

```bash
docker exec -it nginx_server bash
root@a7e3d276a147:/# cd usr/share/nginx/html
root@a7e3d276a147:/usr/share/nginx/html# ls 
index.html
root@a7e3d276a147:/usr/share/nginx/html# cat index.html
```

- `exit` from the container.

- Add a new title or modify the title in index.html in the /home/ec2-user/website folder by using VSCode application and check the web page on browser.


- Remove all containers.

```bash
docker rm -f web_server nginx_server
```

- Remove all volumes.

```bash
 docker volume prune -f
```