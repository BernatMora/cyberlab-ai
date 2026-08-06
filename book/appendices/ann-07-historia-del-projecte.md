---
id: ANN-07
title: "Història del projecte"
status: published
version: 1.1
created: 2026-07-28
updated: 2026-08-06
authors:
  - Bernat Mora
type: changelog
related:
  - CAP-01-60
  - ANN-05
---

# ANN-07 — Història del projecte

> L'evolució del CyberLab des dels seus orígens. Per què s'ha fet cada cosa
> en cada moment. Un diari de decisions.

## Cronologia

### 2026-07-27 — Orígens (sessió inicial al projecte)

Esbossos inicials. Definició del PC potent de l'hort + Mac potent de casa
com a nucli del projecte. Primeres idees sobre Kali, Metasploitable, DVWA.

### 2026-07-28 — Decisió de Kali

Triada la distro: **Kali Linux** (vs Parrot/WiFiSlax). Motius: comunitat
gran, molts tutorials, eines preinstal·lades.

Decisions operatives preses:
- Distro: **Kali Linux 2026.2** (Live amd64 amb persistència o Installer).
- USB: **Kingston 256 GB** amb Ventoy.
- Eines: **nmap, hydra, john, aircrack-ng, wireshark**.
- Accés remot: **Tailscale** (per CGNAT + IP dinàmica).

### 2026-07-28 — Decàrrega i validació de la ISO

Descarregada i validada `kali-linux-2026.2-installer-amd64.iso` (SHA256
verificat).

### 2026-07-28 — Rufus vs Ventoy

Inicialment triat **Rufus**, però descobert que:
- ISO **installer** no porta persistència.
- Les Live ISO només via torrent.
- Rufus forçava mode DD amb ISOs ISOHybrid (perdia persistència).

Decisió canviada a **Ventoy al USB Kingston 256 GB** (instal·lat Ventoy).

### 2026-07-30 — Xuleta de comandes

Creat `xuleta-comandes.md` i `xuleta-comandes.pdf` (5 pàgines) amb totes
les ordres apreses fins al moment.

### 2026-07-30 — Decisió final sobre maquinari

Triat definitivament:
- **PC de l'hort** (HP Z1 G9, 32 GB RAM) com a `cyber-host` potent.
- **Mac vell de l'hort** com a màquina complementària.
- **RPi hort-osona** queda **fora** (pertany al projecte hort-osona).
- **Mac potent de casa** com a centre de control.

### 2026-07-30 — Política legal consolidada

- ❌ Mai des de l'equip de la feina (risc laboral).
- ✅ Tot des dels Macs personals.
- ✅ Sobre dispositius propis o amb autorització.
- ✅ Plataformes legals: TryHackMe, HackTheBox, OverTheWire, PortSwigger.

### 2026-07-30 — Decisió Parlem 5G

Operador mòbil de l'hort: **Parlem 5G**, 150 GB/mes. CGNAT actiu → Tailscale
és l'única via còmoda.

### 2026-07-31 — Primer PROJECT_STATE

Creat `PROJECT_STATE.md` a `C:\Users\iadmin\Documents\lab-seguretat\` per
garantir continuïtat entre sessions.

### 2026-07-31 — Idees descartades

- Integrar CyberLab al projecte **BernatLab** del curs (idea abortada).
  Motiu: barrejar conceptes diferents. Es reprendrà més endavant quan hi
  hagi URL pròpia.
- Usar la **RPi del hort-osona** com a `cyber-pi`. Motiu: pertany a un altre
  projecte actiu.

### 2026-07-28 (reprise) — Creació del projecte `cyberlab-ai` al GitHub

- Repo `BernatMora/cyberlab-ai` creat.
- Estructura completa + llicència doble (MIT + CC BY-SA 4.0).
- Llibre Viu iniciat amb Bloc 0 publicat.
- 38 capítols d'esquelet preparats.

### 2026-08-06 — Primer lab real muntat al Kali

> **Per a mi del futur:** si ara estic llegint això i no recordo què
> és un "lab de ciberseguretat", vés primer al [CAP-00-15]
> (cap-00-15-que-es-un-lab.md). Allà t'ho explico amb analogies de
> cotxes i galliners.

#### Què tenim muntat (en planer)

Això és el primer dia que el laboratori funciona de veritat. Fins ara
tot eren papers: un projecte a GitHub amb 43 capítols (quasi tots
buits), esquemes bonics de xarxes, i moltes ganes. Avui per fi tenim
**ordinadors de veritat fent feina**.

La idea és molt simple i val la pena entendre-la bé:

**Imagina que vols aprendre a conduir.** No tens cotxe. Què fas?
- Opció A: intentes aprendre mirant vídeos a YouTube.
- Opció B: llogues un cotxe en una pista buida i pratiques.

L'opció B és molt millor, oi? Doncs un **laboratori de ciberseguretat
és exactament això**: en lloc de practicar atacs contra internet
(perillós, il·legal i tonto), prepares **ordinadors de joguina que
tenen falles a propòsit** i practiques contra ells. Així aprens de
veritat sense fer mal a ningú.

Aquests ordinadors de joguina es diuen **"víctimes"** en argot — perquè
tu faràs d'atacant i ells de víctima.

#### Les 3 joguines que tenim ara

Al Kali (l'ordinador "atacant" del lab) hi corren **3 programetes**
dins de **contenidors Docker** — que són com màquines virtuals molt
lleugeres, gairebé immediates d'encendre:

1. **DVWA** — una botiga web falsa feta amb PHP.
   - Per a què serveix: per practicar **SQL injection** (enganyar la
     botiga perquè et doni les contrasenyes) i **XSS** (colar-te
     codi al navegador d'altres).
   - Com t'ho imagines: és com una **botiga de cartró** on tu pots
     practicar a forçar la caixa enregistradora — perfecte per
     aprendre, innocent.
   - On la trobes: a la `10.10.30.10` (adreça interna, invisible
     des de fora).
   - Com hi entres: per `http://127.0.0.1:8080` des del Mac, passant
     per un **túnel SSH** (una mena de passadís secret per la
     xarxa).

2. **Juice Shop** — una botiga de sucs falsa feta amb Node.js.
   - Per a què serveix: per practicar vulnerabilitats web **modernes**
     (les que trobaràs a les botigues de veritat el 2026).
   - Com t'ho imagines: la **mateixa botiga de cartró** però més
     moderna — amb targeta de crèdit, login amb Google, cistella de
     compra. Té un **score board** amagat que et posa estrelles quan
     trobes cada fallada.
   - On la trobes: `10.10.30.20`.
   - Com hi entres: `http://127.0.0.1:3000`.

3. **Metasploitable** — un Linux vell expressament vulnerable.
   - Per a què serveix: per practicar coses **de servidor antic**:
     carpetes compartides, FTP, SSH amb contrasenya fluixa, etc.
   - Com t'ho imagines: un **cotxe dels anys 90** al taller — tot
     funciona però no té antibloqueig, alarma, ni res. Ideal per
     aprendre a entrar-hi.
   - On la trobes: `10.10.30.30`. No té port obert al Mac — t'hi
     connectes directament des del Kali.

#### Per què estan "aïllades" de la resta de la xarxa

Aquí ve la part més important i on la gent es confon:

Si un contenidor Docker té un bug i l'atacant (en aquest cas TU
practicant) se n'aprofita, podria intentar **sortir del contenidor**
cap a la resta d'ordinadors de casa teva (la RPi del hort-osona, el
Mac, la impressora, etc.). Això seria un desastre — imagina que
practiques al taller i perds el control del cotxe i atropelles el
germà.

Per evitar-ho, hem posat **regles de tallafoc** (`iptables`) que
diuen bàsicament:

> "Els contenidors del lab poden parlar entre ells, però NO poden
> trucar a la xarxa de casa, ni a internet, ni a la RPi."

Aquestes regles viuen en un script (`isolate-lab.sh`) i s'apliquen
**automàticament cada vegada que el Kali encén** (gràcies a un servei
`systemd` anomenat `isolate-lab.service`). Així si reinicies el Kali,
l'aïllament torna sol.

#### El resum en una frase

> Avui, per primera vegada, tenim un **taller mecànic de ciberseguretat
> real** funcionant al Kali: 3 joguines vulnerables, una xarxa interna
> pròpia, un tallafoc que ens protegeix, i accés remot des del Mac de
> casa via Tailscale.

#### Què NO s'ha de fer

- **No connectar les joguines a internet** — la regla és clara.
- **No practicar amb el Mac de la feina** — ni de broma.
- **No posar cap IP o contrasenya real** en aquest llibre — és
  públic a GitHub.

#### Fitxers nous al repo (per si de cas)

- `docker/lab/docker-compose.yml` — la "recepta" que aixeca les
  3 joguines.
- `docker/lab/isolate-lab.sh` — el tallafoc.
- `docker/lab/isolate-lab.service` — l'encenedor automàtic del
  tallafoc.
- `docker/lab/README.md` — les instruccions posades en ordre.

#### Pendents per la pròxima sessió

- Muntar l'**HP Z1 G9** (32 GB RAM) per tenir **màquines virtuals
  natives** (Windows vulnerable, Active Directory).
- Afegir un **detector d'intrusions** (Snort o Suricata) — una mena
  de "càmera de seguretat" que et diu "ei, algú ha intentat
  entrar".
- Més exercicis: SQL injection a Juice Shop, atacs de JWT, XXE.
- Una **plantilla d'informe de pentest** — el document final que
  escriuràs explicant què has trobat i com arreglar-ho.

### 2026-07-28 — Integració del material antic

Aquest annex s'ha creat per integrar i actualitzar la informació del
PROJECT_STATE antic al context actual del projecte al GitHub.

## Lliçons apreses (per no repetir-les)

### Tècniques

- **ISO installer ≠ ISO live**: la ISO installer no porta persistència.
  Per a persistència de veritat cal ISO **live**.
- **Live ISO només via torrent** (o kali-weekly HTTP).
- **Rufus + ISOHybrid = mode DD forçat**: perd opció de persistència. Per
  a Kali, millor **Ventoy**.
- **Ventoy crea dues particions**: una petita (boot) + una gran (ISOs).
  L'Explorador de Windows pot amagar la partició gran → usar `Get-Volume`
  per veure-les totes.
- **CGNAT** impossibilita port forwarding directe. Tailscale és l'única
  solució còmoda amb Parlem 5G.
- **Tailscale + WireGuard** = NAT traversal automàtic + xifrat punta a
  punta.
- **Wake-on-LAN** cal activar-lo a la BIOS/UEFI; sense això, no podem
  despertar el PC de l'hort des de casa.

### De gestió

- **Mai practicar des de l'equip de la feina** — risc laboral encara que
  l'objectiu sigui casa teva.
- **Documentar cada decisió** en una ADR per no repetir-la d'aquí 2 anys.
- **Xuleta de comandes** = millor que dependre d'una IA per a les ordres
  bàsiques.
- **PROJECT_STATE.md** és or: permet reprendre una sessió amb context.
- **Separar projectes**: el CyberLab NO és el mateix que el projecte
  hort-osona ni que el curs BernatLab.

### De metodologia

- **Decidir abans de comprar**: abans de comprar cap peça nova, validar
  que l'arquitectura actual pot assumir les noves necessitats.
- **Confirmar l'arquitectura amb proves reals**, no amb suposicions.
- **Una sessió = una decisió important**: no voler fer tot en una sola
  sessió porta a errors.
- **Backup primer**: abans de qualsevol canvi important, còpia de seguretat.

## Estadístiques de les sessions anteriors

- Durada: ~4 dies (sessions esparses entre 27-30 juliol).
- ISO validada: `kali-linux-2026.2-installer-amd64.iso` (SHA256 valid).
- USB preparat: Kingston 256 GB amb Ventoy.
- Eines apreses: Get-FileHash, Get-Disk, Get-Volume, Copy-Item,
  qBittorrent, Rufus, Ventoy.
- Documents creats: xuleta-comandes.md, xuleta-comandes.pdf,
  PROJECT_STATE.md.
- Coneixements consolidats: CGNAT, Tailscale, Rufus vs Ventoy, ISO
  live vs installer.

## Fonts

- [`docs/00-pla-director.md`](../../docs/00-pla-director.md) — Pla Director actual
- [`ADR/0001-arquitectura-general.md`](../../ADR/0001-arquitectura-general.md) — Arquitectura revisada
- [`ADR/0002-rolls-per-equip.md`](../../ADR/0002-rolls-per-equip.md) — Rols revisats
- [CAP-01-60](cap-01-60-ubicacions-i-desplegaments.md) — Ubicacions i desplegaments
- [ANN-05](ann-05-xuleta-comandes.md) — Xuleta de comandes
- Material antic a `C:\Users\iadmin\Documents\lab-seguretat\` (no versionat;
  conservat localment).

---

_Última actualització: 2026-07-28 — sincronitzada amb l'estat actual del projecte._