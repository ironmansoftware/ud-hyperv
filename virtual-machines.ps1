New-UDPage -Name "Virtual Machines" -Icon desktop -Content {
    New-UDTable -Title "Virtual Machines" -Headers @("Name", "State", "CPU Usage", "Assigned Memory", "Uptime", "Power Manager") -Endpoint {
        Get-VM | ForEach-Object {
            [PSCustomObject]@{
                Name = New-UDLink -Url "/vm/$($_.Name)" -Text $_.Name
                State = New-UDElement -Tag "span" -Id "state_$($_.Name)" -Content { 
                    $_.State.ToString() 
                }
                CPUUsage = $_.CPUUsage
                AssignedMemory = "$(($_.MemoryAssigned /1GB).ToString('0.00'))GB"
                Uptime = "$($_.Uptime.Days) days, $($_.Uptime.Hours) hours, $($_.Uptime.Minutes) minutes, $($_.Uptime.Seconds) seconds"
                PowerManager = New-UDElement -Tag "a" -Attributes @{
                    href = "#!"
                    onClick = {
                        $vm = Get-VM -Name $_.Name 
                        switch ($vm.state) {
                            'Off' { Start-VM $_.Name }
                            'Running' { Stop-VM $_.Name }
                        }
                    }
                } -Content {
                    $vm = Get-VM -Name $_.Name 
                    switch ($vm.state) {
                        'Off' { "Start" }
                        'Running' { "Stop" }
                        default { $vm.State.ToString() }
                    }
                }
            } | Out-UDTableData -Property @("Name", "State", "CPUUsage", "AssignedMemory", "Uptime", "PowerManager")
        }
    }
}