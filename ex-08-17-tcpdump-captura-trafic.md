---
id: EX-08-17
title: "Captura de trafic amb tcpdump - Explicat per a gent inexperta"
status: draft
version: 2.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - per-a-principiants
  - explicacio-detallada
prerequisites:
  - LAB-15-10
  - ANN-09
related:
  - LAB-15-10
  - ANN-08
  - ANN-09
estimated_time: 30 min
difficulty: beginner
---

# EX-08-17 - Captura de trafic amb tcpdump - Explicat per a gent inexperta

> Aprendre a capturar trafic de xarxa amb tcpdump.

## Que necessites saber

### Que es tcpdump?

**tcpdump** es una eina que **captura paquets** de xarxa. Es com posar una **cascada** a la xarxa i escoltar tot el que passa.

Permet veure tots els missatges que viatgen per una xarxa.

### Que es una interficie de xarxa?

Es la **connexio fisica o virtual** al teu equip. Cada PC te varies interficies:
- **eth0**: el cable de xarxa (Ethernet)
- **wlan0**: el WiFi
- **lo**: loopback (la propia maquina, 127.0.0.1)
- **br-XXX**: els bridges de Docker

### Que es sniffing?

**Sniffing** es **escoltar trafic** de xarxa que no va dirigit a tu. Es pot fer servir per:
- Depurar problemes de xarxa
- Analitzar vulnerabilitats
- Espiar (IL·LEGAL sense permis)

### Que es promiscuous mode?

Es el **mode** d'una interficie de xarxa on **accepta tots els paquets**, no nomes els que van dirigits a ella. tcpdump l'activa automaticament.

### Que es Wireshark?

**Wireshark** es una eina **grafica** per analitzar captures de xarxa. Et permet veure els paquets amb colorits, filtres, etc.

### Que es pcap?

**pcap** es el **format de fitxer** per guardar captures de xarxa. Es pot obrir amb Wireshark o tcpdump.

### Glossari

- **tcpdump**: eina de captura de trafic
- **interficie**: connexio de xarxa (eth0, wlan0, etc.)
- **sniffing**: escoltar trafic de xarxa
- **promiscuous mode**: mode on accepta tots els paquets
- **Wireshark**: eina grafica d'analisi
- **pcap**: format de captura de xarxa
- **paquet**: missatge de xarxa

## Que has de fer

1. Des del Kali, obre una terminal
2. Mira les interficies: `ip a` o `ifconfig`
3. Identifica el bridge Docker (br-...)
4. Captura trafic al bridge: `tcpdump -i br-XXX -c 20`
5. Captura nomes el port 80: `tcpdump -i br-XXX port 80 -c 10`
6. Captura i guarda: `tcpdump -i br-XXX -w captura.pcap -c 50`
7. Obre amb Wireshark: `wireshark captura.pcap`
8. Fes un curl a DVWA mentre captures: `curl http://10.10.30.10/`

## Que has de buscar

- Quantes interficies tens?
- Quin tipus de trafic veus? (TCP, UDP, ICMP)
- Pots veure els continguts?
- Quines IPs es comuniquen?
- Quin es el port mes comu?

## Preguntes que has de respondre

1. Que es tcpdump?
2. Per que es important poder capturar trafic?
3. Es legal capturar trafic d'una xarxa que no es teva?
4. Com podem xifrar el trafic?

## Si no entens alguna cosa

1. **Torna a llegir** la seccio "Que necessites saber"
2. **Mira** [ANN-09](ann-09-comencar-de-zero.md) - Guia per a gent inexperta
3. **Mira** [ANN-08](ann-08-glossari-ports.md) - Glossari de ports
4. **Pregunta** si segueixes sense entendre

## Solucio de problemes

Si alguna cosa no funciona:

1. **Comprova** que el lab esta actiu (`docker ps` al Kali)
2. **Comprova** que tens acces a Internet des del Kali
3. **Comprova** que la IP que estas fent servir es correcta
4. **Llegeix** l'error amb atencio - sovint diu que passa

## Validacio

Quan acabis, compara els teus resultats amb els del document [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md).

## Seguretat

**Recorda**:
- Aixo es **nomes per practicar** al lab
- Mai en sistemes **reals** sense permis
- Practicar sense permis es **IL·LEGAL**
- Si tens dubtes, pregunta

## Referencies

- [ANN-09](ann-09-comencar-de-zero.md) - Començar de zero
- [ANN-08](ann-08-glossari-ports.md) - Glossari de ports
- [LAB-15-10](../labs/lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
- [LAB-15-11](../labs/lab-15-11-nmap-complet-metaploitable2.md) - Nmap complet
