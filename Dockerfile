FROM openjdk:18 AS builder
WORKDIR /opt
ADD https://github.com/gwtproject/gwt/releases/download/2.10.0/gwt-2.10.0.zip /opt
RUN microdnf install unzip ant && \
    unzip gwt-2.10.0.zip
RUN microdnf install firefox
ENV PATH=$PATH:/opt/gwt-2.10.0

WORKDIR /app
COPY app /app
RUN ant build

FROM nginx:alpine
COPY --from=builder /app/war/ /usr/share/nginx/html
