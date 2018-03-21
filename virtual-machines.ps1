New-UDPage -Name "Virtual Machines" -Icon desktop -Content {
    New-UDTable -Title "Virtual Machines" -Headers @("Name", "State", "CPU Usage", "Assigned Memory", "Uptime") -Endpoint {
        Get-VM | ForEach-Object {
            [PSCustomObject]@{
                Name = New-UDLink -Url "/vm/$($_.Name)" -Text $_.Name
                State = $_.State.ToString()
                CPUUsage = $_.CPUUsage
                AssignedMemory = "$(($_.MemoryAssigned /1GB).ToString('0.00'))GB"
                Uptime = "$($_.Uptime.Days) days, $($_.Uptime.Hours) hours, $($_.Uptime.Minutes) minutes, $($_.Uptime.Seconds) seconds"
            } | Out-UDTableData -Property @("Name", "State", "CPUUsage", "AssignedMemory", "Uptime")
        }
    }
}