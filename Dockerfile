FROM telegraf:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends mtr-tiny dnsutils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*; \
    usermod -G video telegraf; \
    chown telegraf:telegraf /etc/telegraf -R; \
    setcap cap_net_raw+ep /usr/bin/telegraf; \
    setcap cap_net_raw+ep /usr/bin/mtr

EXPOSE 8125/udp 8092/udp 8094

USER telegraf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
