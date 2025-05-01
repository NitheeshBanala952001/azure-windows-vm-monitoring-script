$VMname="Your VM Name"
$ResourceName="Your Resource Name"

#$script = " @' "

#Get CPU Details

$CPUload= Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average

#Get Memory Details

$Memory= Get-CimInstance Win32_OperatingSystem
$TotalMemory = [math]::Round($Memory.TotalVisibleMemorySize / 1MB, 2)
$FreeSize= [math]::Round($Memory.FreePhysicalMemory / 1MB, 2)
$Usedsize= $TotalMemory - $FreeSize

$MemoryPercentage = [math]::Round(($Usedsize / $TotalMemory)*100 , 2)


#Get C drive Details

$logicalDisk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID= 'C:'"


$TotalDisk = [math]::Round($logicalDisk.Size / 1GB, 2)
$FreeDisk = [math]::Round($logicalDisk.FreeSpace / 1GB, 2)

$usedDisk = $TotalDisk - $FreeDisk

$DiskPrecentage = [math]::Round(($usedDisk / $TotalDisk)*100 ,2)

#OutPut

Write-Output "CPU Utilization: $CPUload %"
Write-Output "Memory Utilization : $MemoryPercentage %"
Write-Output "C drive Utilization : $DiskPrecentage %"
