# Hands-on Docker-04 : Networking 

## Docker’s networking subsystem is pluggable, using drivers. Several drivers exist by default, and provide core networking functionality:

## bridge: 

``` text
The default network driver. If you don’t specify a driver, this is the type of network you are creating. Bridge networks are usually used when your applications run in standalone containers that need to communicate. 
```

## host: 

```text
For standalone containers, remove network isolation between the container and the Docker host, and use the host’s networking directly.
```

## overlay: 
```text
Overlay networks connect multiple Docker daemons together and enable swarm services to communicate with each other. You can also use overlay networks to facilitate communication between a swarm service and a standalone container, or between two standalone containers on different Docker daemons. This strategy removes the need to do OS-level routing between these containers.
```

## macvlan: 

```text
Macvlan networks allow you to assign a MAC address to a container, making it appear as a physical device on your network. The Docker daemon routes traffic to containers by their MAC addresses. Using the macvlan driver is sometimes the best choice when dealing with legacy applications that expect to be directly connected to the physical network, rather than routed through the Docker host’s network stack.
```

## none: 

```text
For this container, disable all networking. Usually used in conjunction with a custom network driver. none is not available for swarm services.
```

## Network plugins: 

```text
You can install and use third-party network plugins with Docker. These plugins are available from Docker Hub or from third-party vendors. See the vendor’s documentation for installing and using a given network plugin.
```


## Goals of this training

At the end of the this hands-on practice, you will;

- bind containers to specific ports

- list available networks  

- create a network  

- inspect all properties of a network  

- connect a container to a network

- explain default network bridge configuration

- configure user-defined bridge network

- ping containers within same network

- delete networks
  

## Contents

- Part 1 - Port Binding
  
- Part 2 - Default Network Bridge  

- Part 3 - User-defined Network Bridge  




## Part 1 - Port Binding

- Run a `nginx` web server, name the container as `web`, and bind the web server to host port  80 command to run alpine shell. Explain `--rm` and `-p` flags and port binding.

```bash
docker run --rm -d -p  80:80 --name web nginx
```

- Add a security rule for protocol HTTP port 80 and show Nginx Web Server is running on Docker Machine.

```text
http:// ec2-11-212-64-104.compute-1.amazonaws.com: 80
```

- Stop container `web`, should be removed automatically due to `--rm` flag.

```bash
docker stop web
```

## Part 2 - Default Network Bridge  

- Check if the docker service is up and running.

```bash
systemctl status docker
```

- List all networks available  , and explain types of networks.

```bash
docker network ls
```

- Run two `alpine` containers with interactive shell, in detached mode, name the container as `techpro1st` and `techpro2nd`, and add command to run alpine shell. Here, explain what the detached mode means.

```bash
docker run -d -it --name techpro1st alpine sh
docker run -d -it --name techpro2nd alpine sh
```

- Show the list of running containers on Docker machine.

```bash
docker ps
```

- Show the details of `bridge` network, and explain properties (subnet, ips) and why containers are in the default network bridge.

```bash
docker network inspect bridge
```

- Get the IP of `techpro2st` container.

```bash
docker inspect techpro2nd |grep IPAddress
```


- Connect to the `techpro1st` container.

```bash
docker attach techpro1st
```

- Ping amazon.com four times to check internet connection.

```bash
ping -c 3 amazon.com
```

- Ping `techpro2nd `container by its IP four times to show the connection.

```bash
ping -c 3 172.17.0.3
```

- Try to ping `techpro2nd `container by its name, should face with bad address. Explain why failed (due to default bridge configuration not works with container names)

```bash
ping -c 3 techpro2nd
```

- Disconnect from `techpro1st` without stopping it use escape sequence (ctrl + P , ctrl + Q).

- Stop and delete the containers

```bash
docker stop techpro1st techpro2nd
docker rm techpro1st techpro2nd
```

## Part 3 - User-Defined Bridge Network 

- Create a bridge network `techpronet`.

```bash
docker network create --driver bridge techpronet
```

- List all networks available  , and show the user-defined `techpronet`.

```bash
docker network ls
```

- Show the details of `techpronet`, and show that there is no container yet.

```bash
docker network inspect techpronet
```

- Run four `alpine` containers with interactive shell, in detached mode, name the containers as `techpro1st`, `techpro2nd`, `techpro3rd` and `techpro4th`, and add command to run alpine shell. Here, 1st and 2nd containers should be in `techpronet`, 3rd container should be in default network bridge, 4th container should be in both `techpronet` and default network bridge.

```bash
docker run -d -it --network techpronet --name techpro1st alpine sh
docker run -d -it --network techpronet --name techpro2nd alpine sh
docker run -d -it --name techpro3rd alpine sh
docker run -d -it --name techpro4th alpine sh
docker network connect techpronet techpro4th
```

- List all running containers and show there up and running.

```bash
docker container ls
```

- Show the details of `techpronet`, and explore newly added containers. 
- 1st, 2nd, and 4th containers should be in the list

```bash
docker network inspect techpronet
```

- Show the details of  default network bridge, and explore newly added containers. 
- 3rd and 4th containers should be in the list

```bash
docker network inspect bridge
```

- Connect to the `techpro1st` container.

```bash
docker attach techpro1st
```

- Ping `techpro2nd` and `techpro4th` container by its name to show that in user-defined network, container names can be used in networking.

```bash
ping -c 3 techpro2nd
ping -c 3 techpro4th
```

- Try to ping `techpro3rd` container by its name and IP, should face with bad address because 3rd container is in different network.

```bash
ping -c 3 techpro3rd
ping -c 3 172.17.0.2
```

- Ping amazon.com to check internet connection.

```bash
ping -c 3 amazon.com
```

- Exit the `techpro1st` container without stopping and return to ec2-user bash shell.

- Connect to the `techpro4th` container, since it is in both network should connect all containers.

```bash
docker attach techpro4th
```

- Ping `techpro1nd` and `techpro2nd` container by its name, ping `techpro3rd` container with its IP. Explain why used IP, instead of name.

```bash
ping -c 3 techpro1st
ping -c 3 techpro2nd
ping -c 3 techpro3rd
ping -c 3 172.17.0.2
```

- Stop and remove all containers

```bash
docker stop techpro1st techpro2nd techpro3rd techpro4th
docker rm techpro1st techpro2nd techpro3rd techpro4th
```

- Delete `techpronet` network

```bash
docker network rm techpronet
```