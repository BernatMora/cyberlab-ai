---
id: ANN-05
title: "Xuleta de comandes"
status: published
version: 1
created: 2026-07-28
updated: 2026-07-28
authors:
  - Bernat Mora
type: cheatsheet
related:
  - CAP-01-60
  - CAP-04-10
  - CAP-08-20
---

# ANN-05 — Xuleta de comandes

> Totes les ordres útils del laboratori, organitzades per categoria. **Sempre
> amb placeholders** (cap valor real). Aquesta xuleta té una versió PDF
> generada automàticament pel projecte (veure [`scripts/cheatsheet/build-pdf.sh`](../../scripts/cheatsheet/build-pdf.sh)).

Aquest annex és una **referència ràpida**: per aprendre amb profunditat
qualsevol tema, consulta el capítol corresponent del llibre.

---

## 🐧 Ollama (al Mac potent de casa, quan s'instal·li)

```bash
ollama launch hermes --model <MODEL_PLACEHOLDER>
```

## 💻 PowerShell (Windows — preparació ISO i USB)

### Verificar SHA256 d'una ISO

```powershell
Get-FileHash "C:\Users\<USER>\Downloads\<ISO_NAME>.iso" -Algorithm SHA256
```

### Veure particions i tipus (GPT/MBR)

```powershell
Get-Disk | Format-Table Number, FriendlyName, PartitionStyle, OperationalStatus -AutoSize
(Get-Disk -Number 0).PartitionStyle
```

### Veure volums i unitats del sistema

```powershell
Get-Volume | Format-Table DriveLetter, FileSystemLabel, Size, Path -AutoSize
```

### Llistar ISOs descarregades a Downloads

```powershell
Get-ChildItem "C:\Users\<USER>\Downloads\*.iso"
```

### Copiar una ISO a l'USB (Ventoy o similar)

```powershell
Copy-Item "C:\Users\<USER>\Downloads\<ISO_NAME>.iso" -Destination "<USB_LETTER>:\"
```

## 🔧 Rufus (eina gràfica)

### Per gravar una Live ISO amb persistència
1. Descarregar Rufus portable des de https://www.rufus.ie
2. Connectar USB.
3. **Device**: triar el USB correcte (comprovar mida!).
4. **Boot selection**: clicar SELECCIONAR → triar la ISO.
5. **Partition scheme**: **GPT** (UEFI modern) o **MBR** (BIOS antic).
6. **Persistent partition size**: moure el slider (32-64 GB).
7. **START**.
8. Si surt el diàleg "ISO mode DD", vol dir que la ISO és ISOHybrid —
   cal ISO Live per persistència real.

## 🚀 Ventoy (eina gràfica)

### Instal·lació a l'USB
1. Descarregar des de https://www.ventoy.net/en/download.html
2. Connectar USB.
3. Obrir Ventoy → seleccionar USB → **Install**.
4. Crea dues particions: una petita (Ventoy) + una gran buida.

### Ús diari
- Copiar ISOs a la partició gran.
- En arrencar, Ventoy mostra menú per triar quina ISO carregar.

## 🛠️ Instal·lar Kali al PC de l'hort

### Requisits
- USB amb Kali Live o Installer.
- PC de l'hort connectat per cable al router 4G (preferible Wi-Fi).
- Disposar del PC de l'hort físicament per prémer tecles.

### Pas a pas
1. Connectar l'USB al PC.
2. Apagar i encendre.
3. Prémer F12 (o tecla del fabricant) per entrar al menú d'arrencada.
4. Triar el USB.
5. Al menú de Ventoy, triar la ISO de Kali.
6. Triar Install o Graphical Install.
7. Configurar:
   - Idioma: Català o Anglès.
   - Xarxa: per cable, automàtica.
   - Nom d'amfitrió: `cyber-host`.
   - Usuari: el teu nom d'usuari.
   - Contrasenya: una forta (a KeePassXC!).
   - Disc: usar tot el disc (esborrarà tot!).
   - GRUB: instal·lar a `/dev/sda`.
8. Esperar 15-30 min.
9. Reiniciar, treure l'USB.

### Verificar

```bash
whoami
uname -a
ip a      # buscar la interfície amb IP 192.168.x.x
```

## 🔗 Tailscale — instal·lació i ús

Tailscale crea una xarxa privada virtual (VPN mesh) entre tots els
dispositius. Permet accedir al lab de l'hort des de qualsevol lloc,
ignorant CGNAT i IPs dinàmiques.

### Per què serveix
- SSH al lab des del Mac de casa, del mòbil, etc.
- Resol CGNAT (NAT traversal automàtic).
- Compatible amb IP dinàmica.
- Xifrat punta a punta (WireGuard).

### Instal·lació al PC de l'hort

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

Si dóna error de DNS:

```bash
sudo systemctl enable --now tailscaled
sudo tailscale up
```

### Instal·lació al Mac (casa o hort)

```bash
# Opció 1: brew
brew install --cask tailscale

# Opció 2: descarregar de https://tailscale.com/download
```

### Obtenir la IP dins del tailnet

```bash
sudo tailscale ip -4
```

Retorna `100.x.y.z`. Anota-la.

### Accedir des d'un altre dispositiu

1. Instal·lar Tailscale al client.
2. Login amb el mateix compte.
3. SSH:

```bash
ssh <USER>@cyber-host      # o per IP: ssh <USER>@100-x-y-z
```

### Estat del tailnet

```bash
tailscale status
```

Apareixen tots els dispositius connectats i les seves IPs.

### Apagar / encendre Tailscale

```bash
sudo tailscale down
sudo tailscale up
```

## 💻 Ordres Kali bàsiques (al PC de l'hort)

### Identitat i xarxa

```bash
whoami                      # usuari actual
uname -a                    # versió del kernel
hostname                    # nom del sistema
ip a                        # totes les interfícies
ip route                    # ruta per defecte
ping -c 4 8.8.8.8           # provar sortida a Internet
ping -c 4 google.com        # igual amb nom
```

### Sistema de fitxers

```bash
ls                          # llistar
ls -la                      # amb ocults
pwd                         # on sóc
cd /tmp                     # canviar
cat fitxer.txt              # veure contingut
less /var/log/syslog        # veure logs
df -h                       # espai en disc
free -h                     # memòria
```

### Usuaris i permisos

```bash
who                         # usuaris connectats
sudo ordre                  # executar com a root
su - usuari                 # canviar d'usuari
chmod 755 fitxer            # canviar permisos
chown user:group fitxer     # canviar propietari
```

### Processos i serveis

```bash
ps aux                      # processos actius
top                         # monitor en temps real
htop                        # versió millorada (instal·lar-la)
systemctl status servei     # estat d'un servei
sudo systemctl start servei
sudo systemctl stop servei
sudo systemctl restart servei
sudo systemctl enable servei
```

### Xarxa avançada

```bash
ss -tulnp                   # ports oberts
ip neigh                    # taula ARP
arp -a                      # clients connectats al router
```

### Actualitzar el sistema

```bash
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
```

## 🛡️ Eines de seguretat essencials (a Kali)

### nmap — escàner de xarxa

```bash
nmap 192.168.1.1            # un host
nmap 192.168.1.0/24         # tota la xarxa
nmap -sV 192.168.1.1        # versions de serveis
nmap -A 192.168.1.1         # detecció agressiva
nmap -p- 192.168.1.1        # tots els ports
nmap -sS 192.168.1.1        # SYN stealth
nmap -sn 192.168.1.0/24     # només hosts (ping sweep)
```

### wireshark — captura de tràfic (gràfica)

```bash
sudo wireshark
# triar interfície (eth0 per cable, wlan0 per WiFi)
# filtres: http, tcp.port == 80, ip.addr == 192.168.1.1
```

Alternativa terminal (tcpdump):

```bash
sudo tcpdump -i eth0
sudo tcpdump -i wlan0 -w captura.pcap
sudo tcpdump -r captura.pcap
```

### aircrack-ng — auditoria WiFi

Cal una clau WiFi USB amb mode monitor (RT3070 o RTL8812AU).

```bash
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon
sudo airodump-ng -c 1 --bssid XX:XX:XX:XX:XX:XX -w captura wlan0mon
sudo aircrack-ng captura-01.cap
```

### hydra — força bruta de login

```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt 192.168.1.1 ssh
hydra -l admin -P /usr/share/wordlists/rockyou.txt 192.168.1.1 http-get
```

### john — cracker de contrasenyes

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
john --show hash.txt
```

### netcat (ncat) — eines de xarxa

```bash
nc -lvp 4444                # port d'escolta
nc 192.168.1.1 80           # connectar
sudo ncat -lvnp 4444        # variant moderna
```

### gobuster / dirb — descoberta web

```bash
gobuster dir -u http://192.168.1.1 -w /usr/share/wordlists/dirb/common.txt
dirb http://192.168.1.1
```

## 📋 Procediment: primera sessió de pràctiques

1. Connectar al router 4G de Parlem.
2. Obrir terminal.
3. Veure la IP:

```bash
ip a | grep 192
```

4. Calcular el rang. Si la IP és `192.168.1.42`, la xarxa és `192.168.1.0/24`.
5. Escanejar tota la xarxa:

```bash
nmap -sn 192.168.1.0/24
```

6. Identificar tots els dispositius.
7. Triar-ne un (mai el router!) i fer un escaneig més profund:

```bash
nmap -sV 192.168.1.42
```

8. Anotar ports i serveis.

## 🧪 Exercicis guiats (sense risc)

### Metasploitable 2

1. Descarregar de https://sourceforge.net/projects/metasploitable/
2. Importar a VirtualBox (dins del PC de l'hort).
3. Iniciar la VM.
4. Des de Kali:

```bash
nmap 192.168.x.0/24     # descobrir la IP de Metasploitable
nmap -sV -p- 192.168.x.x
```

5. Usar Metasploit:

```bash
msfconsole
search vsftpd
use exploit/unix/ftp/vsftpd_234_backdoor
set RHOSTS 192.168.x.x
exploit
```

### DVWA (Damn Vulnerable Web App)

1. Dins de Kali:

```bash
sudo apt install dvwa
# o descarregar de https://github.com/digininja/DVWA
```

2. Accedir a `http://127.0.0.1/dvwa` des del navegador.
3. Setup → crear / reset database.
4. Login amb `admin/password`.
5. Security level: Low.
6. SQL Injection, XSS, Command Injection, File Inclusion...

## 🌐 Plataformes d'aprenentatge en línia

- **TryHackMe**: https://tryhackme.com — guiat, ideal per començar.
- **HackTheBox Academy**: https://academy.hackthebox.com — més avançat.
- **OverTheWire**: https://overthewire.org/wargames/ — wargames.
- **PortSwigger Web Security Academy**: https://portswigger.net/web-security — web security gratuït.
- **VulnHub**: https://www.vulnhub.com — màquines virtuals vulnerables.

## 📖 Glossari ràpid

| Terme | Definició |
|---|---|
| **Live ISO** | Imatge que arrenca sense instal·lar |
| **Persistència** | Guardar canvis entre arrencades en USB Live |
| **ISOHybrid** | ISO que es pot gravar a CD/DVD o USB |
| **GPT / MBR** | Esquemes de partició. GPT per UEFI, MBR per BIOS antics |
| **CGNAT** | Carrier-Grade NAT. Operador comparteix IP pública entre clients |
| **Tailscale** | VPN mesh basat en WireGuard |
| **WireGuard** | Protocol VPN modern, molt ràpid |
| **nmap** | Eina d'escaneig de xarxa |
| **Wireshark** | Analitzador de protocols de xarxa |
| **Metasploit** | Framework d'explotació amb milers d'exploits |
| **DVWA** | Aplicació web vulnerable per practicar |
| **Kali Linux** | Distribució Linux per a pentesting |
| **Lab** | Entorn controlat per practicar seguretat |
| **Pentesting** | Proves de penetració simulades |
| **Vector d'atac** | Mètode que un atacant usa per accedir |
| **Vulnerabilitat** | Punt feble explotable |
| **Exploit** | Codi que aprofita una vulnerabilitat |
| **Payload** | Codi que s'executa quan l'exploit té èxit |
| **Mode monitor** | Mode WiFi que captura tot el tràfic |
| **NAT traversal** | Tècnica per fer connexions peer-to-peer a través de NAT |
| **DERP relay** | Servidors de relay de Tailscale quan NAT traversal falla |

## ⚠️ Avís legal i laboral

- Tots els exercicis sobre **dispositius propis** o amb **permís explícit**.
- Auditar equips aliens és delicte (articles 197 i 264 del Codi Penal espanyol).
- **Mai** practicar des de l'equip de la feina — risc laboral encara que
  l'objectiu sigui el teu propi PC.
- Veure [CAP-00-50](cap-00-50-etica-legalitat-abast.md) per a la política
  ètica completa del projecte.

---

_Última actualització: 2026-07-28 — sincronitzada amb l'arquitectura 2-ubicacions del CyberLab._