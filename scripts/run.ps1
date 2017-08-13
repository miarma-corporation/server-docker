Param(
  [string]$server = "mvdsv",
  [int]$num = 1
)

$scriptfolder = $PSScriptRoot
$dockerfolder = (Split-Path $scriptfolder -Parent)
$conffolder = $dockerfolder + "\conf"
$ipfile = $conffolder + "\ip"

$mvdsvport = [convert]::ToInt32([IO.File]::ReadAllText($conffolder + "\port-mvdsv"))
$qtvport = [convert]::ToInt32([IO.File]::ReadAllText($conffolder + "\port-qtv"))
$qwfwdport = [convert]::ToInt32([IO.File]::ReadAllText($conffolder + "\port-qwfwd"))

$port = ""

If ($server -eq "mvdsv")
{
	$port = $mvdsvport
	Write-Host "* Using mvdsv configuration"
}
ElseIf ($server -eq "qtv")
{
	$port = $qtvport
	$num = 1
	Write-Host "* Using qtv configuration"
}
ElseIf ($server -eq "qwfwd")
{
	$port = $qwfwdport
	$num = 1
	Write-Host "* Using qwfwd configuration"
}
Else
{
	Write-Host "Invalid server type '$server' (available: mvdsv, qtv, qwfwd)."
	exit 1
}

If (-Not $port -gt 0)
{
	Write-Host "* Invalid port '$port', setting port to 27500"
	$port = 27500
}

Write-Host "* Using port $port"
Write-Host "* Starting $num containers"

$ip = (Invoke-RestMethod http://ipinfo.io/json | Select -exp ip)
Write-Host "* Setting IP to $ip"
$ip | Out-File -Encoding ASCII -NoNewline $ipfile

$running = (docker ps -a -f name=nquakesv-$server-\* --format "{{.ID}}")
if (-Not [string]::IsNullOrEmpty($running))
{
	Write-Host "* Stopping and removing old containers..."
	(docker rm -f $running) | out-null
}

$mountfolder = $conffolder.Replace("\", "/")

Write-Host "* Starting new containers..."
For ($i = 1; $i -le $num; $i++)
{
	$useport = $port + $i - 1
	docker run -d `
		-v ${mountfolder}:/etc/nquakesv `
		--expose $useport `
		-p ${useport}:$useport/udp `
		--restart always `
		--name nquakesv-$server-$i `
		nquake/server-linux $server $useport
}