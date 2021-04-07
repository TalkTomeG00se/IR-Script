# IR-Script
This project aimed to enable members of a Incident Response team to quickly triage various alerts that require in-depth investigation.
The tool was developed as a powershell script for the following reasons:
- Easily shared amongst team members
- Ability to upgrade and adapt the script depending on changing needs
- Powershells' integration across the Microsoft environment

This project was considered complete when the following criteria were met:
- The script could capture the following information about a user: ID, username, AD Status, User Systems, and Resolve IP to Hostname
- Error handling was in place to account for incorrectly input IDs , Usernames and IPs.
- Error handling was in place for non-existent IDs, Usernames, and IPs not without our domain.


# Timeline
The project was slated to take 3-4 months, due to committing a few hours a week to it only. Initial feedback regarding the functionality of the script gave me an idea of how many LOC this project would be; I estimated that I could produce a script that is less than 700 LOC. Testing was ongoing as each function of the script was completed, and feedback was solicited regularly from my team. 

1-on-1 meetings were held every Monday with my direct supervisor to go over status of the project. Also of note, due to COVID restrictions, the entirety of this project and meetings were done from a work from home standpoint.


# Tools Used
- [VS Code](https://code.visualstudio.com)
- [Powershell](https://github.com/PowerShell/PowerShell)
- [Azure Active Directory](https://azure.microsoft.com/en-us/services/active-directory/)

# Prerequisites
- Powershell (latest version) - Can be installed via link above.

- Active Directory Admin LDS Tools are needed. All commands are done in a Powershell window:
```powershell
Get-WindowsCapability -Name "Rsat.ActiveDirectory.DS-LDSTools*" -Online | Add-WindowsCapability -Online
```
- As this script is internal, there are also necessary account permissions required to utilize the various Active Directory/API commands. Anyone
that is using the script internally would already have such persmissions.

# Usage
Navigate to directory containing the script. (TBD - name of script)

- Run
```
.\script.ps1
```
You will be presented with the options screen below:

![Menu Pix](/img/MainMenu.jpg)

# Contributors
- Colten Davis (myself)
- Chris
- Steve

# Notes
This project was worked on interally to Micron. Thus, there are no sequence of committs due to legal policies. Once the project was cleared by Micron, the entirety of the script was committed here at once. 

Also, as there are certain API calls and other confidential commands in the script, those confidential lines in the script have been replaced with a detailed comment.

Micron contributors as well have been limited to their first name to keep their identities confidential.

# Contact
Colten Davis - coltendavis@u.boisestate.edu

# Confidentiality
This tool was developed for a Incident Reponse team at Micron. The tool in its current state on this repo is non-functional, as confidential information contained within
the code has been redacted or replaced with general placeholderes. 

This code is not to be used or reproduced by any means except for the explicit work needed to assess if this project meets the requirements for the CS 481 class at BSU to be signed off. 

# Acknowledgements
- [Powershell VS Addon](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
