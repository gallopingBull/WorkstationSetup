param ( [Parameter(Mandatory=$true)] [Array]$ChocoPackages )

if (-not $ChocoPackages) {
	Write-Host "Exiting... ChocoPackages args is empty!"
	exit 0
}
				
# Loop through each package
foreach ($package in $ChocoPackages) {
    # Install the package
    choco install $package.name -y
    
    # Wait for the installation to complete and check status
    do {
        Start-Sleep -Seconds 5
        $status = choco list | Select-String $package.name
    } while (-not $status)
    
    Write-Host "$package installation complete."
}
