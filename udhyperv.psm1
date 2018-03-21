function Start-UDHyperDashboard {
    param(
        $Port = 10000
    )

    $HomePage = . "$PSScriptRoot\home.ps1"
    $virtualMachines = . "$PSScriptRoot\virtual-machines.ps1"
    $virtualMachine = . "$PSScriptRoot\virtual-machine.ps1"
    $Dashboard = New-UDDashboard -Title "Hyper-V - $env:ComputerName" -Pages @($HomePage, $virtualMachines, $virtualMachine)

    Start-UDDashboard -Dashboard $Dashboard -Port $Port
}