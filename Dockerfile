FROM ubuntu:latest
WORKDIR /RiscV/
COPY . /RiscV/
RUN mkdir -p bin
RUN apt-get update && apt-get install -y iverilog