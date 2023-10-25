# Set the execution policy to RemoteSigned
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Define the date range
$startTime = Get-Date "2023-10-16"
$endTime = Get-Date "2023-10-20"

# Get the computer name
$computerName = $env:COMPUTERNAME

# Set the output path to the desktop of the current user
$outputPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), "$computerName_EventLog.txt")

# Filter and export Event Log entries to a text file
$events = Get-WinEvent -LogName Security | Where-Object {
    $_.Id -eq 4624 -or $_.Id -eq 4634 -and $_.TimeCreated -ge $startTime -and $_.TimeCreated -le $endTime
}
$events | ForEach-Object { $_.Message } | Out-File -FilePath $outputPath

Write-Host "Event Log entries from $startTime to $endTime exported to $outputPath"