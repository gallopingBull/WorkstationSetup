param ( [Parameter(Mandatory=$true)] [Array]$Software )

if (-not $Software) {
	Write-Output "Exiting... Software array is empty!"
	exit 0
}

# Function to download and install software
function Install {
    param (
        [string]$Name,
        [string]$Url,
        [string]$SilentArgs
    )

    Write-Output "Installing $Name..."
    $installerPath = "$env:Temp\$($Name)_installer.exe"
    
    # Check if the directory exists, if not, create it
    $downloadDir = [System.IO.Path]::GetDirectoryName($installerPath)
    if (-not (Test-Path $downloadDir)) {
        New-Item -ItemType Directory -Force -Path $downloadDir
    }

    # Download the software
    Write-Output "Downloading software from $Url to $installerPath..."
    Invoke-WebRequest -Uri $Url -OutFile $installerPath
    
    if (Test-Path $installerPath) {
        Write-Output "$Name download successful!"
        
        $process = Start-Process -FilePath $installerPath -ArgumentList $SilentArgs -Wait -PassThru -NoNewWindow
        #Write-Host "SilentArgs: $SilentArgs"
        Write-Output "Waiting for $Name installation to complete..."
        
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
        Write-Output "$Name download failed!"
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

# Loop through the software list and install each one
foreach ($software in $Software) {
	Install -Name $software.Name $software.Url $software.SilentArgs
}

Write-Host "All software installed successfully."
