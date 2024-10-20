# Use an official Haskell image as a base image
FROM haskell:latest

# Install any necessary tools
RUN apt-get update && apt-get install -y \
     build-essential \
     curl \
     curl -sSL https://get.haskellstack.org/ | sh
    #cabal update
    #cabal install --lib split
    #cabal install --lib random-shuffle

# Set up the working directory
WORKDIR /workspace