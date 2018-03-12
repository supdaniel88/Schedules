workflow PowerSchedule_Stop_Tu-Fr_0800_2400
{
    $Conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
 
    $FindVMs = Find-AzureRmResource -TagName "Schedule" -TagValue "Tu-Fr:0800_2400" | where {$_.ResourceType -like "Microsoft.Compute/virtualMachines"}
 
   Foreach -Parallel ($vm in $Findvms)
 
   {
    $vmName = $VM.Name
    $ResourceGroupName = $VM.ResourceGroupName
 
    Write-Output "Stopping $($vm.Name)";
    Stop-AzureRmVm -Name $vm.Name -ResourceGroupName $ResourceGroupName -Force;
    }
}