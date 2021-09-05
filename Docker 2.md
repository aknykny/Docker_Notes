# Hands-on Docker-02 : Docker Container Basic Operations

Purpose of the this hands-on training is to give students the knowledge of basic operation on Docker containers.

## Learning Outcomes

At the end of the this hands-on training, students will be able to;

- list the help about the Docker commands.

- list the running and stopped Docker containers.

- understand the properties of Docker containers.

- start, stop, and remove Docker containers.
  
- running interactive mode 

## Basic Container Commands of Docker

- If you use AWS EC2 then;
  - Check whether the docker sernanoce is up and running by using the following command.

```bash
  sudo systemctl status docker
```

- Run either `docker` or `docker help` to see the help docs about docker commands.

```bash
docker help | less
```

- Run `docker COMMAND --help` to see more information about specific command.

```bash
docker run --help | less
```



- Run `hello-world` as a first image and container. To pull and run hello-world official image, use the following command.

```bash
docker run hello-world
```

- Show the list of all containers available on Docker machine and understand container properties.
- To see the `running containers`;  

```bash
docker container ls
```
- Or

```bash
docker ps
```

- To see the `running and exited/stopped containers`;  

```bash
docker container ls -a
```

```bash
docker ps -a
```

- Download and run `ubuntu` os with interactive shell open.

```bash
docker run -i -t ubuntu
```

- Display the os name on the container for the current user.

```bash
uname -a
```

- Display the shell name on the container for the current user.

```bash
echo $0
```

- Look that `ubuntu` container is like any other Ubuntu distro but it is limited.

  - Go to the home folder and create a directory named as `techpro` and list the content of it.

    ```bash
    cd ~ && mkdir techpro && ls
    ```

  - Create a file named as `container.txt`

  - Try to edit `container.txt` file with `nano` editor and show that there is no `nano` installed.
  - (Because container is a limited version of linux to be lightweight)

    ```bash
    nano container.txt
    ```

  - Install `nano` editor.


    - First update and upgrade os packages on `ubuntu` container.

    ```bash
    apt-get update && apt-get upgrade -y
    ```

    ```bash
    apt-get install nano
    ```

  - Edit `container.txt` file with `nano` editor and type `Docker is easy to learn!` to show that `nano` command can be run now.

    ```bash
    nano container.txt
    ```

- Exit the `ubuntu` container and return user shell.

```bash
exit
```


- Run the second `ubuntu` os with interactive shell open and name container as `back-end` and show that this `ubuntu` container is different from the previous one.

```bash
docker run -i -t --name back-end ubuntu
```

- Exit the `ubuntu` container and return to user shell.

```bash
exit
```

- Show the list of all containers again and understand the second `ubuntu` containers' properties and how the names of containers are given.

```bash
docker ps -a
```

- Restart the first container by its `ID`.

```bash
docker start 32t
```

- Show only running containers and understand the status.

```bash
docker ps
```

- Stop the first container by its `ID` and show it is stopped.

```bash
docker stop 32t && docker ps -a
```

- Restart the `back-end` container by its name and list only running containers.

```bash
docker start back-end && docker ps
```

- Connect to the interactive shell of running `back-end` container and `exit` afterwards.

```bash
docker attach back-end
```

- Show that `back-end` container has stopped by listing all containers.

```bash
docker ps -a
```

- Restart the first container by its `ID` again and attach to it to show that the file we have created is still there under the home folder, and exit afterwards.

```bash
docker start 32t && docker attach 32t
```

- Show that we can get more information about `back-end` container by using `docker inspect` command and see the properties.

```bash
docker inspect back-end | less
```

- Delete the first container using its `ID`.

```bash
docker rm 32t
```

- Or you can use `rmi` command as well;

```bash
docker rmi 32t
```

- Delete the second container using its name.

```bash
docker rm back-end
```

- Or you can use `prune` command as well

```bash
docker container prune
```

- Show that both of containers are not listed anymore.

```bash
docker ps -a
```