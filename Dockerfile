FROM debian:11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/root/.nvm

RUN apt update && \
    apt install -y \
    nano \
    wget \
    curl \
    passwd \
    ca-certificates \
    gnupg && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "root:root6767" | chpasswd

# Install Cloudflared
RUN mkdir -p --mode=0755 /usr/share/keyrings && \
    curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg \
    -o /usr/share/keyrings/cloudflare-public-v2.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' \
    > /etc/apt/sources.list.d/cloudflared.list && \
    apt-get update && \
    apt-get install -y cloudflared && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash

# Install Node.js 22 and PM2
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install 22 && \
    nvm alias default 22 && \
    npm install -g pm2

ENV PATH="/root/.nvm/versions/node/v22.*/bin:$PATH"

CMD ["sleep", "infinity"]
