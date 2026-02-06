#Requires -Modules Logging
#Requires -Modules Hooks

Invoke-Hook "PreInstallCallOfDuty"

Write-Log -Message "Installing Call of Duty..."

if (-not (Test-Path -Path "${Env:SERVER_DIR}/cod_lnxded")) {
    Write-Log "Could not find cod_lnxded in ${Env:SERVER_DIR}, proceeding with installation."

    $downloadUrl = $Env:COD_URL

    Write-Log "Downloading Call of Duty from $downloadUrl"

    curl -L --output /tmp/COD.zip "$downloadUrl"

    unzip /tmp/COD.zip -d /tmp/COD

    Move-Item -Force -Path "/tmp/callofduty/*" -Destination $Env:SERVER_DIR
} else {
    Write-Log "Call of Duty already installed in ${Env:SERVER_DIR}, skipping installation."
}

chmod +x "${Env:SERVER_DIR}/cod_lnxded"

Write-Log -Message "Call of Duty installation complete."

Invoke-Hook "PostInstallCallOfDuty"

Set-Location $Env:SERVER_ROOT