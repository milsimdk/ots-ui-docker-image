# syntax=docker/dockerfile:1
FROM python:3.12-slim as build

WORKDIR /build

RUN pip3 install lastversion
RUN lastversion --assets extract brian7704/OpenTAKServer-UI

FROM nginx:mainline-bookworm

# Copy OTS WebUI from build stage
COPY --from=build /build /usr/share/nginx/html/

EXPOSE 80
