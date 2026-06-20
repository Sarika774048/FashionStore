# --- Stage 1: Build Maven WAR file ---
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# --- Stage 2: All-in-One Tomcat + MySQL Runtime ---
FROM eclipse-temurin:17-jdk-jammy

# Non-interactive apt installation
ENV DEBIAN_FRONTEND=noninteractive

# Install MySQL Server and curl
RUN apt-get update && apt-get install -y \
    mysql-server \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Apache Tomcat 10
ENV TOMCAT_VERSION=10.1.25
WORKDIR /opt
RUN curl -sO https://archive.apache.org/dist/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && tar -xf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && mv apache-tomcat-${TOMCAT_VERSION} tomcat \
    && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Set Tomcat environment variables
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Remove default Tomcat webapps and copy compiled war
RUN rm -rf /opt/tomcat/webapps/*
COPY --from=build /app/target/FashionStore.war /opt/tomcat/webapps/ROOT.war

# Set up working directory for entrypoint and DB scripts
WORKDIR /app
COPY schema.sql /app/schema.sql
COPY seed.sql /app/seed.sql
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose HTTP port for Tomcat
EXPOSE 8080

ENTRYPOINT ["/app/entrypoint.sh"]
