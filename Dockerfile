FROM ubuntu:24.04

#install verilator
ENV VERILATOR_VERSION=v5.020
RUN apt-get -y update && apt-get -y install wget sudo help2man git perl python3 make autoconf g++ flex bison cmake ninja-build  zlib1g zlib1g-dev python3-venv lcov \
    && git clone https://github.com/verilator/verilator && cd verilator && git checkout $VERILATOR_VERSION && autoconf && ./configure && make -j `nproc` && make install && cd .. && rm -rf verilator
RUN apt-get -y update && apt-get install -y cmake clang 
RUN touch /verilator-container
RUN useradd  --uid 1001  -ms /bin/bash docker
RUN echo "docker	ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
USER docker
