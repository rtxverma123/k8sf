#WAR File creation
FROM maven:3-jdk-11 as builder
RUN mkdir -p /build
COPY . /build
WORKDIR /build
RUN mvn clean compile package

FROM tomcat:7.0
COPY --from=builder /build/target /tom/target
WORKDIR /tom/target
RUN cp api.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]




# JAR FILE CREATION
# FROM maven:3.6.0-jdk-11-slim AS build
# COPY src src
# COPY pom.xml .
# RUN mvn clean package exec:java

# FROM openjdk:8-jre
# COPY --from=build /target /opt/target
# WORKDIR /opt/target
# CMD ["java", "-jar","java-project-1.0-SNAPSHOT.jar"]


FROM nginx
ADD index.html /usr/share/nginx/html/
RUN chmod +x /usr/share/nginx/html/index.html
EXPOSE 80



FROM tomcat:8.0-alpine
COPY index.html /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]
