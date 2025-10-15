# UniFi Controller Migration → Azure (Zero‑Downtime)

Move the UniFi Network Application to an Azure VM with **zero downtime** using short DNS TTL cutover and a safe rollback.

## Architecture
```mermaid
flowchart LR
  Internet -->|DNS (A/CNAME)| Clients
  Clients -->|"API/UI"| UniFi_New[(Azure VM: UniFi Controller)]
  Clients -->|"API/UI"| UniFi_Old[(On-Prem Controller)]
  subgraph Azure
    UniFi_New -->|TCP 8443/8080/8880/8843| NSG[(NSG rules)]
    UniFi_New -->|Backups| Storage[(Azure Storage)]
  end
```

## Pre-checks
- Backup old controller (Settings → System → Backup) + export **Site**
- Note **Inform URL** & device **Adoption** states
- Azure VM ready (Linux/Windows). Open: 8080 (inform), 8443 (UI/API), 8880/8843 (guest), 3478/UDP (STUN)
- Controller FQDN (eg. `unifi.company.com`) **TTL=60s**

## Azure VM bootstrap (Linux)
```bash
sudo apt-get update && sudo apt-get install -y ca-certificates gnupg curl
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
curl -fsSL https://dl.ui.com/unifi/unifi-repo.gpg | sudo gpg --dearmor -o /usr/share/keyrings/unifi-repo.gpg
sudo apt-get update && sudo apt-get install -y unifi
sudo systemctl enable --now unifi
# Restore backup via https://<vm>:8443
```

## Cutover
1. Update **Inform URL** to new FQDN  
2. Switch DNS `A/CNAME` to Azure public IP (TTL 60s)  
3. Wait 2–5 mins for devices to re-inform

## Validation
- Devices show **Connected** on new controller
- Guest portal (if used) responds
- Scheduled backups land in Storage

## Rollback
- Point DNS back to old IP (TTL 60s)
- Restore backup on old controller if needed
- Investigate NSG/ports/SSL if adoption failed

## Helpers
- `scripts/check-ports.ps1` — quick TCP reachability
- `scripts/export-dns.ps1` — Azure DNS snapshot
- `scripts/set-dns.ps1` — update A record to Azure IP

## Ports
8080 (inform), 8443 (UI/API), 8880/8843 (guest), 3478/UDP (STUN)
