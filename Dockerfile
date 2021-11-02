FROM telegraf:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    mtr speedtest-cli

RUN rm -rf /var/lib/apt/lists/*

RUN usermod -G video telegraf

RUN setcap cap_net_raw+ep /usr/bin/telegraf
RUN setcap cap_net_raw+ep /usr/bin/mtr
RUN setcap cap_net_raw+ep /usr/bin/speedtest

USER telegraf

EXPOSE 8125/udp 8092/udp 8094

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
