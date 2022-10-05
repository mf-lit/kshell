FROM ubuntu
RUN apt-get update && \
  apt-get install -y curl zip jq netcat-openbsd less bash-completion vim-tiny openssh-client dnsutils iputils-ping net-tools postgresql-client && \
  rm -rf /var/lib/apt/lists

RUN curl -o grpcurl.tgz -L https://github.com/fullstorydev/grpcurl/releases/download/v1.8.6/grpcurl_1.8.6_linux_x86_64.tar.gz && tar -xf grpcurl.tgz -C /usr/bin && rm -f grpcurl.tgz

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install && \
  rm -f awscliv2.zip && \
  echo 'complete -C '/usr/local/bin/aws_completer' aws' >>${HOME}/.bashrc

RUN curl -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.20.4/2021-04-12/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    mkdir ${HOME}/.kube && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>${HOME}/.bashrc && \
    echo 'complete -F __start_kubectl k' >>${HOME}/.bashrc && \
    echo 'source /etc/profile' >>${HOME}/.bashrc
