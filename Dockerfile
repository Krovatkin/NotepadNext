FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    qt6-base-dev \
    qt6-tools-dev \
    qt6-tools-dev-tools \
    qt6-l10n-tools \
    libqt6core5compat6-dev \
    qt6-base-private-dev \
    build-essential \
    git \
    cmake \
    libgl1-mesa-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
