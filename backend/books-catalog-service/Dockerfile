# -------- Build stage --------
FROM gradle:8-jdk17 AS builder
WORKDIR /home/gradle/project
COPY . .
RUN gradle build -x test

# -------- Runtime stage --------
FROM eclipse-temurin:17-jdk-jammy

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

USER appuser:appgroup

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD wget -q --spider http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]