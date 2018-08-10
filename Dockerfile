FROM ubuntu:xenial

LABEL maintainer="weitsung@google.com,jiayingz@google.com"

RUN apt update -qq && apt install -y -qq git make gcc libc6-dev libssl-dev zlib1g-dev
RUN git clone https://github.com/aerospike/act.git

WORKDIR /act

RUN make
RUN make -f Makesalt

COPY actconfig_1x_1d.txt ./
COPY actconfig_3x_1d.txt ./
COPY actconfig_6x_1d.txt ./

CMD ["printf", "Usage:\n docker run --name act --device /dev/nvme0n1 fasthall/aerospike-act ./act actconfig_6x_1d.txt > output.txt\n"]
