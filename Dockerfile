# Use an official OpenJDK runtime
FROM openjdk:17-jdk-slim

# Set work directory inside container
WORKDIR /app

# Copy the built JAR from target/
COPY target/task-api-0.0.1-SNAPSHOT.jar app.jar

# Environment variable for Mongo connection (will be overridden in Kubernetes)
ENV SPRING_DATA_MONGODB_URI=mongodb://mongo-svc:27017/test

# Expose Spring Boot's port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
