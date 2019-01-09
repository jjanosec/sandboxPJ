$TraceFolder = "C:\temp\TraceFile\Today" 
$TraceFolderArchive = "C:\temp\TraceFile\Archive" 
$fileAge = 1  
$archiveAge = 7  
  
$TraceFiles = Get-ChildItem $TraceFolder -Filter *.trc | Where LastWriteTime -lt  (Get-Date).AddDays(-1 * $fileAge)  
$destinationPath = $TraceFolderArchive   (Get-Date -format "yyyyMMddHHmmss")   ".zip"  
  
$TraceFilePaths = @()  
  
foreach($TraceFile in $TraceFiles){  
    $TraceFilePaths  = $TraceFile.FullName  
    }  
  
Compress-Archive -Path $TraceFilePaths -DestinationPath $destinationPath -CompressionLevel Optimal  
Remove-Item –path $TraceFilePaths  
  
$archiveFiles = Get-ChildItem $TraceFolder -Filter *.zip | Where LastWriteTime -lt  (Get-Date).AddDays(-1 * $archiveAge)  
  
foreach($archiveFile in $archiveFiles){  
    Remove-Item –path $archiveFile.FullName  
}