FROM debian:10-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/root/.nvm

RUN sed -i \
    -e 's|deb.debian.org/debian|archive.debian.org/debian|g' \
    -e 's|deb.debian.org/debian-security|archive.debian.org/debian-security|g' \
    -e 's|buster/updates|buster|g' \
    /etc/apt/sources.list && \
    printf 'Acquire::Check-Valid-Until "false";\n' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt update && \
    apt install -y \
    nano \
    wget \
    curl \
    passwd && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "root:root6767" | chpasswd

# Download and install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash

# Install Node.js 22
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install 22

# Install PM2
RUN . "$NVM_DIR/nvm.sh" && \
    npm install -g pm2

# Make Node.js and npm available
ENV PATH="/root/.nvm/versions/node/v22.23.2/bin:$PATH"

CMD ["sleep", "infinity"]
