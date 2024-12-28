# Installing AD DS on Server Core Using PowerShell

# run ADDS-ServerCore-1 first, then run ADDS-ServerCore-2

# change to system32 directory
Set-Location -Path "C:\Windows\System32"

# set values
$InterfaceIndex = 2
$IPAddress = "172.30.100.3"
$SubnetMask = "255.255.255.0"
$Gateway = "172.30.100.1"

# configure network settings using netsh
netsh interface ipv4 set address name="$InterfaceIndex" source=static address=$IPAddress mask=$SubnetMask gateway=$Gateway
netsh interface ipv4 show ip

# set admin password
$AdminPassword = "CT209Hm$"
net user Administrator $AdminPassword

# rename computer
$NewComputerName = "DC3"
netdom renamecomputer $env:COMPUTERNAME /newname:$NewComputerName

# restart to apply
Restart-Computer -Force