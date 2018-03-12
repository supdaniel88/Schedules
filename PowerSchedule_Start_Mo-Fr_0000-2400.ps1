workflow PowerSchedule_Start_Mo-Fr_0000-2400
{$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
 
    $FindVMs = Find-AzureRmResource -TagName "Schedule" -TagValue "Mo-Fr:0000-2400" | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"}
 
   Foreach -Parallel ($vm in $Findvms)
 
   {
    $vmName = $VM.Name
    $ResourceGroupName = $VM.ResourceGroupName
 
    Write-Output "Starting $($vm.Name)";
    Start-AzureRmVm -Name $vm.Name -ResourceGroupName $ResourceGroupName;
   }
}
