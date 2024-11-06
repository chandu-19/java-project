# Stage 1: Build the application using Maven
FROM maven:3.8.6-openjdk-17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Run Maven to compile and package the application (skip tests for now)
RUN mvn clean package -DskipTests

# Stage 2: Use a lightweight OpenJDK image to run the app
FROM openjdk:17-jdk-slim as runtime

# Set the working directory in the runtime container
WORKDIR /app

# Copy the compiled JAR file from the build stage
COPY --from=build /app/target/my-java-project-1.0-SNAPSHOT.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
