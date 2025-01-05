param ( [string]$CurrentDirectory )

Write-Host "Start software installion process"

# Use the provided working directory or default to current directory if not provided 
if (-not $CurrentDirectory) { $CurrentDirectory = (Get-Location).Path } 
# Remove any trailing empty spaces from the CurrentDirectory 
$CurrentDirectory = $CurrentDirectory.TrimEnd(" ")


# Define the subfolder name where the installation files are located 
$subfolderName = "InstallFiles" 

# Create the working directory path by combining the working directory and subfolder name
$WorkingDirectory = Join-Path -Path $CurrentDirectory -ChildPath $subfolderName

# Define the log file path 
$logFilePath = Join-Path -Path $CurrentDirectory -ChildPath "Installation_Logs.txt"

# Output the current directory for verification 
Write-Host "Current Directory: $CurrentDirectory"

# Output the working directory for verification 
Write-Host "Working Directory: $WorkingDirectory" 

# Read the JSON file 
$jsonContent = Get-Content -Path "$WorkingDirectory\softwareList.json" -Raw

# Parse the JSON content 
$jsonObject = $jsonContent | ConvertFrom-Json 

# Declare the list of software that will be installed
$softwareList = @() 

# Extract objects containing name, url, and silentArgs properties 
Write-Host "Extract objects containing name, url, and silentArgs properties "
foreach ($app in $jsonObject.applications) { 
	$softwareList += [PSCustomObject]@{ 
		Name = $app.name 
		URL = $app.url 
		SilentArgs = $app.silentArgs 
	} 
	# Display the result
	Write-Host "App:" $app.name
} 

# Display all results from the JSON file
$softwareList

& "$WorkingDirectory\InstallAllSoftware.ps1" -Software $softwareList | Tee-Object -FilePath $logFilePath -Append
#& "$WorkingDirectory\InstallAllSoftware.ps1" -Software $softwareList

#Write-Host "All software installed successfully."

# Declare the list of Windows packages that will be installed
$utilList = @() 

# Extract objects containing name, url, and silentArgs properties 
Write-Output "Extract utility objects containing name and command properties"
foreach ($util in $jsonObject.utilities) { 
	$utilList += [PSCustomObject]@{ 
		Name = $util.name 
		Command = $util.command
	} 
	# Display the result
	Write-Host "Util:" $util.name
	iex $util.Command
} 

Write-Output "All utilities installed successfully."

# Declare the list of Choclatey packages that will be installed
$chocoPkgList = @() 

Write-Output "Extract Chocolatey package objects containing name and options properties"
foreach ($chocoPkg in $jsonObject.chocopackages) { 
	$chocoPkgList += [PSCustomObject]@{ 
		Name = $chocoPkg.name 
	} 
	# Display the result
	Write-Host "chocoPkg:" $chocoPkg.name
} 

& "$WorkingDirectory\InstallChocoPackages.ps1" -ChocoPackages $chocoPkgList | Tee-Object -FilePath $logFilePath -Append

#& "$WorkingDirectory\InstallChocoPackages.ps1" -ChocoPackages $chocoPkgList

Write-Output "All software installed successfully. Installation logs saved to $"