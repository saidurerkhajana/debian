FROM debian:10-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/root/.nvm

RUN printf 'deb http://archive.debian.org/debian buster main\n\
deb http://archive.debian.org/debian buster-updates main\n' > /etc/apt/sources.list && \
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

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash

# Install Node.js 22
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install 22

# Install PM2
RUN . "$NVM_DIR/nvm.sh" && \
    npm install -g pm2

ENV PATH="/root/.nvm/versions/node/v22.23.2/bin:$PATH"

CMD ["sleep", "infinity"]
