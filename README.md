# Unifi → Azure Migration Runbook
Steps for a safe service migration to Azure with backout.

## Stages
1. Discovery & inventory
2. Landing zone (vnet, subnets, NSGs)
3. Data sync (blue/green)
4. DNS + NSG cutover
5. Verification & backout

```mermaid
sequenceDiagram
  participant U as Unifi
  participant A as Azure
  U->>A: Baseline & sync
  A->>A: Blue env up
  U->>A: Cutover DNS/NSG
  A-->>U: Health OK
```

## Outcome
- Clean cutover with defined backout (A/B DNS swap)
