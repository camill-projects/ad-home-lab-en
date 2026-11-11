# Active Directory Home Lab: Simulated Company (firma.local)

A hands-on home lab that simulates the IT environment of a company with **100 employees** using Windows Server 2022 and Active Directory. The goal is to practice the daily work of an IT Helpdesk / Support specialist: user and group management, PowerShell automation, group policies and troubleshooting.

## Environment

| Component | Details |
|---|---|
| Hypervisor | Oracle VirtualBox 7.2 |
| Server | Windows Server 2022 Standard Evaluation (Desktop Experience), hostname `DC01` |
| Resources | 4 GB RAM, 2 vCPU, 50 GB disk |
| Domain | `firma.local` (NetBIOS: `FIRMA`) |
| Network | Adapter 1: NAT (internet), Adapter 2: Internal Network (static IP 192.168.10.10/24) |

## Company structure

| Department | Employees | Security group |
|---|---|---|
| IT | 10 | GRP-IT |
| HR | 10 | GRP-HR |
| Sales | 30 | GRP-Sales |
| Finance | 15 | GRP-Finance |
| Operations | 25 | GRP-Operations |
| Management | 10 | GRP-Management |

All users are fictional. Accounts are created with an initial password and **forced password change at first logon**.

## Project steps

1. [VM and Windows Server setup](01-vm-setup.md)
2. [Domain controller promotion](02-domain-controller.md)
3. [OUs, groups and users (PowerShell automation)](03-ou-groups-users.md)
4. Network shares and permissions *(planned)*
5. Group Policy (GPO) *(planned)*
6. Windows client joined to the domain *(planned)*
7. Helpdesk scenarios: password reset, account unlock, missing access *(planned)*

## Scripts

- [`create-ou-groups.ps1`](create-ou-groups.ps1): creates the OU structure and security groups
- [`create-users.ps1`](create-users.ps1): creates 100 fictional users and assigns them to groups

## Troubleshooting

Problems I ran into and how I solved them: [troubleshooting.md](troubleshooting.md)

## What I learned

- Installing and configuring Active Directory Domain Services
- Designing an OU structure and using security groups
- Automating account creation with PowerShell (`New-ADUser`, `Add-ADGroupMember`)
- Diagnosing and fixing script errors
- Documenting every step
