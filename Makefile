

DOCKER ?= sudo docker
RUST_VERSION ?= 1.83.0
# armv7-unknown-linux-gnueabihf x86_64-unknown-linux-gnu
ARCH_TARGET ?= x86_64-unknown-linux-gnu

.PNONY: all
all: target/$(ARCH_TARGET)/release/shh

#target/release/shh:
target/$(ARCH_TARGET)/release/shh: build-container
	$(DOCKER) run --rm --user "$(shell id -u)":"$(shell id -g)" -v "$$PWD":/usr/src/shh -w /usr/src/shh rust-cross:$(RUST_VERSION) bash -cxe "cargo build --release --target $(ARCH_TARGET)"

.PNONY: build-container
build-container: Dockerfile
	$(DOCKER) build -t rust-cross:$(RUST_VERSION) --build-arg RUST_VERSION=$(RUST_VERSION) - < Dockerfile

.PNONY: clean
clean:
	$(RM) -rf target
