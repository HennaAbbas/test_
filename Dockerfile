FROM cimg/node:19.3.0
# USER root

# RUN apt-get update
# RUN apt-get install -y libc6 pkg-config build-essential libssl-dev libudev-dev librtlsdr-dev libpthread-stubs0-dev libgmp-dev protobuf-compiler unzip cmake golang libusb-1.0-0-dev curl git
# RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
# RUN apt -y install nodejs
# RUN npm config set prefix /usr/local
# RUN npm install -g npm 
# RUN npm install -g typescript@3.9.5 ts-node yarn --force
RUN npm install neon-cli@0.10.1 

# Freezing nightly due to https://github.com/rust-lang/rust/issues/62562
# RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2019-10-01
# RUN ln -sf $HOME/.cargo/bin/* /bin

# RUN apt-get -y install redis-server


