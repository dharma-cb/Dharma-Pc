# Windows 10 Docker Image for Codespaces
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install required components
RUN powershell -Command \
    Add-WindowsFeature Server-Gui-Mgmt-Infra; \
    Add-WindowsFeature Server-Gui-Shell; \
    Add-WindowsFeature Desktop-Experience

# Install RDP server
RUN powershell -Command \
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Set RDP port to 8000
RUN powershell -Command \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name 'PortNumber' -Value 8000

# Block port 3000 (no service listening)
EXPOSE 8000

# Start RDP service
CMD ["powershell", "-Command", "Start-Service TermService; Get-EventLog -LogName System -Newest 1 | Wait-Event"]
