<#
.SYNOPSIS
Create a new XML file 
.DESCRIPTION
Create a file with XML data that allows specific apps to be pinned to the Taskbar. Deploy the file to all users' C: drive to allow a 'Start Menu' Intune policy value to be true
.PARAMETER <parameter>
No parameters are used for this script
.EXAMPLE
Create-TaskbarLayoutXMLFile.ps1

.NOTES
Author: Daniel Macdonald
#>


# Ensure the file DOES NOT exist
If (!(Test-Path C:\Temp\Taskbar-Layout.xml))
{
    # Create a new file with the XML data
    New-Item -Path C:\Temp -Name Taskbar-Layout.xml -ItemType File
    Add-Content -Path C:\Temp\Taskbar-Layout.xml -Value `
    "<!-- Taskbar pinned apps layout -->
    <?xml version='1.0' encoding='utf-8'?>
    <LayoutModificationTemplate
        xmlns='http://schemas.microsoft.com/Start/2014/LayoutModification'
        xmlns:defaultlayout='http://schemas.microsoft.com/Start/2014/FullDefaultLayout'
        xmlns:start='http://schemas.microsoft.com/Start/2014/StartLayout'
        xmlns:taskbar='http://schemas.microsoft.com/Start/2014/TaskbarLayout'
        Version='1'>
    <CustomTaskbarLayoutCollection PinListPlacement='Replace'>
        <defaultlayout:TaskbarLayout>
        <taskbar:TaskbarPinList>
            <taskbar:DesktopApp DesktopApplicationID='Microsoft.Windows.Explorer' /> 
            <taskbar:DesktopApp DesktopApplicationID='MSEdge' /> 
            <taskbar:UWA AppUserModelID='Microsoft.WindowsTerminal_8wekyb3d8bbwe!App' /> 
            <taskbar:UWA AppUserModelID='Microsoft.CompanyPortal_8wekyb3d8bbwe!App' />
        </defaultlayout:TaskbarLayout>
    </CustomTaskbarLayoutCollection>
    </LayoutModificationTemplate>"
}
