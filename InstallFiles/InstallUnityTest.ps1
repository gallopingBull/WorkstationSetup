# Define the Unity Hub installation path
$unityHubPath = "C:\Program Files\Unity Hub"

# Define the Unity Editor version to install
$unityVersion = "2022.1.1f1"

# Define the modules/components to install
$modules = @("windows", "webgl")
#$modules = @("android", "appletv", "webgl")

# Function to install Unity Editor and modules
function Install-UnityEditor {
    param (
        [string]$unityHubPath,
        [string]$unityVersion,
        [array]$modules
    )

    # Navigate to Unity Hub directory
    Set-Location -Path $unityHubPath

    # Install the specified Unity Editor version
    & "$unityHubPath\UnityHub.exe" --headless install -v $unityVersion

    # Install the specified modules/components
    foreach ($module in $modules) {
        & "$unityHubPath\UnityHub.exe" --headless install -v $unityVersion --module $module
    }

    # Verify the installation
    & "$unityHubPath\UnityHub.exe" --headless editors -i
}

# Call the function to install Unity Editor and modules
Install-UnityEditor -unityHubPath $unityHubPath -unityVersion $unityVersion -modules $modules
