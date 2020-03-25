# spbootdocker
#
# VERSION 1.0
#FROM registry.acs.aliyun.com/open/java8:4.0.0
#FROM openjdk:8-jdk
FROM openjdk:8-jdk-slim

MAINTAINER jackrain

RUN /bin/sh -c " mv /etc/apt/sources.list /etc/apt/sources.list.bak"
RUN echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian-security stretch/updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian-security stretch/updates main" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >> /etc/apt/sources.list

RUN /bin/sh -c "apt-get update"
RUN /bin/sh -c "apt install -y unzip"

# 设置时区为上海
RUN /bin/sh -c "cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"

ONBUILD ARG JAR_FILE

ONBUILD ARG PORT

ONBUILD ARG JAVA_OPTS

ONBUILD ARG FAT_JAR_PARAMS

#ENV SET

ONBUILD ENV JAR_FILE ${JAR_FILE:-bootapp.jar}

ONBUILD ENV JAVA_OPTS ${JAVA_OPTS:--Djava.security.egd=file:/dev/./urandom}

ONBUILD ENV HTTP_PORT ${PORT:-8080}

ONBUILD ENV FAT_JAR_PARAMS ${FAT_JAR_PARAMS}

#RUN echo $HTTP_PORT $APP_NAME $JAVA_OPTS

COPY acs /acs

#RUN mkdir -p /acs/src

RUN mkdir -p /acs/logs

WORKDIR /acs

RUN echo "spbootdocker setup"

EXPOSE 8080
# Expose the default port
ONBUILD EXPOSE $HTTP_PORT

ENTRYPOINT ["bash","/acs/acsstart"]

RUN echo "spbootdocker run"