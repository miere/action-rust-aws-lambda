# Deeply inspired on softprops/lambda-rust Docker image, but was adapted to work
# with GitHub Actions workflow. Although it generates MUSL images by default, it is
# based on Ubuntu for convenience.
FROM messense/rust-musl-cross:x86_64-musl as BUILDER

ARG RUST_VERSION=1.52.0

RUN apt-get update -y \
 && apt-get install -y ca-certificates zip jq \
 && mkdir -p /github/workspace \
 && rustup default ${RUST_VERSION} && rustup target add x86_64-unknown-linux-musl

VOLUME ["/github/workspace", "/github/home", "/github/file_commands"]
WORKDIR /github/workspace

ADD build.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/build.sh"]
