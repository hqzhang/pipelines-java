# ----- Stage 1: Build the app using Maven -----
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Package the application (creates a JAR)
RUN mvn clean package -DskipTests

# ----- Stage 2: Run the app using a lightweight image -----
#FROM eclipse-temurin:17-jre

# Set working directory
#WORKDIR /app

# Copy the JAR from the builder stage
#COPY --from=builder /app/target/*.jar app.jar

# Expose port (change if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/target/*.jar"]
