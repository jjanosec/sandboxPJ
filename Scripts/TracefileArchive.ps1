$TraceFolder = "C:\temp\TraceFile\Today"  
$TraceFolderArchive = "C:\temp\TraceFile\Archive"
$TraceArchiveAge = 7  
$TraceArchiveZip = "C:\temp\TraceFile\Archive\KMG_Tracefile_$(Get-Date -format "yyyyMMdd").zip"

Compress-Archive -Path $TraceFolder\*.trc -DestinationPath $TraceArchiveZip -CompressionLevel Optimal  
Remove-Item –path $TraceFolder\*.trc
  
$TraceArchiveFiles = Get-ChildItem $TraceFolderArchive -Filter *.zip | Where LastWriteTime -lt  (Get-Date).AddDays(-1 * $archiveAge)  
  
foreach($TraceArchiveFile in $archiveFiles){  
    Remove-Item –path $archiveFile.FullName  
}