
# UniFi Controller Migration (to Azure, zero-downtime)

1. Prep Azure VM (Ubuntu 22.04), Standard static Public IP.
2. NSG: 22/8443 restricted; 8080/3478 open as needed for devices.
3. Install UniFi, restore backup, validate.
4. Enable **Override inform host** with FQDN.
5. Update DNS A record to new public IP.
6. Verify device re-adoption, rollback by reverting DNS if needed.

> Prefer admin access via VPN or locked-down NSG sources.
