param([Parameter(Mandatory)][string]$Zone,[Parameter(Mandatory)][string]$ResourceGroup)
az network dns record-set list -g $ResourceGroup -z $Zone | ConvertTo-Json -Depth 10 | Out-File ".\dns-snapshot-$((Get-Date).ToString('yyyyMMdd-HHmmss')).json"
