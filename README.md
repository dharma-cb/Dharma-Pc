# Dharma-Pc - Windows 10 Docker Codespace

Run Windows 10 natively in Docker within a GitHub Codespace with secure port configuration.

## Overview

This repository sets up a Windows 10 environment in Docker with the following port configuration:

- **Port 3000**: Backend/Internal (Blocked - No access for users)
- **Port 8000**: Windows 10 RDP Desktop (Public - Accessible to users)

## Quick Start

### Using GitHub Codespaces

1. Click the green **"Code"** button on the repository
2. Select **"Codespaces"** tab
3. Click **"Create codespace on main"**
4. Wait for the environment to build and start

### Accessing Windows 10

Once the Codespace is running:

1. Open the **"Ports"** tab in your Codespace
2. Look for port **8000** (Windows 10 RDP Desktop)
3. Click on the forwarded URL or use an RDP client to connect:
   - **Host**: `localhost:8000` (or the Codespace URL)
   - **Username**: `Administrator` (default)
   - **Password**: (set during container startup)

### Port Configuration

#### Port 8000 (Public - Windows 10 Desktop)
- **Status**: Publicly accessible
- **Purpose**: Remote Desktop Protocol (RDP) access to Windows 10
- **Visibility**: Public
- **Authentication**: Not required

#### Port 3000 (Private - Backend)
- **Status**: Blocked/Private
- **Purpose**: Reserved for backend services (not exposed)
- **Visibility**: Private
- **Authentication**: Required
- **User Access**: Restricted

## Architecture

```
┌─────────────────────────────────────────┐
│     GitHub Codespace                    │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │   Docker Container                │  │
│  │   (Windows 10 ServerCore)         │  │
│  │                                   │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │  Port 8000 (RDP Desktop)    │  │  │
│  │  │  ✓ User Accessible         │  │  │
│  │  │  ✓ Native Windows 10 GUI   │  │  │
│  │  └─────────────────────────────┘  │  │
│  │                                   │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │  Port 3000 (Backend)        │  │  │
│  │  │  ✗ User Access Blocked      │  │  │
│  │  │  ✓ Internal Only            │  │  │
│  │  └─────────────────────────────┘  │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

## Building Locally

To build and run locally with Docker:

```bash
# Build the image
docker build -t dharma-pc:latest .

# Run with docker-compose
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

## System Requirements

- **RAM**: Minimum 4GB (8GB+ recommended)
- **Disk Space**: Minimum 10GB
- **Codespace Machine Type**: 4-core or higher recommended

## Troubleshooting

### Port 8000 Not Accessible
- Ensure the Codespace is fully started
- Check the **Ports** tab in Codespace
- Verify RDP service is running inside the container

### Port 3000 Access Attempt
- This port is intentionally blocked for security
- Users attempting to access it will receive a connection refused error
- This is expected behavior

### Connection Issues
- Check firewall settings
- Verify the RDP service is running: `Get-Service TermService`
- Restart the container: `docker-compose restart`

## Features

✅ Full Windows 10 Desktop Environment  
✅ RDP Protocol on Port 8000  
✅ Backend Port (3000) Blocked for Security  
✅ GitHub Codespaces Integration  
✅ Docker Support  
✅ Easy Port Forwarding  

## Environment Variables

Set in `docker-compose.yml`:

- `ACCEPT_EULA=Y`: Accepts the Windows Server Core EULA

## Support

For issues or questions:
1. Check the Troubleshooting section above
2. Review Docker logs: `docker-compose logs`
3. Open an issue in the repository

## License

This project is provided as-is for educational and development purposes.

---

**Created**: June 2026  
**Windows Version**: Windows Server Core (ltsc2019)  
**Container Runtime**: Docker
