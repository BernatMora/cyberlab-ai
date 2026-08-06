# CyberLab — Lab Docker aïllat

Aquest directori conté el **lab actiu** que corre al Kali del hort:
3 aplicacions vulnerables a la xarxa Docker `lab-net` (`10.10.30.0/24`),
aïllada de la LAN domèstica i d'Internet.

## Fitxers

| Fitxer | Què fa |
|---|---|
| `docker-compose.yml` | Puja DVWA, Juice Shop i Metasploitable amb IPs estàtiques |
| `isolate-lab.sh` | Aplica regles iptables per aïllar el lab de la LAN i Internet |
| `isolate-lab.service` | Unitat systemd que aplica l'aïllament en cada boot |

## Víctimes desplegades

| Víctima | IP | Port publicat | Tipus |
|---|---|---|---|
| `dvwa` | 10.10.30.10 | 127.0.0.1:8080 → 80 | Web clàssica (PHP/MySQL) |
| `juice-shop` | 10.10.30.20 | 127.0.0.1:3000 → 3000 | OWASP Juice Shop (Node.js) |
| `metasploitable` | 10.10.30.30 | cap | Multiservei Linux (vsftpd, SMB, HTTP…) |

Tots els ports es publiquen **només a `127.0.0.1`** del Kali. S'hi accedeix
remotament via túnel SSH:

```bash
ssh -L 8080:127.0.0.1:8080 hort-osona@hort      # DVWA
ssh -L 3000:127.0.0.1:3000 hort-osona@hort      # Juice Shop
```

## Posada en marxa (al Kali)

```bash
# 1. Aprovisionar el lab
cd ~/cyberlab                          # o on sigui docker-compose.yml
docker compose up -d

# 2. Instal·lar l'script d'aïllament (un sol cop)
sudo cp isolate-lab.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/isolate-lab.sh

# 3. Activar el servei systemd (persistent entre reinicis)
sudo cp isolate-lab.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now isolate-lab.service
```

## Verificació

```bash
docker ps                              # 3 contenidors Up
docker network inspect cyberlab_lab-net
sudo iptables -L DOCKER-USER -n -v     # ha de mostrar 2 regles DROP
sudo systemctl status isolate-lab.service
```

## Què NO s'ha de fer

- **No publicar ports a `0.0.0.0`** — seria accessible des de la LAN.
- **No afegir `privileged: true`** als contenidors — sortiria del sandbox.
- **No mapejar volumes del host** als contenidors — exposaria el Kali.

## Veure també

- [`book/chapters/cap-05-10-docker.md`](../../book/chapters/cap-05-10-docker.md)
- [`book/chapters/cap-08-10-apps-vulnerables.md`](../../book/chapters/cap-08-10-apps-vulnerables.md)
- [`book/chapters/cap-08-20-kali-linux.md`](../../book/chapters/cap-08-20-kali-linux.md)
