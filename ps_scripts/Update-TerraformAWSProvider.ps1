function Update-TerraformAWSProvider {
    param (
        [Parameter(HelpMessage = "Path to version.tf file")]
        [string]$FilePath="$(Split-Path -Parent $PSScriptRoot)\terraform__main_files\versions.tf"
    )

    if (-Not (Test-Path $FilePath)) {
        Write-Error "File not found: $FilePath"
        return
    }

    Write-Host "[INFO] Start Update-TerraformAWSProvider script"

    # Get latest AWS provider version from correct endpoint
    $url = "https://registry.terraform.io/v1/providers/hashicorp/aws"
    $response = Invoke-RestMethod -Uri $url -UseBasicParsing
    $latestAWS = $response.versions[-1]

    Write-Host "[INFO]  Latest AWS provider version: $latestAWS"

    # Read the file content as a single string (multiline support)
    $content = Get-Content $FilePath -Raw

    # Regex to match the "version = ..." line inside the aws block
    $pattern = '(aws\s*=\s*\{[^}]*?version\s*=\s*")~?>?\s*[\d\.]+(")'
    $replacement = "`$1~> $latestAWS`$2"

    if ($content -match $pattern) {
        $newContent = [regex]::Replace($content, $pattern, $replacement, 'Singleline')
        $newContent | Out-File -FilePath $FilePath -Encoding utf8 -NoNewline
        Write-Host "[DONE] AWS provider version updated to ~> $latestAWS in: $FilePath"
    }
    else {
        Write-Warning "[WARNING] Could not find an existing AWS provider block. Nothing was updated."
    }
}