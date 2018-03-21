New-UDPage -Url "/vm/:vmname" -Icon desktop -Endpoint {
    param($vmname) 

    $VM = Get-VM -Name $vmname

    New-UDCard -Title $VM.Name -Content {
        $VM.Name
    }
}