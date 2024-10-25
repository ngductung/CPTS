## windows
``` a.ps1
$subnet = "172.16.6." 
$activeHosts = @() 
for ($i = 1; $i -le 254; $i++) { 
$ip = $subnet + $i 
$pingResult = ping -n 1 -w 1000 $ip 
if ($pingResult -match "Reply from $ip") { 
$activeHosts += $ip 
Write-Host "$ip is active" 
} 
} 
Write-Host "`nActive hosts:" 
$activeHosts 
```


## linux
```
for i in {1..254} ;do (ping -c 1 172.16.5.$i | grep "bytes from" &) ;done
```
