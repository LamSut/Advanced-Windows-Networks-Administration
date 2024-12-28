# Installing AD DS on Server Core Using PowerShell

# run this file after ADDS-ServerCore-1

# add DNS role
Add-WindowsFeature -Name DNS

# add Active Directory Domain Services role
Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# import ADDSDeployment module
Import-Module ADDSDeployment

# configure DNS client server address
$DNSServerAddress = "172.30.100.2"
Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses $DNSServerAddress

# promote server to domain controller
$DomainName = "A.lab"
$DomainAdminPassword = ConvertTo-SecureString -AsPlainText "" -Force
$SafeModeAdminPassword = ConvertTo-SecureString -AsPlainText "CT209Hm$" -Force

Install-ADDSDomainController -InstallDns `
    -Credential (Get-Credential) `
    -DomainName $DomainName `
    -SafeModeAdministratorPassword $SafeModeAdminPassword `
    -NoGlobalCatalog $false

# restart to apply
Restart-Computer -Force
