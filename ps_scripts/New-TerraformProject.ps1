function New-TerraformProject {
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Name of the new Terraform project folder")]
        [string]$NewProjectName
    )

    Write-Host "[INFO] Start New-TerraformProject script"

    # Get directory where script is located
    $ScriptDir = Split-Path -Parent $PSCommandPath

    # Go one level up: from ps_scripts → template_terraform_project
    $TemplateProjectDir = Split-Path -Parent $ScriptDir

    # Go two levels up: from ps_scripts → repo
    $GrandParentPath = Split-Path -Parent $TemplateProjectDir

    # Source = sibling folder to ps_scripts, i.e., terraform__main_files
    $SourcePath = Join-Path $TemplateProjectDir "terraform__main_files"

    # Destination folder = two levels up + new name
    $DestinationPath = Join-Path $GrandParentPath $NewProjectName

    # Check if source exists
    if (-Not (Test-Path $SourcePath)) {
        Write-host "[ERROR] Source folder 'terraform__main_files' not found in $TemplateProjectDir"
        return
    }

    # Check/create destination
    if (-Not (Test-Path $DestinationPath)) {
        New-Item -ItemType Directory -Path $DestinationPath | Out-Null
        Write-Host "[DONE] Created folder: $DestinationPath"
    } else {
        Write-host "[INFO] Folder '$NewProjectName' already exists in $GrandParentPath"
    }

    # Copy files
    Copy-Item -Path "$SourcePath\*" -Destination $DestinationPath -Recurse -Force
    Write-Host "[DONE] Files copied to '$DestinationPath' successfully."
}
