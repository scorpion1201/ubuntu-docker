FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ENV TERM=xterm-256color
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade

RUN apt-get update && apt-get install -y ubuntu-server

RUN apt-get update && apt-get install -y zsh
RUN chsh -s /bin/zsh

RUN apt-get update && apt-get install -y openssh-server sudo git
RUN update-rc.d ssh defaults

RUN useradd -m -d /home/ubuntu -s /bin/zsh -G sudo ubuntu
RUN echo 'ubuntu:ubuntu' | chpasswd

USER ubuntu
RUN mkdir -p /home/ubuntu/.ssh
RUN mkdir -p /home/ubuntu/projects

USER root
EXPOSE 22
VOLUME /home/ubuntu/projects
SHELL [ "/bin/zsh" ]
CMD ["/usr/sbin/sshd", "-D"]
