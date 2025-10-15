param(
  [Parameter(Mandatory)][string]$Zone,
  [Parameter(Mandatory)][string]$Name,
  [Parameter(Mandatory)][string]$Ip,
  [Parameter(Mandatory)][string]$ResourceGroup,
  [int]$Ttl = 60
)
az network dns record-set a create -g $ResourceGroup -z $Zone -n $Name --ttl $Ttl --if-none-match | Out-Null
az network dns record-set a add-record -g $ResourceGroup -z $Zone -n $Name -a $Ip | Out-Null
Write-Host "A record $Name.$Zone -> $Ip (TTL=$Ttl)"
