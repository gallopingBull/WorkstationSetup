# Script to install individual applications only utilizing Powershell commands.

param (
    [string]$SoftwareName = ""
)

# Check if no name is provided
if ($SoftwareName -eq "") {
    Write-Host "Exiting... SoftwareName arg is empty!"
    exit 0
}

# Read the JSON file 
$jsonContent = Get-Content -Path 'softwareList.json' -Raw

# Parse the JSON content 
$jsonObject = $jsonContent | ConvertFrom-Json 

# Function to download and install software
function Install {
    param (
        [string]$Name,
        [string]$Url,
        [string]$SilentArgs
    )

    Write-Host "Installing $Name..."
    $installerPath = "$env:Temp\$($Name)_installer.exe"
    
    # Check if the directory exists, if not, create it
    $downloadDir = [System.IO.Path]::GetDirectoryName($installerPath)
    if (-not (Test-Path $downloadDir)) {
        New-Item -ItemType Directory -Force -Path $downloadDir
    }

    # Download the software
    Write-Host "Downloading software from $Url to $installerPath..."
    Invoke-WebRequest -Uri $Url -OutFile $installerPath
    
    if (Test-Path $installerPath) {
        Write-Host "$Name download successful!"
        
        $process = Start-Process -FilePath $installerPath -ArgumentList $SilentArgs -Wait -PassThru -NoNewWindow
        #Write-Host "SilentArgs: $SilentArgs"
        Write-Host "Waiting for $Name installation to complete..."
        
        # Wait for the process to exit 
        $process.WaitForExit() 
		# Sleep for 5 seconds to ensure the process has fully ended 
		Start-Sleep -Seconds 10
	
        # Check the exit code 
        if ($process.ExitCode -eq 0) { 
            # Check if the installation was successful
            $isInstalled = Is-ApplicationInstalled -appName $Name
            if ($isInstalled) { 
                Write-Output "Application '$Name' installation complete!" 
            
			   # Delete installation files
				Write-Host "Deleting $Name installation files"
				Remove-Item -Force -Recurse -Path $installerPath
            } else {
                Write-Output "Application '$Name' is not installed." 
            } 
        } else { 
            Write-Output "The installation process did not complete successfully. Exit code: $($process.ExitCode)" 
			
			# Delete installation files
			Write-Host "Deleting $Name installation files"
			Remove-Item -Force -Recurse -Path $installerPath
        }
    } else {
        Write-Host "$Name download failed!"
    }
}

# Function to check if an application is installed 
function Is-ApplicationInstalled { 
    param ( 
        [string]$appName 
    ) 
        
    # Get installed applications from the registry
    $installedApps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, 
                                      HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

    # Get installed applications from Program Files and Program Files (x86)
    $programsDirs = @("C:\Program Files", "C:\Program Files (x86)")
    $programs = @()

    foreach ($dir in $programsDirs) {
        if (Test-Path $dir) {
            $programs += Get-ChildItem -Path $dir -Directory
        }
    }

    # Combine both lists
    $allInstalledApps = $installedApps + $programs

    # Display the combined list of installed applications
    $allInstalledApps | ForEach-Object { 
        Write-Output "Name: $($_.DisplayName), Version: $($_.DisplayVersion)"
    }
    
    foreach ($app in $allInstalledApps) { 
        if ($app.DisplayName -eq $appName) { 
            return $true 
        } 
    } 
    return $false
}

# Iterate through the extracted apps and install each one
foreach ($app in $jsonObject.applications) { 
    # Display the result
    if ($SoftwareName -eq $app.name) { 
        Install -Name $SoftwareName -Url $app.url -SilentArgs $app.silentArgs
        break
    }
} 
