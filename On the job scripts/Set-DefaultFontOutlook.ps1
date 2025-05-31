## !- still testing -! ##

#######################################################################################

## Script obtained from: https://www.joeyverlinden.com/default-fonts-and-styles-for-outlook-via-intune/
## The required binary values to configure the Outlook default font settings to Arial size 12 ##

$ValueSimple = "3C,00,00,00,1F,00,00,F8,00,00,00,40,F0,00,00,00,00,00,00,00,00,00,00,00,00,22,41,72,69,61,6C,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00"

$ValueComposeComplex = "3C,68,74,6D,6C,3E,0D,0A,0D,0A,3C,68,65,61,64,3E,0D,0A,3C,73,74,79,6C,65,3E,0D,0A,0D,0A,20,2F,2A,20,53,74,79,6C,65,20,44,65,66,69,6E,69,74,69,6F,6E,73,20,2A,2F,0D,0A,20,73,70,61,6E,2E,50,65,72,73,6F,6E,61,6C,43,6F,6D,70,6F,73,65,53,74,79,6C,65,0D,0A,09,7B,6D,73,6F,2D,73,74,79,6C,65,2D,6E,61,6D,65,3A,22,50,65,72,73,6F,6E,61,6C,20,43,6F,6D,70,6F,73,65,20,53,74,79,6C,65,22,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,74,79,70,65,3A,70,65,72,73,6F,6E,61,6C,2D,63,6F,6D,70,6F,73,65,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,6E,6F,73,68,6F,77,3A,79,65,73,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,75,6E,68,69,64,65,3A,6E,6F,3B,0D,0A,09,6D,73,6F,2D,61,6E,73,69,2D,66,6F,6E,74,2D,73,69,7A,65,3A,31,32,2E,30,70,74,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,66,6F,6E,74,2D,73,69,7A,65,3A,31,32,2E,30,70,74,3B,0D,0A,09,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,22,41,72,69,61,6C,22,2C,73,61,6E,73,2D,73,65,72,69,66,3B,0D,0A,09,6D,73,6F,2D,61,73,63,69,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,41,72,69,61,6C,3B,0D,0A,09,6D,73,6F,2D,68,61,6E,73,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,41,72,69,61,6C,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,22,54,69,6D,65,73,20,4E,65,77,20,52,6F,6D,61,6E,22,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,74,68,65,6D,65,2D,66,6F,6E,74,3A,6D,69,6E,6F,72,2D,62,69,64,69,3B,0D,0A,09,63,6F,6C,6F,72,3A,77,69,6E,64,6F,77,74,65,78,74,3B,0D,0A,09,66,6F,6E,74,2D,77,65,69,67,68,74,3A,6E,6F,72,6D,61,6C,3B,0D,0A,09,66,6F,6E,74,2D,73,74,79,6C,65,3A,6E,6F,72,6D,61,6C,3B,7D,0D,0A,2D,2D,3E,0D,0A,3C,2F,73,74,79,6C,65,3E,0D,0A,3C,2F,68,65,61,64,3E,0D,0A,0D,0A,3C,2F,68,74,6D,6C,3E,0D,0A"

$ValueReplyComplex = "3C,68,74,6D,6C,3E,0D,0A,0D,0A,3C,68,65,61,64,3E,0D,0A,3C,73,74,79,6C,65,3E,0D,0A,0D,0A,20,2F,2A,20,53,74,79,6C,65,20,44,65,66,69,6E,69,74,69,6F,6E,73,20,2A,2F,0D,0A,20,73,70,61,6E,2E,50,65,72,73,6F,6E,61,6C,52,65,70,6C,79,53,74,79,6C,65,31,0D,0A,09,7B,6D,73,6F,2D,73,74,79,6C,65,2D,6E,61,6D,65,3A,22,50,65,72,73,6F,6E,61,6C,20,52,65,70,6C,79,20,53,74,79,6C,65,31,22,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,74,79,70,65,3A,70,65,72,73,6F,6E,61,6C,2D,72,65,70,6C,79,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,6E,6F,73,68,6F,77,3A,79,65,73,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,75,6E,68,69,64,65,3A,6E,6F,3B,0D,0A,09,6D,73,6F,2D,61,6E,73,69,2D,66,6F,6E,74,2D,73,69,7A,65,3A,31,32,2E,30,70,74,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,66,6F,6E,74,2D,73,69,7A,65,3A,31,32,2E,30,70,74,3B,0D,0A,09,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,22,41,72,69,61,6C,22,2C,73,61,6E,73,2D,73,65,72,69,66,3B,0D,0A,09,6D,73,6F,2D,61,73,63,69,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,41,72,69,61,6C,3B,0D,0A,09,6D,73,6F,2D,68,61,6E,73,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,41,72,69,61,6C,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,22,54,69,6D,65,73,20,4E,65,77,20,52,6F,6D,61,6E,22,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,74,68,65,6D,65,2D,66,6F,6E,74,3A,6D,69,6E,6F,72,2D,62,69,64,69,3B,0D,0A,09,63,6F,6C,6F,72,3A,77,69,6E,64,6F,77,74,65,78,74,3B,0D,0A,09,66,6F,6E,74,2D,77,65,69,67,68,74,3A,6E,6F,72,6D,61,6C,3B,0D,0A,09,66,6F,6E,74,2D,73,74,79,6C,65,3A,6E,6F,72,6D,61,6C,3B,7D,0D,0A,2D,2D,3E,0D,0A,3C,2F,73,74,79,6C,65,3E,0D,0A,3C,2F,68,65,61,64,3E,0D,0A,0D,0A,3C,2F,68,74,6D,6C,3E,0D,0A"

$ValueTextComplex = "3C,68,74,6D,6C,3E,0D,0A,0D,0A,3C,68,65,61,64,3E,0D,0A,3C,73,74,79,6C,65,3E,0D,0A,0D,0A,20,2F,2A,20,53,74,79,6C,65,20,44,65,66,69,6E,69,74,69,6F,6E,73,20,2A,2F,0D,0A,20,70,2E,4D,73,6F,50,6C,61,69,6E,54,65,78,74,2C,20,6C,69,2E,4D,73,6F,50,6C,61,69,6E,54,65,78,74,2C,20,64,69,76,2E,4D,73,6F,50,6C,61,69,6E,54,65,78,74,0D,0A,09,7B,6D,73,6F,2D,73,74,79,6C,65,2D,6E,6F,73,68,6F,77,3A,79,65,73,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,70,72,69,6F,72,69,74,79,3A,39,39,3B,0D,0A,09,6D,73,6F,2D,73,74,79,6C,65,2D,6C,69,6E,6B,3A,22,50,6C,61,69,6E,20,54,65,78,74,20,43,68,61,72,22,3B,0D,0A,09,6D,61,72,67,69,6E,3A,30,63,6D,3B,0D,0A,09,6D,73,6F,2D,70,61,67,69,6E,61,74,69,6F,6E,3A,77,69,64,6F,77,2D,6F,72,70,68,61,6E,3B,0D,0A,09,66,6F,6E,74,2D,73,69,7A,65,3A,31,32,2E,30,70,74,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,66,6F,6E,74,2D,73,69,7A,65,3A,31,30,2E,35,70,74,3B,0D,0A,09,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,22,41,72,69,61,6C,22,2C,73,61,6E,73,2D,73,65,72,69,66,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,66,6F,6E,74,2D,66,61,6D,69,6C,79,3A,22,54,69,6D,65,73,20,4E,65,77,20,52,6F,6D,61,6E,22,3B,0D,0A,09,6D,73,6F,2D,62,69,64,69,2D,74,68,65,6D,65,2D,66,6F,6E,74,3A,6D,69,6E,6F,72,2D,62,69,64,69,3B,0D,0A,09,6D,73,6F,2D,66,6F,6E,74,2D,6B,65,72,6E,69,6E,67,3A,31,2E,30,70,74,3B,0D,0A,09,6D,73,6F,2D,6C,69,67,61,74,75,72,65,73,3A,73,74,61,6E,64,61,72,64,63,6F,6E,74,65,78,74,75,61,6C,3B,0D,0A,09,6D,73,6F,2D,66,61,72,65,61,73,74,2D,6C,61,6E,67,75,61,67,65,3A,45,4E,2D,55,53,3B,7D,0D,0A,2D,2D,3E,0D,0A,3C,2F,73,74,79,6C,65,3E,0D,0A,3C,2F,68,65,61,64,3E,0D,0A,0D,0A,3C,2F,68,74,6D,6C,3E,0D,0A"

#######################################################################################

# 
$registryPath = 'HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\mailsettings'
$Name1Simple = "ComposeFontSimple"
$Name1Complex = "ComposeFontComplex"
$Name2Simple = "ReplyFontSimple"
$Name2Complex = "ReplyFontComplex"
$Name3Simple = "TextFontSimple"
$Name3Complex = "TextFontComplex"

$hexSimple = $ValueSimple.Split(',') | % { "0x$_"}
$hexComposeComplex = $ValueComposeComplex.Split(',') | % { "0x$_"}
$hexReplyComplex = $ValueReplyComplex.Split(',') | % { "0x$_"}
$hexTextComplex = $ValueTextComplex.Split(',') | % { "0x$_"}

## If the mailsettings reg path does not exist, create the new items with their binary values 
## Otherwise, set the items with their binary values
If(!(Test-Path $registryPath)) {
    try {
        Write-Output "Registry path does not exist. Creating the new keys under $registryPath"
        New-Item -Path $registryPath -Force | Out-Null
        New-ItemProperty -Path $registryPath -name NewTheme -PropertyType string
        New-ItemProperty -Path $registryPath -Name $Name1Simple -Value ([byte[]]$hexSimple) -PropertyType Binary -Force
        New-ItemProperty -Path $registryPath -Name $Name2Simple -Value ([byte[]]$hexSimple) -PropertyType Binary -Force
        New-ItemProperty -Path $registryPath -Name $Name3Simple -Value ([byte[]]$hexSimple) -PropertyType Binary -Force
        New-ItemProperty -Path $registryPath -Name $Name1Complex -Value ([byte[]]$hexComposeComplex) -PropertyType Binary -Force
        New-ItemProperty -Path $registryPath -Name $Name2Complex -Value ([byte[]]$hexReplyComplex) -PropertyType Binary -Force
        New-ItemProperty -Path $registryPath -Name $Name3Complex -Value ([byte[]]$hexTextComplex) -PropertyType Binary -Force
    } catch [System.Exception] {
        Write-Output "ERROR: failed to create new registry keys."
        Write-Output "The fully qualified error ID is: $($_.FullyQualifiedErrorId)"
        Write-Output "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    }

} Else {
    Write-Output "Registry keys exist. Setting the new keys for Arial font size 12."
    Set-ItemProperty -Path $registryPath -name NewTheme -value $null
    Set-ItemProperty -Path $registryPath -name ThemeFont -value 2
    Set-ItemProperty -Path $registryPath -Name $Name1Simple -Value ([byte[]]$hexSimple) -Force
    Set-ItemProperty -Path $registryPath -Name $Name2Simple -Value ([byte[]]$hexSimple) -Force
    Set-ItemProperty -Path $registryPath -Name $Name3Simple -Value ([byte[]]$hexSimple) -Force
    Set-ItemProperty -Path $registryPath -Name $Name1Complex -Value ([byte[]]$hexComposeComplex) -Force
    Set-ItemProperty -Path $registryPath -Name $Name2Complex -Value ([byte[]]$hexReplyComplex) -Force
    Set-ItemProperty -Path $registryPath -Name $Name3Complex -Value ([byte[]]$hexTextComplex) -Force
}

##########################################
