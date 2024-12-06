# Utiliser une image Debian slim pour réduire la taille de l'image
FROM debian:bullseye-slim

# Désactiver les interactions de l'interface utilisateur
ENV DEBIAN_FRONTEND=noninteractive

# Mettre à jour les sources de dépôt
RUN apt-get update && apt-get upgrade -y

# Installer PostgreSQL, curl, gnupg2, et Apache pour Adminer
RUN apt-get install -y \
    postgresql postgresql-contrib \
    curl gnupg2 \
    apache2 \
    php php-pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Initialiser le cluster PostgreSQL
RUN pg_createcluster 13 main --start

# Télécharger et installer Adminer
RUN curl -o /var/www/html/adminer.php https://www.adminer.org/latest.php

# Configurer Apache pour supprimer l'avertissement du ServerName
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copier le script d'entrée
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Exposer les ports PostgreSQL et Adminer
EXPOSE 5432 80

# Définir le script d'entrée
ENTRYPOINT ["entrypoint.sh"]

