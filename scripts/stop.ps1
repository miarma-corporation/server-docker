Param(
  [string]$server = "mvdsv"
)

$scriptfolder = $PSScriptRoot
$dockerfolder = (Split-Path $scriptfolder -Parent)

If ($server -ne "mvdsv" -And $server -ne "qtv" -And $server -ne "qwfwd")
{
	Write-Host "Invalid server type (available: mvdsv, qtv, qwfwd)."
	exit 1
}

$running = (docker ps -a -f name=nquakesv-$server-* --format "{{.ID}}")
if ([string]::IsNullOrEmpty($running))
{
	Write-Host "No running containers"
	exit 1
}

Write-Host "* Stopping and removing old containers..."
docker rm -f $running 2> $null
