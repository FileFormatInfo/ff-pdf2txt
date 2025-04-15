FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app
COPY pom.xml /app

RUN mvn dependency:go-offline

COPY . /app
RUN mvn package


FROM gcr.io/distroless/java21-debian12
ARG COMMIT="(not set)"
ARG LASTMOD="(not set)"
ENV COMMIT=$COMMIT
ENV LASTMOD=$LASTMOD

WORKDIR /app

COPY --from=builder /app/target/ff-pdf2txt-1.0.jar /app/ff-pdf2txt-1.0.jar

USER nonroot
EXPOSE 4000
ENV PORT=4000
CMD ["ff-pdf2txt-1.0.jar"]
