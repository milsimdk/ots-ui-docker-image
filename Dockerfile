# syntax=docker/dockerfile:1
# ************************************************************
# First stage: builder
# ************************************************************
FROM python:3.12-slim as build

WORKDIR /build

RUN pip3 install lastversion
RUN lastversion --assets extract brian7704/OpenTAKServer-UI

# ************************************************************
# Second stage: runtime
# ************************************************************
FROM nginx:mainline-bookworm
ENV BUILD_VERSION = latest

LABEL maintainer="https://github.com/milsimdk"
LABEL org.opencontainers.image.title="Docker image for OpenTAKServer-UI"
LABEL org.opencontainers.image.description="OpenTAKServer is yet another open source TAK Server for ATAK, iTAK, and WinTAK"
LABEL org.opencontainers.image.version="${BUILD_VERSION}"
LABEL org.opencontainers.image.authors="Brian - https://github.com/brian7704"
LABEL org.opencontainers.image.vendor="https://github.com/milsimdk"
LABEL org.opencontainers.image.source="https://github.com/milsimdk/ots-ui-docker-image"
LABEL org.opencontainers.image.licenses="GNU General Public License v3.0"

# Copy OTS WebUI from build stage
COPY --from=build /build /usr/share/nginx/html/

EXPOSE 80
