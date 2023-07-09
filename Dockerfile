# Fetching latest version of Java
FROM eclipse-temurin:17.0.7_7-jre
# Setting up work directory
WORKDIR /app
# Copy the jar file into our app
COPY ./target/project-app.jar /app

# Exposing port 8080
EXPOSE 8080

# Starting the application
CMD ["java", "-jar", "project-app.jar"]
