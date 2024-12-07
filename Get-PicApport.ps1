$PicApportURL='https://www.picapport.de/en/photo-server-download.php'
$HTMLResult = Invoke-WebRequest -Uri $PicApportURL
$VersionString = ($HTMLResult.Links | Where-Object {$_.href -like '*picapport-headless*.jar'} | Select-Object href,@{Name='Version';Expression={(Select-String -InputObject $_ -Pattern '((?:\d{1,3}-){2}\d{1,3})'|ForEach-Object{$_.Matches[0].Groups[1].Value}) }} | Sort-Object {$_.Version -replace '-','.' -as [version]} -Descending | Select-Object -First 1).Version

$PicApportPluginsURL='https://www.picapport.de/en/plugins.php'
$HTMLResult = Invoke-WebRequest -Uri $PicApportPluginsURL
$HTMLResult.Links | Where-Object {$_.href -like '*.zip' -and $_.OuterHTML -notlike '*-src*'}
