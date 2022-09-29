FROM ubuntu:latest
WORKDIR /syz
RUN apt update && apt upgrade -y
RUN apt install sudo 
RUN sudo apt install -y git make apt-utils gcc flex bison libncurses-dev libelf-dev libssl-dev g++ bc debootstrap vim qemu-system-x86 build-essential openssh-client golang-go
COPY . .
WORKDIR /syz/linux
RUN make -j`nproc`
WORKDIR /syz/image
RUN chmod +x create-image.sh
# RUN ./create-image.sh --feature full
WORKDIR /syz/syzkaller/
RUN make
RUN mkdir workdir
EXPOSE 56741
WORKDIR /syz/