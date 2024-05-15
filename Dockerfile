ARG BASE_IMAGE
FROM alpine:latest AS downloader
ARG MONGO_VERION
RUN wget https://github.com/mongodb/mongo/archive/refs/tags/r${MONGO_VERION}.zip -O /r${MONGO_VERION}.zip
RUN unzip /r${MONGO_VERION}.zip

FROM ${BASE_IMAGE}
ARG MONGO_VERION
COPY --from=downloader /mongo-r${MONGO_VERION} /mongo-r${MONGO_VERION}

RUN ls -l /mongo-r${MONGO_VERION}