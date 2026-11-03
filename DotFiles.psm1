function Symlink-File {
    $DestPath = $args[0]
    $SourcePath = $args[1]
    if (Test-Path $DestPath) {
        Write-Warning "$DestPath is already symlinked"
    } else {
        if ((Get-Item $SourcePath) -is [System.IO.DirectoryInfo]) {
            cmd /c mklink /D "$DestPath" "$SourcePath"
        } else {
            cmd /c mklink "$DestPath" "$SourcePath"
        }

        if ($LASTEXITCODE -eq 0) {
            echo "$DestPath has been symlinked"
        } else {
            Write-Error "$DestPath symlink failed, exit code: $LASTEXITCODE"
        }
    }
}

function Unsymlink-File {
    $DestPath = $args[0]
    $SourcePath = $args[1]
    if (Test-Path $DestPath) {
        if ((Get-Item $SourcePath) -is [System.IO.DirectoryInfo]) {
            cmd /c rmdir "$DestPath"
        } else {
            cmd /c del "$DestPath"
        }

        if ($LASTEXITCODE -eq 0) {
            echo "$DestPath has been unsymlinked"
        } else {
            Write-Error "$DestPath unsymlink failed, exit code: $LASTEXITCODE"
        }
    } else {
        Write-Warning "$DestPath doesn't exist"
    }
}

function Deploy-Manifest {
    $ManifestFile = $args[0]
    
    echo "Deploying $ManifestFile..."

    $Manifest = Get-Content -LiteralPath ".\$ManifestFile" |
                Where-Object { $_ -notmatch '^\s*(#|$)' } |
                ConvertFrom-Csv -Header file, operation, destination -Delimiter '|'
    $EmacsHome = $env:HOME
    foreach ($ManifestRow in $Manifest) {
        $DeployFile = $ManifestRow.file
        $DeployOp = $ManifestRow.operation
        $SourcePath = "$PSScriptRoot\$DeployFile"
        $DestPath = "$EmacsHome\$DeployFile"
        if (-not [string]::IsNullOrWhiteSpace($ManifestRow.destination)) {
            $Destination = $ManifestRow.destination.Trim()
            $DestPath = "$EmacsHome\$Destination\$DeployFile"
        }
        switch($DeployOp) {
            "symlink" {
                Symlink-File $DestPath $SourcePath
            }
    
            "copy" {
                Write-Warning "The 'copy' operation is not implemented yet. Skipping..."
            }
    
            default {
                Write-Warning "Unknown operation $operation. Skipping..."
            }
        }
    }
}

function Undeploy-Manifest {
    $ManifestFile = $args[0]
    
    echo "Undeploying $ManifestFile..."

    $Manifest = Get-Content -LiteralPath ".\$ManifestFile" |
                Where-Object { $_ -notmatch '^\s*(#|$)' } |
                ConvertFrom-Csv -Header file, operation, destination -Delimiter '|'
    $EmacsHome = $env:HOME
    foreach ($ManifestRow in $Manifest) {
        $DeployFile = $ManifestRow.file
        $DeployOp = $ManifestRow.operation
        $SourcePath = "$PSScriptRoot\$DeployFile"
        $DestPath = "$EmacsHome\$DeployFile"
        if (-not [string]::IsNullOrWhiteSpace($ManifestRow.destination)) {
            $Destination = $ManifestRow.destination.Trim()
            $DestPath = "$EmacsHome\$Destination\$DeployFile"
        }
        switch($DeployOp) {
            "symlink" {
                Unsymlink-File $DestPath $SourcePath
            }
    
            "copy" {
                Write-Warning "The 'copy' operation is not implemented yet. Skipping..."
            }
    
            default {
                Write-Warning "Unknown operation $operation. Skipping..."
            }
        }
    }
}
