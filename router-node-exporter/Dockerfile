FROM --platform=$BUILDPLATFORM ubuntu:24.04
# https://docs.docker.com/build/building/multi-platform/
ARG TARGETOS
ARG TARGETARCH

COPY _in_container_build.sh /

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} bash /_in_container_build.sh
