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

RUN /bin/sh -c "apk add unzip"

# 设置时区为上海
RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata


ARG JAVA_OPTS

ARG PORT

ARG APP_NAME

#ENV SET

ENV APP_NAME ${APP_NAME:-bootapp}

ENV JAVA_OPTS ${JAVA_OPTS:--Djava.security.egd=file:/dev/./urandom}

ENV HTTP_PORT ${PORT:-8080}

RUN echo $HTTP_PORT $APP_NAME $JAVA_OPTS

COPY acs /acs

#RUN mkdir -p /acs/src

RUN mkdir -p /acs/logs

WORKDIR /acs

RUN echo "spbootdocker setup"

# Expose the default port
EXPOSE $PORT

ENTRYPOINT ["bash","/acs/acsstart"]

RUN echo "spbootdocker run"