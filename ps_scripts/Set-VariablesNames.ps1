function Set-VariablesNames {
    param(
        [Parameter(Mandatory = $true, HelpMessage = "New string to replace 'ter-temp'")]
        [string]$ReplacementString
    )

    Write-Host "[INFO] Start Set Variables Names script"
    
    # Get directory where script is located
    $ScriptDir = Split-Path -Parent $PSCommandPath

    # Go one level up: from ps_scripts → template_terraform_project
    $TemplateProjectDir = Split-Path -Parent $ScriptDir

    # Get the parent directory of the template project directory
    $GrandParentPath = Split-Path -Parent $TemplateProjectDir

    # Set default path if not provided
    $TargetPath = Join-Path $GrandParentPath $ReplacementString
    
    # Check if the path exists
    if (-Not (Test-Path $TargetPath)) {
        Write-Host "[INFO] The specified path does not exist: $TargetPath"
        return
    }

    # Search and replace
    Get-ChildItem -Path $TargetPath -Recurse -File | ForEach-Object {
        $content = Get-Content -Path $_.FullName -Raw
        $newContent = $content -replace 'ter-temp', $ReplacementString

        if ($content -ne $newContent) {
            Set-Content -Path $_.FullName -Value $newContent
            Write-Host "[DONE] Updated file: $($_.FullName)"
        }
    }
}
Set-VariablesNames -ReplacementString "new_project"