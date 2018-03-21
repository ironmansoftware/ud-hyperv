New-UDPage -Name "Home" -Icon home -Content {
    $HostInfo = Get-VMHost 

    New-UDRow -Columns {
        New-UDColumn -Size 4 -Content {
            New-UDElement -Tag "h5" -Content {
                New-UDElement -Tag "i" -Attributes @{
                    className = "fa fa-desktop"
                }

                "   $($HostInfo.Name)"
            }
        
            New-UDElement -Tag "div" -Content {
                New-UDElement -Tag "i" -Attributes @{
                    className = "fa fa-microchip"
                }

                "   $($HostInfo.LogicalProcessorCount) Processors"
            } -Attributes @{
                className = "chip"
            }
        
            New-UDElement -Tag "div" -Content {
                New-UDElement -Tag "i" -Attributes @{
                    className = "fa fa-cube"
                }

                "   $([Math]::Round($HostInfo.MemoryCapacity / 1GB))GB Memory"
            } -Attributes @{
                className = "chip"
            }
        }

        New-UDColumn -Size 4 -Content {
            New-UDMonitor -Title "Network" -Endpoint {
                
            }
        }
    }

    New-UDRow -Columns {
        New-UDColumn -Size 12 -Content {
            New-UDTable -Title "Internal Network Adapters" -Headers @("Name", "Management OS", "Status") -Endpoint {
                $HostInfo = Get-VMHost 
                $HostInfo.InternalNetworkAdapters | Out-UDTableData -Property @("Name", "IsManagementOs", "Status")
            }
        }
    }

    New-UDRow -Columns {
        New-UDColumn -Size 12 -Content {
            New-UDTable -Title "External Network Adapters" -Headers @("Name", "Management OS", "Status") -Endpoint {
                $HostInfo = Get-VMHost 
                $HostInfo.ExternalNetworkAdapters | Out-UDTableData -Property @("Name", "IsManagementOs", "Status")
            }
        }
    }


}