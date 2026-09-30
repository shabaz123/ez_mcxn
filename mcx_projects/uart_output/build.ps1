param (
    [ValidateSet("build", "clean", "pristine", "menuconfig", "list")]
    [string]$Action = "build",

    [string]$Board = "ez_mcxn",

    [ValidateSet("armgcc", "iar", "mdk")]
    [string]$Toolchain = "armgcc",

    [string]$Config = "debug",

    [string]$SdkRoot = $env:MCUXPRESSO_SDK_ROOT
)

$ErrorActionPreference = "Stop"

# ---------------------------------------------------------------------------
# Project paths
# ---------------------------------------------------------------------------

# Directory containing this build.ps1 file.
$ProjectDir = $PSScriptRoot

if (-not $ProjectDir) {
    $ProjectDir = (Get-Location).Path
}

# ---------------------------------------------------------------------------
# Discover board from example.yml if not supplied explicitly
# ---------------------------------------------------------------------------

if ([string]::IsNullOrWhiteSpace($Board)) {

    $ExampleFile = Join-Path $ProjectDir "example.yml"

    if (-not (Test-Path $ExampleFile)) {
        throw "No board specified and example.yml was not found."
    }

    $Lines = Get-Content $ExampleFile

    $BoardsLine = $Lines |
        Select-String '^\s+boards:\s*$' |
        Select-Object -First 1

    if (-not $BoardsLine) {
        throw "Could not find 'boards:' in example.yml."
    }

    for ($i = $BoardsLine.LineNumber; $i -lt $Lines.Count; $i++) {

        if ($Lines[$i] -match '^\s{4}([A-Za-z0-9_-]+):') {
            $Board = $Matches[1]
            break
        }
    }

    if ([string]::IsNullOrWhiteSpace($Board)) {
        throw "Could not determine board from example.yml."
    }
}

# ---------------------------------------------------------------------------

$BuildDir = Join-Path $ProjectDir "output"
$CustomBoardRoot = "C:/DEV/projects/mcx_projects/_boards"

Write-Host ""
Write-Host "MCUXpresso project build"
Write-Host "------------------------"
Write-Host "Project   : $ProjectDir"
Write-Host "Build     : $BuildDir"
Write-Host "SDK       : $SdkRoot"
Write-Host "Board     : $Board"
Write-Host "Toolchain : $Toolchain"
Write-Host "Config    : $Config"
Write-Host "Action    : $Action"
Write-Host ""

# ---------------------------------------------------------------------------
# Sanity checks
# ---------------------------------------------------------------------------

if ([string]::IsNullOrWhiteSpace($SdkRoot)) {
    throw "MCUXPRESSO_SDK_ROOT environment variable is not set."
}

if (-not (Test-Path $SdkRoot)) {
    throw "MCUXpresso SDK directory not found: $SdkRoot"
}

if (-not (Test-Path (Join-Path $ProjectDir "CMakeLists.txt"))) {
    throw "CMakeLists.txt not found in project directory: $ProjectDir"
}

if (-not (Get-Command west -ErrorAction SilentlyContinue)) {
    throw "'west' was not found in PATH."
}

# ---------------------------------------------------------------------------
# Run west from inside the MCUXpresso workspace.
#
# This is important because the NXP west extension commands (build,
# list_project, export_app, etc.) are discovered through the SDK's
# .west workspace.
# ---------------------------------------------------------------------------

Push-Location $SdkRoot

try {

    switch ($Action) {

        "build" {
            west build `
                -b $Board `
                $ProjectDir `
                -d $BuildDir `
                --toolchain $Toolchain `
                --config $Config `
                -- `
                "-DCUSTOM_BOARD_ROOT=$CustomBoardRoot"
        }

        "pristine" {
            west build `
                -p always `
                -b $Board `
                $ProjectDir `
                -d $BuildDir `
                --toolchain $Toolchain `
                --config $Config `
                -- `
                "-DCUSTOM_BOARD_ROOT=$CustomBoardRoot"
        }

        "clean" {
            if (Test-Path $BuildDir) {
                Write-Host "Removing build directory:"
                Write-Host "  $BuildDir"
                Remove-Item -Recurse -Force $BuildDir
            }
            else {
                Write-Host "Build directory does not exist."
            }
        }

        "menuconfig" {
            if (-not (Test-Path $BuildDir)) {
                throw "No build directory exists. Run '.\build.ps1' first."
            }

            west build `
                -d $BuildDir `
                -t menuconfig
        }

        "list" {
            west list_project `
                -p $ProjectDir `
                -b $Board `
                -t $Toolchain
        }
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE"
    }
}
finally {
    Pop-Location
}
