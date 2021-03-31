FROM ubuntu:bionic-20200219

ARG TERRAFORM_VERSION="0.14.9"
ARG ANSIBLE_VERSION="2.8.0"
ARG PACKER_VERSION="1.7.0"
ARG AWSCLI_VERSION="1.18.19"

LABEL maintainer="Yaroslav Buts <buts2695@gmail.com>"
LABEL terraform_version=${TERRAFORM_VERSION}
LABEL ansible_version=${ANSIBLE_VERSION}
LABEL aws_cli_version=${AWSCLI_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV AWSCLI_VERSION=${AWSCLI_VERSION}
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}
ENV PACKER_VERSION=${PACKER_VERSION}
RUN apt-get update \
    && apt-get install -y curl python3 python3-pip python3-boto unzip  \
    && pip3 install --upgrade awscli==${AWSCLI_VERSION} \
    && pip3 install ansible==2.9 \
    && curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl -LO https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip '*.zip' -d /usr/local/bin \
    && rm *.zip

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD    ["/bin/bash"]
