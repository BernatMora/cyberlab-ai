---
id: ANN-09
title: "Començar de zero - Guia per a gent sense experiencia"
status: published
version: 1.0
created: 2026-08-07
updated: 2026-08-07
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - guia-inici
  - nivell-principiant
  - conceptes-basics
prerequisites: []
related:
  - ANN-08
  - CAP-00-01
estimated_time: 1 hora
difficulty: beginner
---

# ANN-09 - Començar de zero

> Guia per a gent **totalment inexperta** que vol entendre el CyberLab.

## A qui va dirigit?

Aquesta guia es per a tu si:
- No saps que es una **IP**
- No saps que es un **port**
- No saps que es **SSH**
- No saps que es una **base de dades**
- No saps que es **Linux**
- No saps que es una **xarxa**

Si ja saps aquestes coses, pots saltar-te aquesta guia.

## Quines coses necessites saber abans de començar?

### 1. Que es un ordinador?

Un ordinador es una maquina que fa calculs. Tot el que hi ha a dins (processador, memoria, disc) son components electronics que entenen nomes 0 i 1.

Aixo es el que veus quan mires un PC o portatil:
- **Pantalla**: on es veuen les coses
- **Teclat**: per escriure
- **Ratoli**: per moures
- **CPU**: el "cervell" que fa els calculs
- **RAM**: la memoria temporal (s'esborra quan pares l'ordinador)
- **Disc dur**: on es guarden les coses permanentment

### 2. Que es un sistema operatiu?

El **sistema operatiu** es el programa que controla l'ordinador. N'hi ha de molts tipus:
- **Windows**: el mes comu, de Microsoft
- **macOS**: el d'Apple
- **Linux**: gratuit i open source (Kali, Ubuntu, etc.)

Al CyberLab utilitzem **Kali Linux**, que es una versio especialitzada en seguretat informatica.

### 3. Que es una xarxa?

Una **xarxa** es quan dos o mes ordinadors es connecten entre ells per compartir informacio.

Pensa-ho com una **conversa**: dos ordinadors poden "parlar" entre ells, igual que dues persones poden parlar per telefon.

**Tipus de xarxes**:
- **LAN** (Local Area Network): la teva xarxa de casa
- **WiFi**: xarxa sense fils
- **Internet**: la xarxa global (tots els ordinadors del mon connectats)

### 4. Que es una IP?

Una **IP** es com l'adreça d'un ordinador a la xarxa. Igual que una casa te una adreça (carrer, numero, pis), un ordinador te una IP.

Exemple d'IP: `192.168.1.100`

Una IP te **4 numeros** separats per punts, cada numero entre 0 i 255.

- **192.168.1.100**: un PC a la teva xarxa de casa
- **10.0.0.1**: un router
- **8.8.8.8**: un servidor de Google

### 5. Que es un port?

Un **port** es com una **porta** de l'ordinador. Cada port te un numero (del 0 al 65535) i serveix per alguna cosa concreta.

Pensa-ho aixi:
- El **carrer** es la IP (adreça)
- El **numero de casa** es el port

Cada servei te el seu port:
- **Port 80**: pagines web normals
- **Port 443**: pagines web segures
- **Port 22**: acces remot segur (SSH)
- **Port 21**: transferencia de fitxers (FTP)

Al lab trobaras **20+ ports oberts** amb serveis diferents.

**Mes info**: [ANN-08](ann-08-glossari-ports.md) - Glossari complet de ports.

### 6. Que es SSH?

**SSH** (Secure Shell) es un sistema per **entrar remotament** a un altre ordinador de forma segura.

Imagina't que vols utilitzar un PC que es a una altre habitacio. SSH et permet controlar-lo desde el teu PC com si estiguesis allà.

**Exemple d'us**:
- Vull accedir al PC del hort desde la feina
- Utilitzo SSH per entrar-hi
- Puc executar comandes com si estigues allà

**Comandes basiques**:
```bash
# Entrar al PC hort
ssh hort-osona@hort

# Sortir
exit
```

### 7. Que es una terminal?

Una **terminal** es una finestra on escrius **comandes de text** per controlar l'ordinador.

En lloc de fer clic al ratoli, escrius ordres amb el teclat.

Exemple:
```bash
# Veure els fitxers
ls

# Veure on soc
pwd

# Qui soc
whoami
```

Al CyberLab, **totes les ordres son comandes de terminal**.

### 8. Que es Kali Linux?

**Kali Linux** es una distribucio de Linux especialitzada en **seguretat informatica**. Es com una "caixa d'eines" amb centenars de programes ja instal·lats per practicar.

Algunes eines que porta:
- **nmap**: per veure quins serveis hi ha
- **nikto**: per trobar vulnerabilitats web
- **sqlmap**: per fer SQL injection
- **wireshark**: per capturar trafic de xarxa
- **hydra**: per fer brute force
- I moltes mes!

### 9. Que es Docker?

**Docker** es un sistema que permet executar **aplicacions dins de caixes aillades** (contenidors).

Pensa-ho aixi:
- En lloc d'instal·lar una web al teu PC (que podria fer malbé coses), la poses dins una **caixa**
- La caixa te el seu propi sistema, fitxers, xarxa
- Si fas malbé la caixa, el teu PC esta be

Al lab tenim **3 caixes (contenidors)**:
- **DVWA**: una web vulnerable
- **Juice Shop**: una altra web vulnerable
- **Metasploitable2**: una maquina antiga amb molts serveis vulnerables

### 10. Que es una vulnerabilitat?

Una **vulnerabilitat** es un **forat de seguretat**. Es una porta oberta que un atacant pot aprofitar.

Pensa-ho com una finestra oberta en una casa. Si no la tanques, algu pot entrar.

Tipus de vulnerabilitats:
- **Contrasenya feble**: com una porta sense pany
- **Software antic**: com una porta amb pany antic que es pot forçar
- **Configuracio dolenta**: com deixar les claus a sota del paldo

### 11. Que es un atac?

Un **atac** es quan algu intenta entrar a un sistema sense permis.

Tipus d'atacs:
- **Brute force**: provar totes les contrasenyes possibles
- **SQL injection**: manipular la base de dades
- **XSS**: injectar codi malicios a una web
- **Phishing**: enganyar-te perque donis la teva contrasenya
- **Malware**: software malicios

### 12. Que es una contrasenya forta?

Una **contrasenya forta** es dificil d'endevinar.

**Dolenta** (facil d'endevinar):
- `123456`
- `password`
- `nomdelgos`

**Bona** (dificil d'endevinar):
- `c0rR3ct-H0rse-Battery-Staple!`
- `La-meva-gata-es-groga-1990`

**Regles**:
- Mes de 12 caracters
- Mesclar majuscules i minuscules
- Incloure numeros i simbols
- No utilitzar paraules comunes
- No repetir entre serveis

### 13. Que es una IP publica i una IP privada?

- **IP privada**: nomes funciona a la teva xarxa local (192.168.x.x, 10.x.x.x)
- **IP publica**: funciona a Internet (tot el que es accessible desde fora)

El teu PC a casa te una IP privada (192.168.1.100, per exemple). Pero quan visites Google, el teu router te una IP publica que tothom pot veure.

### 14. Que es Tailscale?

**Tailscale** es una eina que et permet accedir als teus equips de forma segura desde qualsevol lloc del mon.

Pensa-ho com una **VPN**, pero mes facil d'utilitzar.

Amb Tailscale pots:
- Accedir al teu PC de casa desde la feina
- Accedir al PC del hort desde qualsevol lloc
- Compartir fitxers entre equips
- Tot de forma **xifrada**

### 15. Que es una IP de Tailscale?

Una **IP de Tailscale** es una IP que nomes funciona dins la teva xarxa privada de Tailscale.

Exemple:
- `100.97.77.87` es el PC hort
- `100.82.142.113` es el teu PC de la feina

Aquestes IPs nomes funcionen si tens Tailscale instal·lat.

## Comandes essencials que has de saber

Aquestes son les **comandes minim necessaries** per moure't pel lab:

### Navegacio
```bash
pwd      # Mostra on ets
ls       # Llista els fitxers
cd       # Canvia de directori
cd ..    # Puja un nivell
cd ~     # Vés a la teva home
```

### Fitxers
```bash
cat fitxer.txt    # Mostra el contingut
nano fitxer.txt   # Edita un fitxer (Ctrl+O per guardar, Ctrl+X per sortir)
mkdir dir         # Crea un directori
rm fitxer         # Esborra un fitxer
cp a b            # Copia a -> b
mv a b            # Mou a -> b
```

### Xarxa
```bash
ping 8.8.8.8                    # Comprova connexio
ssh usuari@IP                   # Entra a un altre PC per SSH
nmap IP                         # Escaneja ports
curl http://IP                   # Accedeix a una web
```

### Sistema
```bash
whoami        # Qui soc jo
uname -a      # Info del sistema
ps aux        # Processos actius
top           # Monitor del sistema
df -h         # Espai de disc
```

### Docker
```bash
docker ps                  # Contenidors actius
docker ps -a               # Tots els contenidors
docker exec -it dvwa bash  # Entrar al contenidor
docker logs dvwa           # Veure els logs
```

## El lab que tens preparat

Quan entris al Kali (PC hort), tens acces a:

- **DVWA** (10.10.30.10): web vulnerable per practicar
- **Juice Shop** (10.10.30.20): altra web vulnerable
- **Metasploitable2** (10.10.30.30): 20+ serveis amb vulnerabilitats

**Com accedir-hi**:

Des del teu PC de la feina (Windows):
```powershell
ssh hort-osona@hort
# Ara soc al Kali
nmap 10.10.30.0/24
# Veig tots els serveis del lab
```

## Ordre recomanat per practicar

1. **Llegeix** aquesta guia (acabes de fer-ho!)
2. **Llegeix** [ANN-08](ann-08-glossari-ports.md) - Glossari de ports
3. **Comença** amb [EX-08-14](exercises/ex-08-14-nmap-port-scanning-complet.md) - Nmap
4. **Despres** amb [EX-08-22](exercises/ex-08-22-sql-injection-manual-dvwa.md) - SQL injection
5. **Continua** amb la resta d'exercicis

## Si no entens alguna cosa

1. **Pregunta** al autor del projecte
2. **Busca** a Google: "que es X" on X es el terme
3. **Mira** els altres documents del CyberLab

## Seguretat personal

**IMPORTANT**:
- Practica nomes al teu **lab** (DVWA, Juice Shop, Metasploitable2)
- Mai en sistemes **reals** sense permis
- Practicar sense permis es **IL·LEGAL**
- Si tens dubtes, pregunta abans de fer res

## Paraules clau importants

Aquestes son les **10 paraules** que mes necessites saber:

1. **IP**: adreça d'un ordinador a la xarxa
2. **Port**: porta d'un servei a l'ordinador
3. **SSH**: acces remot segur
4. **Vulnerabilitat**: forat de seguretat
5. **Exploit**: codi que aprofita una vulnerabilitat
6. **Docker**: sistema de contenidors
7. **Tailscale**: xarxa privada VPN
8. **Metasploitable2**: maquina vulnerable per practicar
9. **DVWA**: web vulnerable
10. **Kali Linux**: sistema operatiu per a seguretat

## Referencies

- [ANN-08](ann-08-glossari-ports.md) - Glossari complet de ports
- [CAP-00-01](../chapters/cap-00-01-benvinguda.md) - Benvinguda al CyberLab
- [LAB-15-10](lab-15-10-lab-real-muntat.md) - Lab real muntat al Kali
