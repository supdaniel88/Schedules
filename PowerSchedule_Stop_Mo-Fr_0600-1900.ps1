workflow PowerSchedule_Stop_Mo-Fr_0600-1900
{
    $Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
 
    $FindVMs = Find-AzureRmResource -TagName "Schedule" -TagValue "Mo-Fr:0600-1900" | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"}
 
   Foreach -Parallel ($vm in $Findvms)
 
   {
    $vmName = $VM.Name
    $ResourceGroupName = $VM.ResourceGroupName
 
    Write-Output "Stopping $($vm.Name)";
    Stop-AzureRmVm -Name $vm.Name -ResourceGroupName $ResourceGroupName -Force;
    }
}