# Set the registry value
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# Check the updated registry value
$rdpAuth = Get-ItemPropertyValue 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections"

switch ($rdpAuth) {
    0 { Write-Output "RDP authorized" }
    1 { Write-Output "RDP not authorized" }
    default { Write-Output "Unexpected value: $rdpAuth" }
}

# Enable Remote Desktop firewall rule
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Check the status of the Remote Desktop firewall rule
$rdpFirewallRule = Get-NetFirewallRule -DisplayGroup "Remote Desktop"

if ($rdpFirewallRule.Enabled) {
    Write-Output "Remote Desktop firewall rule enabled"
} else {
    Write-Output "Remote Desktop firewall rule not enabled"
}
