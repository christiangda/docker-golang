FROM fedora:24

MAINTAINER Christian González <christiangda@gmail.com>

LABEL Description="The Go Programming Language docker image" Vendor="Christian González" Version="1.0.3"
LABEL Build docker build --no-cache --rm --tag christiangda/golang:1.0.3 --tag christiangda/golang:latest .

ENV container docker

# Update and install base packages
#RUN dnf update -y --setopt=tsflags=nodocs --setopt=deltarpm=0 && \
RUN dnf install -y --setopt=tsflags=nodocs --setopt=deltarpm=0 \
    procps-ng \
    net-tools \
    iproute \
    tar \
    git \
    wget && \
  dnf clean all && \
  cd /tmp/ && \
  wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf /tmp/go1.7.3.linux-amd64.tar.gz && \
  rm -rf /tmp/* /var/tmp/* /var/cache/dnf/* /var/log/anaconda/* /var/log/dnf.*

ENV GOROOT "/usr/local/go"
ENV PATH $GOROOT/bin:$PATH

# Install godep
ENV GOPATH "/usr/local/godep"
RUN go get github.com/tools/godep
ENV PATH $GOPATH/bin:$PATH

# run container service
CMD ["/usr/local/go/bin/go", "version"]
