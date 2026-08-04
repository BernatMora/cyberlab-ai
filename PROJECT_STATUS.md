# Estat del projecte

**Data de revisió:** 2026-08-04  
**Fase operativa:** Fase 0 — auditoria de maquinari pendent

## Semàfor

| Àrea | Estat | Criteri |
|---|---|---|
| Arquitectura | Decidida | Windows 11 Pro + Hyper-V + Kali virtual |
| Documentació base | En curs | ADR, pla director i llibre creats |
| Auditoria de maquinari | Pendent | Cal executar i revisar els scripts al maquinari real |
| Tailscale | No validat | No es publica cap dada real al repositori |
| Virtualització | Planificada | Es farà després de completar les fases 0, 1 i 2 |
| Primer laboratori | Planificat | Sense desplegament fins que la xarxa aïllada estigui validada |

## Regla d'avanç

Una fase només passa a **completada** quan:

1. s'ha executat al maquinari real;
2. totes les comprovacions han passat;
3. existeix un informe anonimitzat;
4. s'han actualitzat el README, aquest estat i el changelog;
5. no hi ha secrets, identificadors o adreces reals al Git.

## Proper pas únic

Completar la Fase 0 seguint `docs/10-fase-0-auditoria/`. No instal·lar Hyper-V, Kali ni laboratoris vulnerables fins que l'inventari confirmi edició de Windows, virtualització de CPU, memòria, disc i xarxa.
