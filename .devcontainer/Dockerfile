# Use an official Haskell image as a base image
FROM haskell:latest

WORKDIR /workspace


# Install any necessary tools
RUN apt-get update && apt-get install -y \
     build-essential \
     curl \
     curl -sSL https://get.haskellstack.org/ | sh

RUN stack setup --install-ghc

RUN apt-get install -y\
    nodejs\
    npm

RUN npm install -g n

RUN n lts
RUN n latest

RUN n prune

