---
id: EX-08-17
title: "Captura de trafic amb tcpdump"
status: draft
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - tcpdump
  - xarxa
  - sniffing
  - nivell-principiant
prerequisites:
  - LAB-15-10
related:
  - LAB-15-10
  - LAB-15-11
estimated_time: 30 min
difficulty: beginner
---

# EX-08-17 - Captura de trafic amb tcpdump

> Capturar i analitzar trafic de xarxa amb tcpdump.

## Que has de fer

1. Des del Kali, obre una terminal
2. Comprova les interficies: `ip a` o `ifconfig`
3. Captura trafic al bridge Docker: `tcpdump -i br-e3b7b7768083 -c 20`
4. Captura nomes trafic al port 80: `tcpdump -i br-e3b7b7768083 port 80 -c 10`
5. Captura i guarda a un fitxer: `tcpdump -i br-e3b7b7768083 -w captura.pcap -c 50`
6. Obre el fitxer amb Wireshark: `wireshark captura.pcap`
7. Genera trafic fent un curl a DVWA mentre captures: `curl http://10.10.30.10/`

## Que has de buscar

- Quantes interficies de xarxa tens?
- Quin tipus de trafic has vist? (TCP, UDP, ICMP)
- Com pots veure els continguts? (payload)
- Quants bytes ha passat per xarxa?
- Quines IPs es comuniquen?

## Preguntes per respondre

1. Quantes interficies has vist?
2. Quin es el trafic mes comu?
3. Com podem xifrar el trafic? (HTTPS)
4. Es legal capturar trafic a una xarxa que no es teva?

## Glossari

- **tcpdump**: Eina de linia de comandes per capturar trafic de xarxa.
- **sniffing**: Escoltar trafic de xarxa que no va dirigit a tu.
- **promiscuous mode**: Mode de la interficie de xarxa on accepta tots els paquets, no nomes els seus.
- **pcap**: Format de fitxer per guardar captures de xarxa.
- **Wireshark**: Eina grafica per analitzar captures de xarxa.

## Validacio

Quan acabis, compara els teus resultats amb els del document [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md).

## Seguretat

**Recorda**: 
- Aquestes tecniques nomes sha d'utilitzar en entorns controlats (com aquest lab)
- Mai en sistemes reals sense permis
- Practicar sense permis es IL·LEGAL

## Referencies

- [LAB-15-10](../labs/lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
- [EX-08-01](ex-08-01-nmap-metasploitable.md) - Nmap Metasploitable
- [EX-08-02](ex-08-02-sql-injection-dvwa.md) - SQL Injection DVWA
