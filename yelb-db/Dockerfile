# Use the official PostgreSQL 10.21 image as the base
FROM postgres:17.5

# Set the maintainer information for the Docker image
MAINTAINER massimo@it20.info

# Set the working directory inside the container
WORKDIR /

# Install openssh-client to provide the 'scp' command
# apt-get update: Updates the list of available packages and their versions
# apt-get install -y: Installs packages without prompting for confirmation
# openssh-client: The package that contains the scp utility
# rm -rf /var/lib/apt/lists/*: Cleans up apt cache to keep the image size small
RUN apt-get update && apt-get install -y openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Copy the initialization script into the PostgreSQL entrypoint directory
# This script will be executed when the PostgreSQL container starts for the first time
COPY init-yelb-db.sh /docker-entrypoint-initdb.d/init-yelb-db.sh

# Set the environment variable for the PostgreSQL password
# This is required by the official PostgreSQL image
ENV POSTGRES_PASSWORD=postgres_password

