#!/usr/bin/env bash
apt update && \
apt install -y ca-certificates lsb-release wget && \
wget https://packages.apache.org/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb && \
apt install -y ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb && \
apt update && \
apt install -y \
  libarrow-dev \
  libarrow-glib-dev \
  libarrow-dataset-dev \
  libarrow-dataset-glib-dev \
  libarrow-acero-dev \
  libarrow-flight-dev \
  libarrow-flight-glib-dev \
  libarrow-flight-sql-dev \
  libarrow-flight-sql-glib-dev \
  libgandiva-dev \
  libgandiva-glib-dev \
  libparquet-dev \
  libparquet-glib-dev && \
rm -rf /var/lib/apt/lists/*
