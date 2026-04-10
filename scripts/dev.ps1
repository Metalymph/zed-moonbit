param()

$ErrorActionPreference = "Stop"

if (Get-Command python -ErrorAction SilentlyContinue) {
    python scripts/dev.py
}
elseif (Get-Command py -ErrorAction SilentlyContinue) {
    py scripts/dev.py
}
else {
    Write-Error "Python was not found in PATH."
    exit 1
}