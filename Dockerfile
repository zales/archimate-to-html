FROM --platform=linux/amd64 debian:bookworm-slim

ENV ARCHI_VERSION 5.4.2

RUN apt update && \
    apt install -y xvfb curl libswt-gtk-4-jni dbus-x11 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Download archimatetool
RUN curl "https://www.archimatetool.com/downloads/archi/${ARCHI_VERSION}/Archi-Linux64-${ARCHI_VERSION}.tgz" \
    > /Archi-Linux64-${ARCHI_VERSION}.tgz && \
    tar -zxvf /Archi-Linux64-${ARCHI_VERSION}.tgz -C /opt && \
    chmod +x /opt/Archi/Archi && \
    rm -f /Archi-Linux64-${ARCHI_VERSION}.tgz
