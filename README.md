# IR-Script
This project aims to enable members of a Incident Response team to quickly triage various alerts that require in-depth investigation.
The tool was developed as a powershell script for the following reasons:
- Easily shared amongst team members
- Ability to upgrade and adapt the script depending on changing needs
- Powershells' integration across the Microsoft environment

Note: As mentioned below, this script does not work outside the Micron environment. Also, certain steps are confidential. However, best effort will be made below to show both steps needed for CS 481 consideration as well as my techincal knowledge.

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
# Usage
Navigate to directory containing the script. (TBD - name of script)

- Run
```
.\script.ps1
```
You will be presented with the options screen below:

TBD - Screenshot of menu

Examples of output for each option are below:

TBD - Option 1 successful screenshot

TBD - Option 2 successful screenshot

TBD - Option 3 successful screenshot

TBD - Option 4 successful screenshot

# Contributors
- Colten Davis (myself)
- C. Kirkman 
- S. Robles

# Notes
This project was worked on interally to Micron. Thus, there are no sequence of committs due to legal policies. Once the project was cleared by my legal department, the entirety of the script was committed here at once. 

Micron contributors as well have been limited to their first initial and their last name to keep their identities confidential.

# Contact
Colten Davis - coltendavis@u.boisestate.edu

# Confidentiality
This tool was developed for a Incident Reponse team at Micron. The tool in its current state on this repo is non-functional, as confidential information contained within
the code has been redacted or replaced with general placeholderes. 

This code is not to be used or reproduced by any means except for the explicit work needed to assess if this project meets the requirements for the CS 481 class at BSU to be signed off. 

# Acknowledgements
- [Powershell VS Addon](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
