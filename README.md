# WorkstationSetup
 WorkstationSetup is a collection of PowerShell and batch scripts designed to automate the setup process for my workstation. These scripts download and install essential applications, utilities, and packages, ensuring a seamless and efficient configuration tailored for my regular needs.

# Notes

Several apps had to be downloaded and installed with Chocolatey because PowerShell’s `Invoke-WebRequest` command was unsuccessful.

### Issues Encountered:
1. **Visual Studio Code**:
   - Error: "The user installer is not to be run as administrator" occurred when using `Invoke-WebRequest` in admin mode. It installed in System mode, but needed user mode. Chocolatey was used as the alternative solution.
   
2. **uTorrent**:
   - Could not install silently using `Invoke-WebRequest`, and the outdated Chocolatey package was potentially insecure. Switched to qBitTorrent, which could perform a silent install via Chocolatey.

### Additional Notes:
- Ensure application names in `softwareList.json` match the final install names to avoid errors in the installation code.

### Unity Hub:
- Installed with Visual Studio Community using the ManagedGame workload.
- The Unity editor is installed with the `InstallUnity` script.

### Trello:
- Cannot be downloaded with `Invoke-WebRequest` due to lack of a direct download link. 
- Alternatives: Install via Chocolatey or using `winget` from the Microsoft Store. Preference given to Chocolatey due to its necessity for other installs.

### Photopea:
- Cannot be downloaded or installed via command line tool/package as it is browser-based. Consider other image editing programs or disregard.

### Other Utilities to Consider:
- **Bitwarden CLI**: [Bitwarden CLI](https://community.chocolatey.org/packages/bitwarden-cli)
- **Nuget**: `Install-PackageProvider -Name Nuget -Force`
	- This might already be installed with a Chocolatey package (need to verify).
- **Chris Titus Windows Utilities Package Tool**: [ChrisTitusTech](https://github.com/ChrisTitusTech/winutil)
- **OhMyPosh**: [OhMyPosh Installation](https://ohmyposh.dev/docs/installation/windows)
