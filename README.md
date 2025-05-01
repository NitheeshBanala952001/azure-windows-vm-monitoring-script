
# Azure Windows VM Monitoring Script

This PowerShell script is designed to remotely execute a hardware monitoring script on an Azure Virtual Machine (VM) using the `Invoke-AzVMRunCommand` cmdlet. It gathers vital system health information such as CPU utilization, memory usage, and C: drive disk usage. The output is written to the console.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Usage](#usage)
- [Script Details](#script-details)
- [Troubleshooting](#troubleshooting)

## Overview

This script performs the following operations:
- **Remote Command Execution:** Uses Azure PowerShell’s `Invoke-AzVMRunCommand` to remotely run the PowerShell script on a specified VM.
- **CPU Utilization:** Queries the current CPU load using `Get-CimInstance` on `Win32_Processor` and calculates the average load.
- **Memory Usage:** Retrieves total, free, and used physical memory from `Win32_OperatingSystem`, and calculates the percentage of memory used.
- **C: Drive Usage:** Retrieves disk information for the C: drive via `Win32_LogicalDisk` and calculates the used disk percentage.
- **Output:** Writes the CPU, memory, and disk utilization percentages to the console.

## Prerequisites

Before running this script, ensure that you have:
- **Azure PowerShell Module:** The `Az` module must be installed and imported. For installation, visit [Azure PowerShell documentation](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps).
- **Proper Permissions:** Ensure that you have the necessary permissions to execute commands and access details on the target Azure VM.
- **PowerShell Version:** It is recommended to use PowerShell 5.1 or later.

## Configuration

Before executing the script, update the following placeholders in the code with your environment-specific information:

- **Resource Group Name:** Replace `"Your Resource Name"` with the actual name of your Azure resource group.
- **Virtual Machine Name:** Replace `"Your VM Name"` with the actual name of your target VM.
- **Script Path:** Replace `"Your script Path"` with the local or accessible path to the script file that is to be executed on the VM.

For example:
```powershell
$VMname = "MyVM"
$ResourceName = "MyResourceGroup"
(Invoke-AzVMRunCommand -ResourceGroupName $ResourceName -VMName $VMname -CommandId "RunPowerShellScript" -ScriptPath "C:\Scripts\MonitorScript.ps1").Value.Message
```

## Usage

1. **Authenticate to Azure:**
   - Open PowerShell and sign in using:
     ```powershell
     Connect-AzAccount
     ```

2. **Modify the Script:**
   - Update the variables (`$VMname`, `$ResourceName`, and `-ScriptPath`) in the code with your specific details as shown above.

3. **Run the Command:**
   - Execute the script in your PowerShell environment. The command will run the monitoring script on the specified VM and display the output, including CPU, memory, and disk utilization.

## Script Details

Below is a brief walkthrough of each major section of the script:

- **Invoke-AzVMRunCommand Invocation:**
  - The first line uses `Invoke-AzVMRunCommand` to execute the script remotely on the target VM. The output message from the remote execution is displayed.
  
- **Collecting CPU Data:**
  - The command retrieves information from `Win32_Processor`, calculates the average CPU load, and stores it in `$CPUload`.

- **Collecting Memory Data:**
  - Memory details are obtained using `Get-CimInstance` for `Win32_OperatingSystem`.
  - The total and free physical memory values are converted from kilobytes to megabytes, and the percentage of used memory is calculated.

- **Collecting Disk Data:**
  - The C: drive details are fetched using `Get-CimInstance` for `Win32_LogicalDisk`.
  - The total and free disk sizes are converted from bytes to gigabytes and the percentage of disk space used is computed.

- **Output:**
  - The script outputs the CPU, memory, and disk utilization percentages using `Write-Output`.

## Troubleshooting

- **Authentication Issues:**  
  Ensure you are logged in to your Azure account using `Connect-AzAccount`. If you encounter permissions issues, verify your role assignments on the targeted resource group or VM.
  
- **Execution Policy:**  
  Your system’s execution policy might prevent script execution. Adjust it by running (as an Administrator):
  ```powershell
  Set-ExecutionPolicy RemoteSigned
  ```

- **Module Errors:**  
  If you receive errors related to `Invoke-AzVMRunCommand`, confirm that your Azure PowerShell modules are up-to-date by running:
  ```powershell
  Update-Module -Name Az
  ```
