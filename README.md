# Table des matières

1. [Questions et Réponses sur Docker](#questions-et-réponses-sur-docker)
   1. [Qu’est-ce qu’un conteneur ?](#1-quest-ce-quun-conteneur)
   2. [Est-ce que Docker a inventé les conteneurs Linux ? Qu’a apporté Docker à cette technologie ?](#2-est-ce-que-docker-a-inventé-les-conteneurs-linux-qua-apporté-docker-à-cette-technologie)
   3. [Pourquoi est-ce que Docker est particulièrement pensé et adapté pour la conteneurisation de processus sans états (fichiers, base de données, etc.) ?](#3-pourquoi-est-ce-que-docker-est-particulièrement-pensé-et-adapté-pour-la-conteneurisation-de-processus-sans-états-fichiers-base-de-données-etc)
   4. [Quel artefact distribue-t-on et déploie-t-on dans le workflow de Docker ? Quelles propriétés désirables doit-il avoir ?](#4-quel-artefact-distribue-t-on-et-déploie-t-on-dans-le-workflow-de-docker-quelles-propriétés-désirables-doit-il-avoir)
   5. [Quelle est la différence entre les commandes `docker run` et `docker exec` ?](#5-quelle-est-la-différence-entre-les-commandes-docker-run-et-docker-exec)
   6. [Peut-on lancer des processus supplémentaires dans un même conteneur Docker en cours d’exécution ?](#6-peut-on-lancer-des-processus-supplémentaires-dans-un-même-conteneur-docker-en-cours-dexécution)
   7. [Pourquoi est-il fortement recommandé d’utiliser un tag précis d’une image et de ne pas utiliser le tag `latest` dans un projet Docker ?](#7-pourquoi-est-il-fortement-recommandé-dutiliser-un-tag-précis-dune-image-et-de-ne-pas-utiliser-le-tag-latest-dans-un-projet-docker)
   8. [Décrire le résultat de cette commande : `docker run -d -p 9001:80 --name my-php -v "$PWD":/var/www/html php:7.2-apache`.](#8-décrire-le-résultat-de-cette-commande-docker-run--d--p-900180--name-my-php--v-pwdvarwwwhtml-php72-apache)
   9. [Avec quelle commande Docker peut-on arrêter tous les conteneurs ?](#9-avec-quelle-commande-docker-peut-on-arrêter-tous-les-conteneurs)
   10. [Quelles précautions doit-on prendre pour construire une image afin de la garder de petite taille et faciliter sa reconstruction ?](#10-quelles-précautions-doit-on-prendre-pour-construire-une-image-afin-de-la-garder-de-petite-taille-et-faciliter-sa-reconstruction)
   11. [Lorsqu’un conteneur s’arrête, tout ce qu’il a pu écrire sur le disque ou en mémoire est perdu. Vrai ou faux ? Pourquoi ?](#11-lorsquun-conteneur-sarrête-tout-ce-quil-a-pu-écrire-sur-le-disque-ou-en-mémoire-est-perdu-vrai-ou-faux-pourquoi)
   12. [Lorsqu’une image est créée, elle ne peut plus être modifiée. Vrai ou faux ?](#12-lorsquune-image-est-créée-elle-ne-peut-plus-être-modifiée-vrai-ou-faux)
   13. [Comment peut-on publier et obtenir facilement des images ?](#13-comment-peut-on-publier-et-obtenir-facilement-des-images)
   14. [Comment s’appelle l’image de plus petite taille possible ? Que contient-elle ?](#14-comment-sappelle-limage-de-plus-petite-taille-possible-que-contient-elle)
   15. [Par quel moyen le client Docker communique-t-il avec le serveur `dockerd` ? Est-il possible de communiquer avec le serveur via le protocole HTTP ? Pourquoi ?](#15-par-quel-moyen-le-client-docker-communique-t-il-avec-le-serveur-dockerd-est-il-possible-de-communiquer-avec-le-serveur-via-le-protocole-http-pourquoi)
   16. [Un conteneur doit lancer un processus par défaut que l’on pourra override à l'exécution. Quelle commande faut-il utiliser pour lancer ce processus : `CMD` ou `ENTRYPOINT` ?](#16-un-conteneur-doit-lancer-un-processus-par-défaut-que-lon-pourra-override-à-lexécution-quelle-commande-faut-il-utiliser-pour-lancer-ce-processus-cmd-ou-entrypoint)
2. [Projet web avec compose](#projet-web-avec-compose)
   1. [Commande pour ouvrir un shell interactif](#commande-pour-ouvrir-un-shell-interactif)
   2. [Réaliser un dump de la base de données](#réaliser-un-dump-de-la-base-de-données)
   3. [Script PHP pour interroger la base de données](#script-php-pour-interroger-la-base-de-données)
   4. [Commandes pour lancer le projet](#commandes-pour-lancer-le-projet)
3. [Instructions pour utiliser le Makefile](#instructions-pour-utiliser-le-makefile)
   1. [Pour construire les images et lancer les services en mode développement](#pour-construire-les-images-et-lancer-les-services-en-mode-développement)
   2. [Pour lancer les services en mode développement](#pour-lancer-les-services-en-mode-développement)
   3. [Pour lancer les services en mode production](#pour-lancer-les-services-en-mode-production)
   4. [Pour arrêter les services](#pour-arrêter-les-services)
   5. [Pour redémarrer les services en mode développement](#pour-redémarrer-les-services-en-mode-développement)
   6. [Pour nettoyer les volumes et les images](#pour-nettoyer-les-volumes-et-les-images)
   7. [Pour ouvrir une session bash dans le conteneur MySQL](#pour-ouvrir-une-session-bash-dans-le-conteneur-mysql)
   8. [Pour réaliser un dump de la base de données docker_doc_dev](#pour-réaliser-un-dump-de-la-base-de-données-docker_doc_dev)

##
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
docker compose exec database mysqldump -u root -p docker_doc_dev > dump.sql
# (Entrer le mot de passe: root)
```

### 5. Script PHP pour interroger la base de données

L'URL locale pour accéder à cette page web sera `http://localhost:8080`.



### Commandes pour lancer le projet

Pour l’environnement de développement :

```sh
docker compose --env-file .env.dev up -d
```

Pour l’environnement de production :

```sh
docker compose --env-file .env.prod up -d
```

Pour relancer le projet et recharger les sources, utilisez :

```sh
docker compose up -d
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
