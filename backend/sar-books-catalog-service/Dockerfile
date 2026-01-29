# -------- Build stage --------
FROM gradle:8-jdk17 AS build
WORKDIR /home/gradle/project
COPY . .
RUN gradle build -x test

# -------- Runtime stage --------
FROM eclipse-temurin:17-jre-ubi10-minimal
WORKDIR /app

COPY --from=build /home/gradle/project/build/libs/*.jar app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]