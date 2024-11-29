FROM ubuntu:20.04

# Désactiver les interactions de l'interface utilisateur
ENV DEBIAN_FRONTEND=noninteractive

# Configurer les sources de dépôts
RUN sed -i 's|http://mirror.eu.kernel.org|http://archive.ubuntu.com|g' /etc/apt/sources.list

# Mettre à jour les packages et installer PostgreSQL
RUN apt-get update && apt-get install -y \
    postgresql postgresql-contrib \
    curl gnupg2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

