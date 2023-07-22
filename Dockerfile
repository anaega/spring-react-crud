# Fetching latest version of Java
FROM eclipse-temurin:17.0.7_7-jre

# Setting up work directory
WORKDIR /app

# Copy the jar file into our app
COPY ./target/project-app.jar /app

# Exposing port 8080
EXPOSE 8080

# Tell the image what command it has to execute as it starts as a container
CMD ["java", "-jar", "project-app.jar"]
