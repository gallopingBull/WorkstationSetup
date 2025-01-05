# WorkstationSetup
 Automates Windows workstation setup by downloading and installing essential applications, utilities, and packages.


////////////////////////////////////////////////////////////////////
~~~~~~~~~~~~~~~~~ DOWNLOAD/INSTALL UTILITIES NOTES ~~~~~~~~~~~~~~~~
////////////////////////////////////////////////////////////////////

Nuget:
	Install-PackageProvider -Name Nuget -Force

chocolatey package manager:
	install:
		Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	
	uninstall:	
		https://community.chocolatey.org/courses/installation/uninstalling
		
	upgrade: 
		choco upgrade chocolatey
		
source: https://community.chocolatey.org/courses/installation/installing?method=installing-chocolatey#powershell		


other utilities to consider installing:

Chris Titus Windows Utlities Package Tool: https://github.com/ChrisTitusTech/winutil 
OhMyPosh: https://ohmyposh.dev/docs/installation/windows


////////////////////////////////////////////////////////////////////
~~~~~~~~~~~~~~~~~ DOWNLOAD/INSTALL SOFTWARE NOTES ~~~~~~~~~~~~~~~~
////////////////////////////////////////////////////////////////////

Can't really download and install this via any commmand line tool or package. This is a browser based application, 
look for other methods to install otherwise forget about it. 
{
  "name": "Photopea",
  "url": "",
  "loginRequired": true,
  "silentArgs": "/S"
},

-------------------------------------
Trello can't be downloaded with Invoke-WebRequest because trello doesn't provide a direct download
link to the application. Alternatives are to install via chocolatey or using winget via the microsoft store. 
I'm open to the former given the need for chocolatey for other installs but don't want to download and install 
from microsoft store.
{
"name": "Trello",
"url": "",
"loginRequired": false,
"silentArgs": "/S"
},
	
-------------------------------------    

Epic Launcher will need chocolatey to install. I couldn't use basic powershell calls like Invoke-WebRequest so most people suggest using Chocolatey.
{
     "name": "Epic Games Launcher",
     "url": "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi",
     "loginRequired": true,
     "silentArgs": "/i /qn"
},
https://community.chocolatey.org/packages/epicgameslauncher
choco install epicgameslauncher
	
-------------------------------------
Script mentioned in the link supplies a guthub link to a repo that has a script to use basic powershell calls to download and install browser. Most people still sugggest using choclatey.

Brave Browser	https://www.reddit.com/r/PowerShell/comments/weokgj/ive_written_a_powershell_script_to_download_and/?rdt=35460



-------------------------------------
vs code install with poershell doens't work in admin mode because it'of a system/user install conflict.

"name": "VS Code",
"url": "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user",
"loginRequired": false,
"silentArgs": "/VERYSILENT /MERGETASKS=!runcode"

https://community.chocolatey.org/packages/vscode.install
choco install vscode.install

-------------------------------------
"name": "uTorrent",
"url": "https://download-hr.utorrent.com/track/stable/endpoint/utorrent/os/riserollout?filename=utorrent_installer.exe",
"loginRequired": false,
"silentArgs": "/S /V/qn"



-------------------------------------

"name": "qBitTorrent",
"url": "https://sourceforge.net/projects/qbittorrent/files/latest/download",
"loginRequired": false,
"silentArgs": "/S"
		
https://community.chocolatey.org/packages/qbittorrent#testingResults
choco install qbittorrent

-------------------------------------
other ps cli package tools: winget install Brave.Brave Browser
https://community.chocolatey.org/packages/brave/1.73.104
choco install brave
-------------------------------------

"name": "GitHub Desktop",
"url": "https://central.github.com/deployments/desktop/desktop/latest/win32",
"loginRequired": true,
"silentArgs": "/S"

https://community.chocolatey.org/packages/github-desktop
choco install github-desktop

-------------------------------------

https://github.com/microsoft/unitysetup.powershell/blob/master/README.md


https://gist.github.com/aholkner/41929510d6b980b41903b2c612c11eea

https://github.com/StephenHodgson/UnityCI/blob/master/InstallUnityHub.ps1

https://community.chocolatey.org/packages/unity-hub#install

https://github.com/microsoft/unitysetup.powershell/issues/204

-------------------
install visual studio communty manually via cli w/ unity tools installed

Desktop Development with C++ Silent Install
ID: Microsoft.VisualStudio.Workload.NativeDesktop
Description: Build modern C++ apps for Windows using tools of your choice, including MSVC, Clang, CMake, or MSBuild
	
	vs_setup.exe --nocache --wait --noUpdateInstaller --noWeb --add Microsoft.VisualStudio.Workload.NativeDesktop;includeRecommended;includeOptional --quiet --norestart
	
	

FINAL FINAL VERSION:

	  "silentArgs": "--installPath C:\\VisualStudio --add Microsoft.VisualStudio.Workload.CoreEditor --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.VisualStudio.Workload.ManagedGame;includeRecommended;includeOptional --quiet --norestart --nocache --wait --noUpdateInstaller /S"

additional note: the final install name is different from the name in the software list causing the installsoftware code to output app wasn't installed because it cant find the name im refering it to even though it is installed. make names consistent. 



///////////

"C:\Program Files\Unity Hub"

https://docs.unity3d.com/hub/manual/HubCLI.html#manage-editors

https://discussions.unity.com/t/unity-hub-cli-issues-403-request-and-ampli-errors/1573632

	{
	  "name": "Unity 3D",
	  "url": "https://download.unity3d.com/download_unity/27c554a2199c/Windows64EditorInstaller/UnitySetup64-6000.0.27f1.exe",
	  "loginRequired": false,
	  "silentArgs": "/S"
	},
	
	
	
	--------------
	
	Issue with visual studio code when installing in admin mode
	uTorrent not installing in silent mode
	
	https://silentinstallhq.com/
	