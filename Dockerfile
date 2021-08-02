FROM ubuntu:hirsute as build
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y upgrade
RUN apt-get -y --fix-missing install gcc ccache cmake autoconf wget golang bison libncurses-dev build-essential
RUN wget -qO- https://binaries.cockroachdb.com/cockroach-v21.1.5.src.tgz | tar  xvz
WORKDIR cockroach-v21.1.5
RUN make build
RUN make install
FROM ubuntu:latest
RUN apt-get update && apt-get -y upgrade && apt-get install -y libc6 ca-certificates tzdata && rm -rf /var/lib/apt/lists/*
WORKDIR /cockroach/
ENV PATH=/cockroach:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV COCKROACH_CHANNEL=kubernetes-insecure
RUN mkdir -p /cockroach/
COPY --from=build /usr/local/bin/cockroach /cockroach/cockroach
EXPOSE 26257 8080
ENTRYPOINT ["/cockroach/cockroach"]
