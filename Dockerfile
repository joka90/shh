ARG RUST_VERSION="1.83"
FROM rust:${RUST_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends \
  g++-arm-linux-gnueabihf libc6-dev-armhf-cross \
  g++-aarch64-linux-gnu libc6-dev-arm64-cross \
  && rm -rf /var/lib/apt/lists/*

RUN rustup target add armv7-unknown-linux-gnueabihf \
  && rustup toolchain install stable-armv7-unknown-linux-gnueabihf \
  && rustup target add aarch64-unknown-linux-gnu \
  && rustup toolchain install stable-aarch64-unknown-linux-gnu

ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc CC_armv7_unknown_Linux_gnueabihf=arm-linux-gnueabihf-gcc CXX_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-g++
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++

WORKDIR /usr/src/shh
