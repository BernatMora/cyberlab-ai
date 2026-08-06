---
id: EX-08-03
title: "XSS reflectit a DVWA (nivell Low)"
status: draft
version: 0.1
created: 2026-08-06
updated: 2026-08-06
authors:
  - Bernat Mora
  - Hermes Agent
tags:
  - xss
  - dvwa
  - web
prerequisites:
  - CAP-08-10
related:
  - CAP-08-10
estimated_time: 15 min
difficulty: beginner
---

# EX-08-03 — XSS reflectit a DVWA (nivell Low)

> Injecta JavaScript al camp "Name" de DVWA i executa codi al navegador
> de la víctima.

## Objectiu

Que el navegador de la víctima mostri una alerta amb el text que tu
controles, simplement visitant una URL maliciosa.

## Requisits

- DVWA pujat i accessible via túnel SSH.
- Nivell de seguretat **Low**.

## Entorn

- Atacant: Kali.
- Víctima: DVWA (`10.10.30.10`).
- "Víctima real" (futur): un altre navegador que visiti la URL.

## Passos

### 1. Preparació

Login a DVWA, nivell **Low**. Ves a "XSS (Reflected)" al menú.

### 2. Execució

Al camp `Name`, escriu:

```html
<script>alert('XSS by Bernat')</script>
```

Prem **Submit**.

### 3. Comprovació

El navegador ha de mostrar una alerta amb el text "XSS by Bernat". A la
barra d'adreces veuràs la URL:

```
http://127.0.0.1:8080/vulnerabilities/xss_r/?name=<script>alert(...)%3C/script%3E
```

Si un atacant envia aquesta URL a una víctima (per correu, X, etc.),
l'script s'executarà al navegador de la víctima cada vegada que la visiti.

## Comprovacions

- [ ] He vist l'alerta al navegador
- [ ] He entès què vol dir "reflected" (la injecció va a la URL i el
  servidor la "reflecteix" a la resposta)
- [ ] He provat altres payloads: `<img src=x onerror=alert(1)>`,
  `<svg onload=alert(1)>`

## Què passa per sota

DVWA retorna el valor del paràmetre `name` directament al HTML sense
escapar:

```php
$name = $_REQUEST['name'];
echo "Hello $name";
```

Si el valor conté `<script>...</script>`, el navegador l'interpreta.

## Errors habituals

| Error | Causa | Solució |
|---|---|---|
| El navegador mostra el text sense executar | Nivell **High** | Posa'l a **Low** |
| No veig l'alerta | He tancat les popups del lloc | Permet popups per a `127.0.0.1` |
| La URL queda massa llarga | El text és molt llarg | URL-encoder els caràcters especials |

## Conclusió

XSS reflectit és la base. En nivells **Medium** i **High** DVWA filtra
`<script>` (case-insensitive). Però sempre es pot bypassar amb `<img
onerror=...>`, `<svg onload=...>`, etc. La defensa real són **Content
Security Policy headers** i **escaping de l'output**.

## Referències

- [CAP-08-10](../chapters/cap-08-10-apps-vulnerables.md) — Aplicacions vulnerables
- [OWASP — XSS Filter Evasion Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html)
