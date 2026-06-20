# src: https://xkln.net/blog/powershell-gui-basics/

Add-Type -assembly System.Windows.Forms

$Form = New-Object System.Windows.Forms.Form
$Form.Text = 'Title of the form window!'
$Form.Width = 1 # Settings this to 1 allows AutoSize to determine the minumum window size
$Form.Height = 1 # Settings this to 1 allows AutoSize to determine the minumum window size
$Form.AutoSize = $true 
$Form.FormBorderStyle = 'Fixed3D' # The user cannot resize the GUI window
$Form.MaximizeBox = $false  # The user cannot maximize the GUI window
$Form.TopMost = $true # The GUI window stays on top of other Windows

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Example label"
$Label.Font = 'Segoe UI, 20pt, style=Bold'
$label.TextAlign = "MiddleCenter"
$Label.AutoSize = $true

$Form.Controls.Add($Label)

$Form.ShowDialog() # This shows the GUI and starts an event loop inside the GUI.