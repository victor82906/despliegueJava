# FROM eclipse-temurin:17-jdk-alpine AS build

# WORKDIR /app

# COPY . /app

# # esto es lo que deberia de ejecutar siempre para crear un .jar
# RUN javac -d bin src/App.java && jar cfm output.jar manifest.mf -C bin .


# # esto sobreescribe y mata a la maquina de arriba, la de arriba es solo para crear el .jar y copiarlo en la maquina siguiente
# FROM eclipse-temurin:17-jre-alpine

# WORKDIR /app

# COPY --from=build /app/output.jar /app/output.jar

# CMD ["java", "-jar", "output.jar"]

# # docker build -t imagen-jar .
# # docker run -p 8080:8080 --name aplicacion-java-1 imagen-jar


# ----- GITHUB -----

FROM eclipse-temurin:17-jdk-alpine AS build

RUN apk update && apk add git

WORKDIR /app

RUN git clone https://github.com/victor82906/despliegueJava.git .

# esto es lo que deberia de ejecutar siempre para crear un .jar
RUN javac -d bin src/App.java && jar cfm output.jar manifest.mf -C bin .


# esto sobreescribe y mata a la maquina de arriba, la de arriba es solo para crear el .jar y copiarlo en la maquina siguiente
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/output.jar /app/output.jar

CMD ["java", "-jar", "output.jar"]