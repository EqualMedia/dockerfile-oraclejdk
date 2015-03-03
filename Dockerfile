# Docker base image with Oracle Java JDK
FROM fedora:20

RUN yum update -y -q && yum clean all
RUN yum install -y wget unzip git && yum clean all

RUN export RPM_URL=http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.rpm && \
  wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F && oraclelicense=accept-securebackup-cookie" $RPM_URL && \
  yum localinstall -y $(basename ${RPM_URL}) && \
  yum clean all && \
  rm $(basename ${RPM_URL})

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
