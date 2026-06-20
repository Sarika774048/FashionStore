#!/bin/bash
set -e

# Start MySQL daemon
echo "Starting local MySQL service..."
service mysql start

# Wait for MySQL port to open
echo "Waiting for MySQL database to become responsive..."
until mysqladmin ping -h localhost --silent; do
    sleep 2
done

echo "Setting up root credentials and schema..."
# Initialize database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS fashion_store_db;"
# Configure root password to match DBConstants ('Sarika9#')
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Sarika9#';"
mysql -u root -p'Sarika9#' -e "FLUSH PRIVILEGES;"

# Apply table layouts and catalog entries
if [ -f "/app/schema.sql" ]; then
    echo "Applying schema.sql..."
    mysql -u root -p'Sarika9#' fashion_store_db < /app/schema.sql
fi

if [ -f "/app/seed.sql" ]; then
    echo "Applying seed.sql..."
    mysql -u root -p'Sarika9#' fashion_store_db < /app/seed.sql
fi

echo "Database successfully set up and seeded."

# Start Tomcat in the foreground
echo "Starting Apache Tomcat..."
exec catalina.sh run
