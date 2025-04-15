function Update-TerraformVersion {
    param (
        [Parameter(HelpMessage = "Path to version.tf file")]
        [string]$FilePath="$(Split-Path -Parent $PSScriptRoot)\terraform__main_files\versions.tf"
    )

    if (-Not (Test-Path $FilePath)) {
        Write-Error "File not found: $FilePath"
        return
    }

    Write-Host "[INFO] Starting Update-TerraformVersion script"

    # Get latest Terraform version from HashiCorp Checkpoint API
    $url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"
    $response = Invoke-RestMethod -Uri $url -UseBasicParsing
    $latestTerraform = $response.current_version

    Write-Host "[INFO]  Latest Terraform version: $latestTerraform"

    # Read the entire content as one string
    $content = Get-Content $FilePath -Raw

    # Regex to match required_version inside terraform block
    $pattern = '(required_version\s*=\s*")>=?\s*[\d\.]+(")'
    $replacement = "`$1>= $latestTerraform`$2"

    if ($content -match $pattern) {
        $newContent = [regex]::Replace($content, $pattern, $replacement, 'Singleline')
        $newContent | Out-File -FilePath $FilePath -Encoding utf8 -NoNewline
        Write-Host "[DONE] Terraform version updated to >= $latestTerraform in: $FilePath"
    }
    else {
        Write-Warning "[WARNING] Could not find required_version in terraform block. Nothing was updated."
    }
}