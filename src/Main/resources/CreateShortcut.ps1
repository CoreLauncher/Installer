$Arguments = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($args[0]))
$Arguments = ConvertFrom-Json $Arguments

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($Arguments.From)
$Shortcut.IconLocation = $Arguments.Icon
$Shortcut.TargetPath = $Arguments.To
$Shortcut.Arguments = $Arguments.Arguments
$Shortcut.WorkingDirectory = $Arguments.CWD
$Shortcut.Save()