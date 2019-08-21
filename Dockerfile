FROM alpine:latest

COPY . /

RUN apk add --no-cache --update --upgrade openssh && \
    adduser -D rtunnel

ENTRYPOINT PORT=$PORT sh entrypoint.sh
