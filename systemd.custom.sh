##
# /etc/systemd/system/uptime-logger.service
##

[Unit]
Description=systemd practice.

[Service]
ExecStart=/bin/sh /usr/local/bin/uptime-logger

[Install]
WantedBy=multi-user.target