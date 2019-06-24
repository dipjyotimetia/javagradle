FROM java:8-jdk

ENV GRADLE_VERSION 5.4.1

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get install -y vim wget curl git python-pip python-dev build-essential

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    mv gradle-${GRADLE_VERSION} /opt/ && \
    rm gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME /opt/gradle-${GRADLE_VERSION}
ENV PATH $PATH:$GRADLE_HOME/bin

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"
ENV PATH $JAVA_HOME/bin:$PATH

# Inslate Allure CLI
#RUN wget https://dl.bintray.com/qameta/maven/io/qameta/allure/allure-commandline/2.12.1/allure-commandline-2.12.1.zip && \
#    unzip allure-commandline-2.12.1.zip && bin/allure && rm allure-commandline-2.12.1.zip

#Providing all permissions to userjenkins
RUN groupadd -g 1000 jenkins && \
   useradd -u 1000 -g 1000 -m -s /bin/bash jenkins

USER jenkins
