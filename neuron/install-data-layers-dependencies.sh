git clone --recurse-submodules -b v1.78.1 --depth 1 --shallow-submodules https://github.com/grpc/grpc

# from https://www.boost.org/doc/user-guide/getting-started.html
sudo apt update
sudo apt install -y libboost-all-dev

# from https://thrift.apache.org/docs/install/debian.html
sudo apt-get -y install automake bison flex g++ git libboost-all-dev libevent-dev libssl-dev libtool make pkg-config
git clone -b v0.23.0 --depth 1 https://github.com/apache/thrift

# Clean up
rm -rf /var/lib/apt/lists/*
