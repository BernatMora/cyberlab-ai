#!/bin/bash
# Aïlla la xarxa del lab (10.10.30.0/24) de la LAN i d'Internet
# Només permet trànsit entre contenidors del lab

# Netejar regles anteriors a DOCKER-USER
sudo iptables -D DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP 2>/dev/null
sudo iptables -D DOCKER-USER -s 10.10.30.0/24 ! -d 10.10.30.0/24 -j DROP 2>/dev/null

# Bloquejar lab -> LAN
sudo iptables -A DOCKER-USER -s 10.10.30.0/24 -d 192.168.1.0/24 -j DROP

# Bloquejar lab -> Internet (permetre només trànsit intern del lab)
sudo iptables -A DOCKER-USER -s 10.10.30.0/24 ! -d 10.10.30.0/24 -j DROP

echo "Regles d'aïllament aplicades"
sudo iptables -L DOCKER-USER -n -v
