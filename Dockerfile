FROM ubuntu:22.04

RUN apt-get update \
 && apt-get install -y curl wget sudo unzip \
 && apt-get clean

# Install aws-cli 2.0
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && sudo ./aws/install \
 && rm -rf awscliv2.zip aws \
 && /usr/local/bin/aws --version

# Install kubectl
# https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
RUN curl https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.9/2023-01-11/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && kubectl version || true

# Install k9s
# https://github.com/derailed/k9s/releases
RUN wget --progress dot:giga https://github.com/derailed/k9s/releases/download/v0.27.2/k9s_Linux_amd64.tar.gz -O k9s_Linux_amd64.tar.gz \
 && tar -xzf k9s_Linux_amd64.tar.gz \
 && chmod +x k9s \
 && mv k9s /usr/local/bin/ \
 && rm -f k9s_Linux_amd64.tar.gz \
 && /usr/local/bin/k9s version

# Fix the bash paste issue
RUN echo "set enable-bracketed-paste off" > ~/.inputrc

WORKDIR /root
