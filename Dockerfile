FROM telegraf:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends mtr-tiny && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN usermod -G video telegraf

RUN wget -O speedtest.tgz "https://install.speedtest.net/app/cli/ookla-speedtest-1.0.0-x86_64-linux.tgz"; \
    tar -xvf speedtest.tgz -C /usr/bin speedtest; \
    rm speedtest.tgz; \
    speedtest --version

RUN setcap cap_net_raw+ep /usr/bin/telegraf
RUN setcap cap_net_raw+ep /usr/bin/mtr
RUN setcap cap_net_raw+ep /usr/bin/speedtest

EXPOSE 8125/udp 8092/udp 8094

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
