#!/bin/bash -e 

install -m 644 files/node-v12.13.1-linux-armv7l.tar.gz "${ROOTFS_DIR}/"

on_chroot << EOF
uname -a

echo "Installing Node.js"

set -e
set -x

tar -xzf /node-v12.13.1-linux-armv7l.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm -rf /node-v12.13.1-linux-armv7l.tar.gz

curl -ksS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
npm install -g npm
apt-get update && apt-get install -y yarn

node -v
npm -v
yarn -v
EOF
