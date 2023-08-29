# Check for available Windows updates
$windowsUpdateStatus = Get-WindowsUpdate -KBArticleID "KB*"
if ($windowsUpdateStatus.Count -gt 0) {
    Write-Host "Windows updates are available."
} else {
    Write-Host "No Windows updates available."
}

# Check Windows Defender status
$defenderStatus = Get-MpPreference
if ($defenderStatus.RealTimeMonitoringEnabled -eq $true) {
    Write-Host "Windows Defender real-time monitoring is enabled."
} else {
    Write-Host "Windows Defender real-time monitoring is disabled."
}

# List installed applications using PowerShell
$installedApps = Get-WmiObject Win32_Product
Write-Host "Installed applications (using PowerShell):"
foreach ($app in $installedApps) {
    Write-Host $app.Name
}

# List installed applications using WMIC
$wmicInstalledApps = Get-WmiObject Win32Reg_AddRemovePrograms
Write-Host "Installed applications (using WMIC):"
foreach ($app in $wmicInstalledApps) {
    Write-Host $app.DisplayName
}
