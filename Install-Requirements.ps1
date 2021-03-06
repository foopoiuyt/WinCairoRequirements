<#
  .Synopsis
  Builds all the source code required for building WebKit.
  .Details
  Invokes vcpkg install to build all the libraries.
  .Parameter Triplet
  The vcpkg triplet to use. Defaults to 'x64-windows-webkit'
  .Parameter Libraries
  Path to a JSON file containing the list of libraries. Defaults to 'WinCairoRequirements.json'.
#>

Param(
  [Parameter()]
  [string] $triplet = 'x64-windows-webkit',
  [Parameter()]
  [string] $libraries = 'WinCairoRequirements.json'
)

$json = Get-Content -Raw -Path $libraries | ConvertFrom-Json

$arguments = @('install')
$arguments += $json
$arguments += '--triplet'
$arguments += $triplet

Write-Host ('vcpkg {0}' -f ($arguments -Join ' '))

Start-Process -Wait -NoNewWindow `
  -FilePath 'vcpkg.exe' `
  -WorkingDirectory $PSScriptRoot `
  -ArgumentList $arguments
