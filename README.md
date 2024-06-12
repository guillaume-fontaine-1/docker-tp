# Questions et Réponses sur Docker

## 1. Qu’est-ce qu’un conteneur ?
Un conteneur est une instance d'exécution d’une image Docker.

## 2. Est-ce que Docker a inventé les conteneurs Linux ? Qu’a apporté Docker à cette technologie ?
Non, Docker n'a pas inventé les conteneurs Linux. Docker a introduit plusieurs fonctionnalités notables telles que les pilotes de stockage, le support Linux standard, les liens, le nommage des conteneurs, les redirections de port avancées, le transfert hors ligne, et bien d'autres encore.

## 3. Pourquoi est-ce que Docker est particulièrement pensé et adapté pour la conteneurisation de processus sans états (fichiers, base de données, etc.) ?
Docker est particulièrement bien adapté à la conteneurisation de processus sans état en raison de son architecture et des fonctionnalités qu'il offre : conteneurs éphémères, isolement, portabilité, gestion des données, évolutivité.

## 4. Quel artefact distribue-t-on et déploie-t-on dans le workflow de Docker ? Quelles propriétés désirables doit-il avoir ?
On distribue une image Docker qui est construite à partir d'un Dockerfile. Les propriétés suivantes sont désirables pour une image Docker : légèreté, portabilité, modularité, reproductibilité, versionnage.

## 5. Quelle est la différence entre les commandes `docker run` et `docker exec` ?
`docker run` est utilisé pour démarrer un nouveau conteneur, tandis que `docker exec` est utilisé pour interagir avec un conteneur en cours d'exécution.

## 6. Peut-on lancer des processus supplémentaires dans un même conteneur Docker en cours d’exécution ?
Oui, il est possible de lancer des processus supplémentaires dans un conteneur Docker en cours d'exécution.

## 7. Pourquoi est-il fortement recommandé d’utiliser un tag précis d’une image et de ne pas utiliser le tag `latest` dans un projet Docker ?
L'utilisation de balises d'images spécifiques au lieu de la balise `latest` dans un projet Docker est fortement recommandée pour plusieurs raisons : reproductibilité, traçabilité, sécurité, stabilité.

## 8. Décrire le résultat de cette commande : `docker run -d -p 9001:80 --name my-php -v "$PWD":/var/www/html php:7.2-apache`.
Cette commande démarre un nouveau conteneur nommé `my-php` en arrière-plan, exécutant un serveur web sur le port 80 (accessible sur le port 9001 de l'hôte), et servant les fichiers situés dans le répertoire courant de la machine hôte.

## 9. Avec quelle commande Docker peut-on arrêter tous les conteneurs ?
```bash
docker stop $(docker ps -aq)
```

## 10. Quelles précautions doit-on prendre pour construire une image afin de la garder de petite taille et faciliter sa reconstruction ?
Utiliser une petite image de base, minimiser le nombre de couches, éviter d'installer des dépendances inutiles, et nettoyer les fichiers temporaires et les caches après les installations.

## 11. Lorsqu’un conteneur s’arrête, tout ce qu’il a pu écrire sur le disque ou en mémoire est perdu. Vrai ou faux ? Pourquoi ?
Faux. Dans Docker, les données écrites par un conteneur ne sont pas nécessairement perdues lorsqu'il s'arrête. Cela dépend de la façon dont les données du conteneur sont gérées.

## 12. Lorsqu’une image est créée, elle ne peut plus être modifiée. Vrai ou faux ?
Vrai. Pour apporter des modifications permanentes, on doit créer une nouvelle image ou ajouter des modifications sur l'image existante sous forme de nouvelles couches.

## 13. Comment peut-on publier et obtenir facilement des images ?
Pour publier et obtenir des images Docker, on utilise Docker Hub, qui est le marché par défaut pour stocker et distribuer des images.

## 14. Comment s’appelle l’image de plus petite taille possible ? Que contient-elle ?
`scratch` est une image minimale réservée dans Docker que l’on peut utiliser comme point de départ pour construire des conteneurs. Il s'agit essentiellement d'une couche vide qui ne contient aucun fichier ou dossier.

## 15. Par quel moyen le client Docker communique-t-il avec le serveur `dockerd` ? Est-il possible de communiquer avec le serveur via le protocole HTTP ? Pourquoi ?
Le client Docker communique avec le serveur Docker en utilisant une API REST, sur des sockets UNIX ou une interface réseau. Oui, il est possible de communiquer avec le serveur Docker via le protocole HTTP car il a été conçu pour communiquer en HTTP. La ligne de commande Docker traduit les commandes en requête HTTP.

## 16. Un conteneur doit lancer un processus par défaut que l’on pourra override à l'exécution. Quelle commande faut-il utiliser pour lancer ce processus : `CMD` ou `ENTRYPOINT` ?
Il faut utiliser `ENTRYPOINT` pour lancer le processus par défaut. `CMD` peut être utilisé pour fournir des arguments par défaut à ce processus, mais `CMD` peut aussi être override complètement en ligne de commande, tandis que `ENTRYPOINT` sera toujours exécuté sauf si remplacé explicitement.


#

# Projet web avec compose


### 2. Commande pour ouvrir un shell interactif

Pour ouvrir un shell interactif dans le conteneur MySQL, utilisez :

```sh
docker exec -it database bash
```

Ensuite, utilisez ces commandes pour vérifier les bases de données et leur contenu :

```sh
mysql -u db_client -p
# (Entrer le mot de passe: password)
SHOW DATABASES;
USE docker_doc_dev;
SHOW TABLES;
SELECT * FROM articles;
```

### 3. Réaliser un dump de la base de données

Pour réaliser un dump sans ouvrir de session bash, utilisez :

```sh
docker compose exec database mysqldump -u db_client -ppassword docker_doc_dev > dump.sql
```

### 5. Script PHP pour interroger la base de données

L'URL locale pour accéder à cette page web sera `http://localhost:8080`.

### 6. Configuration de l’environnement de développement

Pour relancer le projet et recharger les sources, utilisez :

```sh
docker compose up -d
```


### Commandes pour lancer le projet

Pour l’environnement de développement :

```sh
docker compose --env-file .env.dev up -d
```

Pour l’environnement de production :

```sh
docker compose --env-file .env.prod up -d
```


#
# Instructions pour utiliser le Makefile

1. **Pour construire les images et lancer les services en mode développement :**
   ```sh
   make all
   ```

2. **Pour lancer les services en mode développement :**
   ```sh
   make up-dev
   ```

3. **Pour lancer les services en mode production :**
   ```sh
   make up-prod
   ```

4. **Pour arrêter les services :**
   ```sh
   make down
   ```

5. **Pour redémarrer les services en mode développement :**
   ```sh
   make restart
   ```

6. **Pour nettoyer les volumes et les images :**
   ```sh
   make clean
   ```

7. **Pour ouvrir une session bash dans le conteneur MySQL :**
   ```sh
   make exec-db-shell
   ```

8. **Pour réaliser un dump de la base de données docker_doc_dev :**
   ```sh
   make dump-dev-db
   ```
