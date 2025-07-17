$targetVmSize = "Standard_B2pts_v2"

$availableRegions = @()

$dataFolderPath = "$PSScriptRoot/../data"

$jsonFiles = Get-ChildItem -Path $dataFolderPath -Filter "*.json"

foreach ($file in $jsonFiles) {
    $regionName = $file.BaseName
    $fileContent = Get-Content -Path $file.FullName
    $vmSizes = $fileContent | ConvertFrom-Json
    $foundVm = $vmSizes | Where-Object { $_.Name -eq $targetVmSize }

    if ($foundVm) {
        $availableRegions += $regionName
    }
}

$availableRegions | ConvertTo-Json | Out-File "$PSScriptRoot/result.json"