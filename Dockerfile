FROM telegraf:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends mtr-tiny && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*; \
    usermod -G video telegraf; \
    wget -O speedtest.tgz "https://install.speedtest.net/app/cli/ookla-speedtest-1.0.0-x86_64-linux.tgz"; \
    tar -xvf speedtest.tgz -C /usr/bin speedtest; \
    rm speedtest.tgz; \
    speedtest --accept-license --accept-gdpr; \
    mkdir -p /etc/telegraf/.config/ookla; \
    cp /root/.config/ookla/speedtest-cli.json /etc/telegraf/.config/ookla/speedtest-cli.json; \
    chown telegraf:telegraf /etc/telegraf -R; \
    setcap cap_net_raw+ep /usr/bin/telegraf; \
    setcap cap_net_raw+ep /usr/bin/mtr; \
    setcap cap_net_raw+ep /usr/bin/speedtest

EXPOSE 8125/udp 8092/udp 8094

USER telegraf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
