# Login to Azure (if not already logged in)
Connect-AzAccount
# Define variables
$resourceGroup = "DevResourceGroup"
$location = "EastUS"
$vmName = "DevVM"
$vmSize = "Standard_B1s"
$image = "Win2019Datacenter"
$adminUsername = "azureuser"
$adminPassword = ConvertTo-SecureString "YourP@ssw0rd123!" -AsPlainText -Force
# Create resource group (if not exists)
if (-not (Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroup -Location $location
}
# Create virtual machine config
$cred = New-Object System.Management.Automation.PSCredential ($adminUsername, $adminPassword)
New-AzVm `
  -ResourceGroupName $resourceGroup `
  -Name $vmName `
  -Location $location `
  -VirtualNetworkName "$vmName-VNet" `
  -SubnetName "$vmName-Subnet" `
  -SecurityGroupName "$vmName-NSG" `
  -PublicIpAddressName "$vmName-PIP" `
  -OpenPorts 22,80,3389 `
  -Credential $cred `
  -Image $image `
  -Size $vmSize
