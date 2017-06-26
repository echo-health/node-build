FROM node:8.1.2

ENV KUBOID_VERSION 0.2.0
ENV KUBECTL_VERSION 1.6.4
ENV DOCKER_VERSION 17.03.0-ce

RUN apt-get update -qq && \
    apt-get install -qy apt-transport-https lsb-release && \
    CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb https://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -qq && \
    apt-get install -qy google-chrome-stable google-cloud-sdk && \
    rm /etc/apt/sources.list.d/* && \
    curl -L -o "/tmp/docker-$DOCKER_VERSION.tgz" "https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz" && \
    tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz && \
    mv /tmp/docker/* /usr/bin && \
    yarn global add "@echo-health/kuboid@$KUBOID_VERSION" && \
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl