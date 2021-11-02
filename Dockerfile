FROM telegraf:latest

ARG ARCH

RUN apt-get update && apt-get install -y --no-install-recommends \
    mtr \
    speedtest-cli && \
    rm -rf /var/lib/apt/lists/* && \
    usermod -G video telegraf \
    setcap cap_net_raw+ep /usr/bin/telegraf \
    setcap cap_net_raw+ep /usr/bin/mtr \
    setcap cap_net_raw+ep /usr/bin/speedtest

EXPOSE 8125/udp 8092/udp 8094

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
