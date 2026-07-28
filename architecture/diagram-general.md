flowchart TB
    Internet([Internet])
    Router[Router domèstic<br/>cap port obert]
    LAN[Xarxa domèstica<br/>&lt;LAN&gt;/24]
    Tailscale[Tailscale tailnet<br/>100.64.0.0/10]

    subgraph Host["Xarxa de gestió (cyber-host)"]
        H[cyber-host<br/>PC Win11 + Hyper-V<br/>+ WSL2 Docker]
    end

    subgraph Clients["Xarxa domèstica"]
        B[cyber-brain<br/>MBP 13]
        P[cyber-pi<br/>RPi 4]
        C[cyber-control<br/>MBA 13]
        M[cyber-mobile<br/>iPhone]
    end

    subgraph Labs["Xarxes de laboratori (10.10.x - no publicades al tailnet)"]
        V1[10.10.20 ofensiva<br/>kali-01]
        V2[10.10.30 victimes<br/>target-linux-01<br/>target-web-01]
        V3[10.10.40 defensa<br/>defense-01]
    end

    Internet --> Router --> LAN
    LAN --- Tailscale
    LAN --> H
    LAN --> B
    LAN --> P
    LAN --> C
    LAN --> M

    H -. Tailscale .-> B
    H -. Tailscale .-> P
    B -. Tailscale .-> P
    M -. Tailscale .-> H
    M -. Tailscale .-> B
    M -. Tailscale .-> P

    H --> Labs

    style H fill:#1f3a5f,stroke:#5fa8d3,color:#fff
    style B fill:#5a3d1f,stroke:#d3a85f,color:#fff
    style P fill:#1f5a3d,stroke:#5fd3a8,color:#fff
    style C fill:#3a3a3a,stroke:#999,color:#fff
    style M fill:#5a1f3d,stroke:#d35f99,color:#fff
