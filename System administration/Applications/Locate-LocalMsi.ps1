param($app)

#TODO
# Change this to search the registry
$sw = Get-CimInstance -ClassName Win32_Product | Where-Object { $_.Name -match $app }

# This path contains the name of the msi file
# i.e C:\Windows\Installer\61bb75.msi
$sw.LocalPackage
