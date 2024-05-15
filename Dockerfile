FROM alpine:latest

ARG TARGETARCH

RUN echo ${TARGETARCH} > /msg