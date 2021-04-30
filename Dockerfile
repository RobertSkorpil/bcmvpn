FROM debian:buster
RUN apt update
RUN apt -y install openconnect procps sudo systemd dbus realmd dmidecode openssh-server ca-certificates c3270 openssl iptables iproute2 net-tools
RUN useradd -rm -d /home/user0 -s /bin/bash -g root -u 1000 -p $(openssl passwd -1 user0) user0 && usermod -aG sudo user0
ADD sudoers /etc/sudoers
ADD vpn-router-start.sh /usr/local/sbin/vpn-router-start.sh
ADD vpn-router.service /etc/systemd/system
RUN chmod u+x /usr/local/sbin/vpn-router-start.sh
USER user0
ADD .bash_history /home/user0
ADD hipreport.sh /home/user0
USER root
RUN systemctl enable ssh.service
RUN systemctl enable vpn-router.service
ENTRYPOINT [ "/sbin/init" ]
