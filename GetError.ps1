﻿U
$ErrorMessages = Invoke-SQLcmd -serverInstance localhost -database Database1 -Query "select distinct ErrorMessage from Tabel1"

foreach($row in $ErrorMessages)
{
$DevicesFailing = Invoke-SQLcmd -serverInstance localhost -database Database1 -Query "select devicename from Tabel1 where ErrorMessage = '$($row.ErrorMessage)' "-QueryTimeout 200 
$Devices = $DevicesFailing.Devicename -JOIN ","

 #Write-Host "DevicesFailing with Error message '$($row.ErrorMessage)',$Devices" 
 $Cachinghash = @{
"Message = Not authorized to execute this command [show HA node]" = "Not authorized to execute this command [show HA node]"
"Message = Not authorized to execute this command [show vlan]"="Not authorized to execute this command [show HA node]"
"Message = Object reference not set to an instance of an object"= "Object reference not set to an instance of an object"
"Message = The request failed with HTTP status 401: F5 Authorization Required."="401: F5 Authorization Required"
"Message = The request failed with HTTP status 404: Not Found."="404: Not Found"
"Message = The underlying connection was closed: An unexpected error occurred on a send."="The underlying connection was closed"
"Message = The underlying connection was closed: An unexpected error occurred on a receive."="The underlying connection was closed"
"Message = Unable to connect to the remote server"="Unable to connect to the remote server"
"Message=com.citrix.netscaler.nitro.exception.nitro_exception: Connection refused
   at com.citrix.netscaler.nitro.resou"="Connection refused"
"Message=com.citrix.netscaler.nitro.exception.nitro_exception: Invalid username or password
   at com.citrix.netscaler.n"="Invalid username or password"
"Message=System.Net.WebException: The request was aborted: Could not create SSL/TLS secure channel.
   at com.citrix.net"="Could not create SSL/TLS secure channel"
"Message=System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a receive. ---> S"="The underlying connection was closed"
"Message=System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> Syst"="The underlying connection was closed"
"Message=System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A con"="Unable to connect to the remote server"
"Message=System.NullReferenceException: Object reference not set to an instance of an object.
   at com.citrix.netscaler"="Object reference not set to an instance of an object"}


  $slice = $Cachinghash.$($row.ErrorMessage)

 
 invoke-expression "G:\CreateTickets.ps1"
}














