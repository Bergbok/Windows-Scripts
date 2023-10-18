# NEEDS ADMIN PERMISSIONS
# Useful for bypassing family sharing restrictions
# Allows you to still play games even when someone is using your library 

# You might need to change the paths if you have your Steam installed in a custom directory

if (Get-NetFirewallRule | Where-Object DisplayName -EQ "Block-Steam"){
    Get-NetFirewallRule | Where-Object DisplayName -eq 'Block-Steam' | Remove-NetFirewallRule 
	echo "Unblocked Steam"
}else{
    New-NetFirewallRule -Action block -Program 'C:\Program Files (x86)\Common Files\Steam\SteamService.exe' -Profile any -Direction Outbound -Displayname 'Block-Steam' 
	New-NetFirewallRule -Action block -Program 'C:\Program Files (x86)\Steam\bin\cef\cef.win7x64\steamwebhelper.exe' -Profile any -Direction Outbound -Displayname 'Block-Steam' 
	New-NetFirewallRule -Action block -Program 'C:\program files (x86)\steam\steam.exe' -Profile any -direction Outbound -Displayname 'Block-Steam' 
	New-NetFirewallRule -Action block -Program 'C:\Program Files (x86)\Common Files\Steam\SteamService.exe' -Profile any -Direction Inbound -Displayname 'Block-Steam' 
	New-NetFirewallRule -Action block -Program 'C:\Program Files (x86)\Steam\bin\cef\cef.win7x64\steamwebhelper.exe' -Profile any -Direction Inbound -Displayname 'Block-Steam' 
	New-NetFirewallRule -Action block -Program 'C:\program files (x86)\steam\steam.exe' -Profile any -direction Inbound -Displayname 'Block-Steam'
    echo "Blocked Steam"
}