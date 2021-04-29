# Deeply inspired on (if not a cheeky copy of) softprops/lambda-rust
# This image was adapted to work with GitHub Actions workflow, it
# might eventually be useful for standalone use as well.

FROM lambci/lambda:build-provided.al2

ARG RUST_VERSION=1.51.0
RUN yum install -y jq openssl-devel
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | CARGO_HOME=/cargo RUSTUP_HOME=/rustup sh -s -- -y --profile minimal --default-toolchain $RUST_VERSION

VOLUME ["/github/workspace", "/github/home", "/github/file_commands"]
WORKDIR /github/workspace

ADD build.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/build.sh"]