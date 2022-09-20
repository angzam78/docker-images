FROM debian:bullseye AS builder
RUN apt-get update \
 && apt-get -y install apt-utils \
 && apt-get -y install build-essential gcc g++ cmake autoconf curl bison libncurses-dev ccache git libgeos-dev apt-transport-https ca-certificates npm
RUN npm install -g yarn @bazel/bazelisk
ENV GOPATH /go
RUN mkdir -p $GOPATH/src/github.com/cockroachdb \
 && cd $GOPATH/src/github.com/cockroachdb \
 && git clone --depth 1 --branch v22.1.7 https://github.com/cockroachdb/cockroach
WORKDIR $GOPATH/src/github.com/cockroachdb/cockroach
RUN git submodule update --init --recursive
RUN bazel build --linkopt=-Wl,--strip-all pkg/cmd/cockroach --config=with_ui
RUN strip --strip-all $GOPATH/src/github.com/cockroachdb/cockroach/_bazel/bin/pkg/cmd/cockroach/cockroach_/cockroach
RUN ldd $GOPATH/src/github.com/cockroachdb/cockroach/_bazel/bin/pkg/cmd/cockroach/cockroach_/cockroach && false

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y libc6 ca-certificates tzdata hostname tar && rm -rf /var/lib/apt/lists/*
WORKDIR /cockroach/
COPY --from=builder /go/src/github.com/cockroachdb/cockroach/build/deploy/cockroach.sh /cockroach/cockroach.sh
#COPY --from=builder /go/native/*-linux-gnu/geos/lib/libgeos.so /go/native/*-linux-gnu/geos/lib/libgeos_c.so /usr/local/lib/cockroach/
COPY --from=builder /go/src/github.com/cockroachdb/cockroach/_bazel/bin/pkg/cmd/cockroach/cockroach_/cockroach /cockroach/cockroach
EXPOSE 26257 8080
ENTRYPOINT ["/cockroach/cockroach.sh"]