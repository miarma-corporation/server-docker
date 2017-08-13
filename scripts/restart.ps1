Param(
  [string]$server = "mvdsv"
)

If ($server -ne "mvdsv" -And $server -ne "qtv" -And $server -ne "qwfwd")
{
	Write-Host "Invalid server type (available: mvdsv, qtv, qwfwd)."
	exit 1
}

$running = (docker ps -a -f name=nquakesv-$server-\* --format "{{.ID}}")
if ([string]::IsNullOrEmpty($running))
{
	Write-Host "No running containers"
	exit 1
}

Write-Host "* Restarting containers..."
docker restart $running 2> $null
