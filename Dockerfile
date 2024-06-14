ARG BASE_IMAGE
FROM alpine:latest AS downloader
ARG MONGO_VERION
RUN wget https://github.com/mongodb/mongo/archive/refs/tags/r${MONGO_VERION}.zip -O /r${MONGO_VERION}.zip
RUN unzip /r${MONGO_VERION}.zip

FROM ${BASE_IMAGE} AS builder
ARG MONGO_VERION
ARG CCFLAGS
COPY --from=downloader /mongo-r${MONGO_VERION} /mongo-r${MONGO_VERION}
WORKDIR /mongo-r${MONGO_VERION}
# RUN python3 buildscripts/scons.py MONGO_VERSION=${MONGO_VERION} ${CCFLAGS} install-core --disable-warnings-as-errors
RUN mkdir -p /mongo-r${MONGO_VERION}/build/install/bin && echo msg:${CCFLAGS} > /mongo-r${MONGO_VERION}/build/install/bin/xyz

FROM alpine:latest
RUN mkdir /output
COPY --from=builder /mongo-r${MONGO_VERION}/build/install/bin /output/