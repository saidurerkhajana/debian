FROM debian:11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/root/.nvm

RUN apt update && \
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

# Install Node.js 24 and PM2
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install 24 && \
    nvm alias default 24 && \
    npm install -g pm2

ENV PATH="/root/.nvm/versions/node/v24.18.0/bin:$PATH"

CMD ["sleep", "infinity"]
