FROM debian:11.0

USER root

ARG ARTIFACTORY_TOKEN
ENV ARTIFACTORY_TOKEN=$ARTIFACTORY_TOKEN

RUN apt-get update
RUN apt-get install -y libc6 pkg-config build-essential libssl-dev libudev-dev librtlsdr-dev libpthread-stubs0-dev libgmp-dev protobuf-compiler unzip cmake golang libusb-1.0-0-dev curl git
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt -y install nodejs
RUN npm config set prefix /usr/local
RUN npm install -g npm
RUN npm install -g typescript@3.9.5 ts-node yarn --force
RUN npm install --global --save neon-cli@0.8.1


# Freezing nightly due to https://github.com/rust-lang/rust/issues/62562
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2019-10-01
RUN ln -sf $HOME/.cargo/bin/* /bin

RUN apt-get -y install redis-server

COPY pingpong-wallet /home/root/pingpong-wallet
RUN mv /home/root/pingpong-wallet/.npmrc.ci /home/root/pingpong-wallet/.npmrc

RUN chown -R root:root /home/root/pingpong-wallet

RUN cd /home/root/pingpong-wallet && yarn install

RUN cd /home/root/pingpong-wallet/pingpong-react && sh ../upgrade-dependency.sh pingpong-common-server && sh ../upgrade-dependency.sh pingpong-types && yarn install && yarn build

#RUN rm -rf /home/root/pingpong-wallet

#RUN chown -R root:root /usr/local/lib/node_modules

#RUN chown -R root:root /usr/local/share/.cache/yarn

#RUN cat /etc/subuid
#RUN cat /etc/subgid
#RUN find / \( -uid +65535 \) -ls 2>/dev/null || true
