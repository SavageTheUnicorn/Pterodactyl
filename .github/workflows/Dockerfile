FROM ubuntu:24.04

LABEL author="SavageTheUnicorn" maintainer="savagetheunicorn@users.noreply.github.com"
LABEL org.opencontainers.image.source="https://github.com/SavageTheUnicorn/Pterodactyl"
LABEL org.opencontainers.image.licenses=MIT

ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        wget \
        curl \
        tar \
        unzip \
        ca-certificates \
        libncurses6 \
        libreadline8 \
        libc6 \
        libstdc++6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a user for the server
RUN useradd -m -d /home/container -s /bin/bash container

# Set working directory
WORKDIR /home/container

# Set user
USER container

# Set environment variables
ENV USER=container HOME=/home/container

# Default command (will be overridden by Pterodactyl)
CMD ["/bin/bash"]
