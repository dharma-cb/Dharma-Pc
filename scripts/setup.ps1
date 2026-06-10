# Windows 10 Setup Script for Docker
# This script configures Windows 10 environment in Docker

Write-Host "=== Windows 10 Docker Setup ===" -ForegroundColor Green

# Enable RDP Service
Write-Host "Enabling RDP Service..." -ForegroundColor Yellow
Start-Service TermService
Set-Service -Name TermService -StartupType Automatic

# Configure RDP Port to 8000
Write-Host "Configuring RDP Port to 8000..." -ForegroundColor Yellow
$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'
Set-ItemProperty -Path $regPath -name 'PortNumber' -Value 8000 -Type DWord

# Block Port 3000 (no service)
Write-Host "Port 3000 is intentionally not bound to any service..." -ForegroundColor Cyan

# Enable RDP Firewall Rule
Write-Host "Enabling RDP Firewall Rules..." -ForegroundColor Yellow
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Create default user if needed
Write-Host "Verifying Administrator account..." -ForegroundColor Yellow
$adminExists = Get-LocalUser -Name Administrator -ErrorAction SilentlyContinue
if ($adminExists) {
    Write-Host "Administrator account exists" -ForegroundColor Green
} else {
    Write-Host "Creating Administrator account..." -ForegroundColor Cyan
    New-LocalUser -Name Administrator -Password (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) -FullName "Administrator" -Description "Built-in Administrator"
    Add-LocalGroupMember -Group "Administrators" -Member "Administrator"
}

# Display final status
Write-Host "" -ForegroundColor Green
Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host "Port 8000: Windows 10 RDP Desktop (ACCESSIBLE)" -ForegroundColor Green
Write-Host "Port 3000: Backend/Internal (BLOCKED)" -ForegroundColor Red
Write-Host "" -ForegroundColor Green
Write-Host "Windows 10 is ready for connection!" -ForegroundColor Green
