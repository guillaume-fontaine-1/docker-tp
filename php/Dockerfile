# Utiliser l'image officielle PHP avec Apache
FROM php:8.2-apache

# Installer PDO_MYSQL
RUN apt-get update && apt-get install -y libmariadb-dev \
    && docker-php-ext-install pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier le script PHP vers le conteneur
COPY . /var/www/html/

# Définir le répertoire de travail
WORKDIR /var/www/html/
