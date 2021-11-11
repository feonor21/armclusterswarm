# Cluster swarm ARM
## because a group will always go further than a single unit
( for edit readme i use [dillinger.io](https://dillinger.io/))
```
la traduction viendrat
```
le but est de creer mon cluster swarm avec des raspberry pi 4.
1 manager et 2 worker pour commencer.

- 1 manager
- 2 worker
- un disque reseau disponible

## Tech
- [raspbian] - en OS des raspberry
- [traefik] - en reverse proxy et loadbalancing
- [swarmpit] - en gestion
- [nginx] - en appli web front end


## Installation
### Creation de la carte SD
avec le dernier raspbian OS LITE, penser a mettre un fichier nommer "ssh" a la racine.
cela activeras de base le SSH

### First boot et conf
update du systeme complet
```sh
sudo apt-get update && sudo apt-get upgrade -y
```
Ensuite avec raspiconfig expension de la partition au dimension de la carte SD
et le hostname

### Installation de docker
```sh
sudo curl -sSL https://get.docker.com | sudo sh
```
puis on met l'utilisateur souhaiter dans le groupe "docker"
```sh
sudo usermod -aG docker username
```

### Installation de dockercompose(a determiner)
```sh
sudo pip3 -v install docker-compose
```

### Deploiment du swarm
Si le manager n'est pas initialiser
```sh
sudo docker swarm init --advertise-addr 192.168.2.10
```
192.168.2.10 devras etre remplacer par l'adresse IP de votre manager
[plus d'info?](https://docs.docker.com/engine/reference/commandline/swarm_init/)

### Ajout des manager et worker
sur un manager voici la commande ssh pour obtenir la commande a executer sur le future manager
```sh
docker swarm join-token manager
```
sur un manager voici la commande ssh pour obtenir la commande a executer sur le future worker
```sh
docker swarm join-token worker
```
[plus d'info?](https://docs.docker.com/engine/reference/commandline/swarm_join-token/)

pour verifier que les nodes sont present
sur un manager 
```sh
sudo docker node ls
```
devras lister tout les nodes

### deployement des applications
le fichier ./deploy.sh est un assistance au deploiement
en l'executant il creeras les volume et les network necessaire.
a modifier a votre convenance

le fichier ./docker-cloud.yml est le compose de l'application.
il est lier au fichier config.env





## License
MIT

**Free Software, Hell Yeah!**
