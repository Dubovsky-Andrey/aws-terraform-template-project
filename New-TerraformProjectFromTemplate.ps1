function New-TerraformProjectFromTemplate {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectName
    )

    Write-host "[INFO] Start New-TerraformProjectFromTemplate script"
    # Get current directory
    $CurrentDir = Split-Path -Parent $PSCommandPath

    # Path to the functions directory
    $FunctionsPath = Join-Path $CurrentDir "ps_scripts"

    # Import all functions
    Get-ChildItem -Path $FunctionsPath -Filter *.ps1 | ForEach-Object {
        Write-Host "Loading: $($_.Name)"
        . $_.FullName
    }

    # Update terraform version and AWS provider
    Update-TerraformVersion
    Update-TerraformAWSProvider

    # Copy
    New-TerraformProject -NewProjectName $ProjectName

    # Change variables names in the copied project
    Set-VariablesNames -ReplacementString $ProjectName
}

# Example usage:
New-TerraformProjectFromTemplate -ProjectName "new_project_name"
