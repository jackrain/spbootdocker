# spbootdocker
#
# VERSION 1.0
#FROM registry.acs.aliyun.com/open/java8:4.0.0
#FROM openjdk:8-jdk
FROM openjdk:8-jdk-alpine

MAINTAINER jackrain

RUN /bin/sh -c "mv /etc/apk/repositories /etc/apk/repositories.bak"

RUN echo "https://mirrors.aliyun.com/alpine/v3.9/main/" >> /etc/apk/repositories

RUN echo "https://mirrors.aliyun.com/alpine/v3.9/community/" >> /etc/apk/repositories

RUN /bin/sh -c "apk add --no-cache bash"

# 设置时区为上海
RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

COPY acs /acs

RUN mkdir -p /acs/src

RUN mkdir -p /acs/logs

WORKDIR /acs

RUN echo "spbootdocker setup"

# Expose the default port
EXPOSE 8080

ENTRYPOINT ["bash","/acs/acsstart"]

RUN echo "spbootdocker run"
