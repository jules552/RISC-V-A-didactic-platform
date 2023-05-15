FROM ubuntu:latest
WORKDIR /RiscV/
COPY . /RiscV/
RUN apt-get update && apt-get install -y iverilog