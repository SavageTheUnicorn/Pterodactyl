FROM --platform=linux/arm64 ubuntu:22.04

LABEL author="SavageTheUnicorn" maintainer="savagetheunicorn@users.noreply.github.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y

RUN apt install -y \
    gcc g++ libgcc1 libc++-dev gdb libc6 \
    git wget curl tar zip unzip binutils xz-utils \
    iproute2 net-tools netcat telnet \
    libatomic1 libsdl1.2debian libsdl2-2.0-0 \
    libfontconfig libunwind8 sqlite3 libsqlite3-dev \
    libmariadb-dev libzip4 locales \
    apt-transport-https libcurl3-gnutls \
    liblua5.1-0 libluajit-5.1-2 libsqlite3-0 \
    libncurses6 libreadline8 ca-certificates

RUN useradd -m -d /home/container -s /bin/bash container

ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
