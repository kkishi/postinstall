#!/bin/bash

set -ex

if [[ $EUID != 0 ]]; then
  echo "This script needs to be run as root"
  exit 1
fi

apt install -y \
    direnv \
    emacs \
    git \
    htop \
    libboost-all-dev \
    python3-pip \
    s-tui \
    screen \
    xsel

# https://go.dev/doc/install
if [[ -f /usr/local/go/bin/go ]]; then
  echo "go already installed."
else
  file=go1.17.6.linux-amd64.tar.gz
  wget https://go.dev/dl/$file
  rm -rf /usr/local/go && tar -C /usr/local -xzf $file
  rm $file
fi

# https://docs.bazel.build/versions/main/install-ubuntu.html
if [[ -f /usr/bin/bazel ]]; then
  echo "bazel already installdd."
else
  apt install -y apt-transport-https curl gnupg
  curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
  mv bazel.gpg /etc/apt/trusted.gpg.d/
  echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

  apt update
  apt install -y bazel
fi
