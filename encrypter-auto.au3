#RequireAdmin
#include "include\audio.au3"
#include "include\zip.au3"
ConsoleWrite("verifying administrator privileges" &@crlf)
If not IsAdmin() Then
ConsoleWriteError("It was impossible to run the script with administrator rights." &@crlf)
sleep(200)
exit
else
ConsoleWrite("It's admin: Yes" &@crlf)
EndIf
encrypt()
func encrypt()
ConsoleWrite(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &": Starting the sounds encryption process..." &@CRLF)
;Creating the zip:
_Zip_Create(@scriptDir &"\tempsounds.zip")
ConsoleWrite(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &": Zip file created. Adding contents..." &@crlf)
sleep(200)
_Zip_AddFolderContents(@scriptDir &"\tempsounds.zip", @scriptDir &"\sounds")
if @error then
ConsoleWriteError(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &"Error: An error occurred while creating the sounds zip file." & @CRLF &"Error code: " &@error &@CRLF)
sleep(100)
exit
else
ConsoleWrite(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &": " &@scriptDir &"\tempsounds.zip created successfully!" & @CRLF)
EndIf
$filetoencr = @scriptDir &"\tempsounds.zip"
$savefile = @scriptDir &"\sounds.dat"
ConsoleWrite(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &": working..." &@crlf)
$comaudio.Encrypt($filetoencr, $savefile)
ConsoleWrite(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &": Done!" &@crlf &"File encripted as: " &$savefile &". Deleting the zip file..." &@crlf)
if FileDelete($filetoencr) = 1 then 
ConsoleWrite(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &": " &$filetoencr &" has been deleted." &@crlf)
else
ConsoleWriteError(@ScriptDir &" " &@year &"-" &@mon &"-" &@mday &" " &@HOUR & ":" &@MIN & ":" &@sec &"Error: An error occurred while deleting the zip file. It does not exist or has already been removed." &@CRLF)
EndIf
EndFunc