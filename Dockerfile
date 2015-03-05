# Docker base image with Oracle Java JDK
FROM fedora:21

RUN yum update -y -q && yum clean all
RUN yum install -y wget unzip git && yum clean all

RUN export RPM_URL=https://s3.amazonaws.com/state-dev-public-mirror-us-east-1/java/jdk-8u40-linux-x64.rpm && \
  curl -s $RPM_URL -o java.rpm && \
  yum localinstall -y java.rpm && \
  yum clean all && \
  rm java.rpm

RUN export GRADLE_ZIP_URL=https://services.gradle.org/distributions/gradle-2.1-bin.zip && \
  wget -q ${GRADLE_ZIP_URL} && \
  unzip -q $(basename ${GRADLE_ZIP_URL}) && \
  mv $(basename ${GRADLE_ZIP_URL} | sed 's/-bin\.zip$//') gradle && \
  rm $(basename ${GRADLE_ZIP_URL}) && \
  ln -s /gradle/bin/gradle /usr/bin/gradle

RUN export MAVEN_ZIP_URL=http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.zip && \
  wget -q ${MAVEN_ZIP_URL} && \
  unzip -q $(basename ${MAVEN_ZIP_URL}) && \
  mv $(basename ${MAVEN_ZIP_URL} | sed 's/-bin\.zip$//') apache-maven && \
  rm $(basename ${MAVEN_ZIP_URL}) && \
  ln -s /apache-maven/bin/mvn /usr/bin/mvn

ENV JAVA_HOME /usr/java/default
