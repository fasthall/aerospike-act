FROM ubuntu:xenial

LABEL maintainer="weitsung@google.com,jiayingz@google.com"

RUN apt update -qq && apt install -y -qq git make gcc libc6-dev libssl-dev zlib1g-dev
RUN git clone https://github.com/aerospike/act.git

WORKDIR /act

RUN make
RUN make -f Makesalt

COPY *.txt ./
COPY run.sh ./

CMD ["printf", "Usage:\n docker run --name act --device DEVICE fasthall/aerospike-act sh run.sh DEVICE CONFIG\n"]
