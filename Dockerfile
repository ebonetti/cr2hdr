FROM debian:stable-slim as builder
RUN apt-get update && apt-get install -y exiftool dcraw
RUN apt-get install -y \
    mercurial \
    gcc-arm-none-eabi \
    python3-pip \
    gcc-multilib \
    make && \
    pip3 install docutils
RUN hg clone -r unified https://foss.heptapod.net/magic-lantern/magic-lantern
WORKDIR /magic-lantern/modules/dual_iso/
RUN make HOST_CC="gcc -static" cr2hdr
RUN ! ldd /magic-lantern/modules/dual_iso/cr2hdr || (>&2 echo "error: cr2hdr is dynamically linked"; exit 1);

FROM debian:stable-slim
RUN apt-get update && apt-get install -y exiftool dcraw
COPY --from=builder /magic-lantern/modules/dual_iso/cr2hdr /usr/bin/cr2hdr
ENTRYPOINT ["/usr/bin/cr2hdr"]