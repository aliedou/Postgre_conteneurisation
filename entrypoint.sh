#!/bin/bash
set -e

# Démarrer PostgreSQL
service postgresql start

# Attendre que PostgreSQL démarre complètement
sleep 5

# Initialiser la base de données si elle n'existe pas déjà
if [ ! -f /var/lib/postgresql/data/initialized ]; then
    su postgres -c "psql -c \"CREATE DATABASE mydatabase;\""
    su postgres -c "psql -c \"CREATE USER myuser WITH PASSWORD 'Securemydatabase';\""
    su postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;\""
    
    # Créer le répertoire si nécessaire
    mkdir -p /var/lib/postgresql/data
    touch /var/lib/postgresql/data/initialized
fi

# Démarrer Apache en premier plan
exec apache2ctl -D FOREGROUND

