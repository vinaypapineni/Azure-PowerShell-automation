# Connect to Azure using Managed Identity
Connect-AzAccount -Identity

# Variables
$resourceGroup = "MyResourceGroup"
$location = "EastUS"
$vmName = "MyAutomationVM"
$vmSize = "Standard_DS1_v2"
$cred = Get-AutomationPSCredential -Name "MyVmCredential"

# Create the resource group (if it doesn't exist)
if (-not (Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroup -Location $location
}

# Create the VM
New-AzVM -ResourceGroupName $resourceGroup `
         -Name $vmName `
         -Location $location `
         -VirtualNetworkName "$vmName-vnet" `
         -SubnetName "$vmName-subnet" `
         -SecurityGroupName "$vmName-nsg" `
         -PublicIpAddressName "$vmName-ip" `
         -Credential $cred `
         -ImageName "Win2019Datacenter" `
         -Size $vmSize

