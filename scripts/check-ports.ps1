param([Parameter(Mandatory)][string]$Host,[int[]]$Ports=@(8080,8443,8880,8843,3478))
$Ports | ForEach-Object {
  try {
    if($_ -eq 3478){ "$Host:$_ (UDP STUN) — use Test-NetConnection -UdpPort $_"; return }
    $tcp = New-Object Net.Sockets.TcpClient
    $iar = $tcp.BeginConnect($Host, $_, $null, $null)
    $ok = $iar.AsyncWaitHandle.WaitOne(2000)
    if($ok -and $tcp.Connected){ "$Host:$_ OK" } else { "$Host:$_ TIMEOUT" }
    $tcp.Close()
  } catch { "$Host:$_ ERROR $($_.Exception.Message)" }
}
