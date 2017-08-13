$scriptfolder = $PSScriptRoot
$dockerfolder = (Split-Path $scriptfolder -Parent)
$conffolder = $dockerfolder + "\conf"
$installdir = $conffolder + "\install_dir"
$dockerfile = $conffolder + "\docker"

"/nquakesv" | Out-File -Encoding ASCII -NoNewline $installdir
"1" | Out-File -Encoding ASCII -NoNewline $dockerfile

docker build --tag nquake/server-linux $dockerfolder
