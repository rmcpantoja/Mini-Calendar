#include <Crypt.au3>
#include <StringConstants.au3>
encriptar()
func encriptar()
local $iAlgorithm = $CALG_AES_256
$sSourceRead = "soundsdata.dat.zip"
$sDestinationRead = @ScriptDir &"\soundsdata.dat"
$sPasswordRead = "Amarteeslomejorquemehapasadoenlavidaporquedesdecuandoteconocimehasenseñadomuchascosas1234567890abcdefghijklmnñopqrstuvwxyz"
If StringStripWS($sSourceRead, $STR_STRIPALL) <> "" And StringStripWS($sDestinationRead, $STR_STRIPALL) <> "" And StringStripWS($sPasswordRead, $STR_STRIPALL) <> "" And FileExists($sSourceRead) Then
If _Crypt_EncryptFile($sSourceRead, $sDestinationRead, $sPasswordRead, $iAlgorithm) Then
MsgBox($MB_SYSTEMMODAL, "Success", "Operation succeeded.")
Else
Switch @error
Case 30
MsgBox($MB_SYSTEMMODAL, "Error", "Failed to create the key.")
Case 2
MsgBox($MB_SYSTEMMODAL, "Error", "Couldn't open the source file.")
Case 3
MsgBox($MB_SYSTEMMODAL, "Error", "Couldn't open the destination file.")
Case 400 Or 500
MsgBox($MB_SYSTEMMODAL, "Error", "Encryption error.")
Case Else
MsgBox($MB_SYSTEMMODAL, "Error", "Unexpected @error = " & @error)
EndSwitch
EndIf
Else
MsgBox($MB_SYSTEMMODAL, "Error", "Please ensure the relevant information has been entered correctly.")
EndIf
EndFunc
func pack()
local $iAlgorithm = $CALG_AES_256
$sPasswordRead = "Amarteeslomejorquemehapasadoenlavidaporquedesdecuandoteconocimehasenseñadomuchascosas1234567890abcdefghijklmnñopqrstuvwxyz"
$freq = 440
$Extension = "mp3"
$listFiles =  _GetFilesFolder_Rekursiv("Sounds\soundsdata.dat", $Extension, 0, 0)
For $i = 1 to $listFiles[0]
beep($freq, 50)
$freq = $freq +9
_Crypt_EncryptFile($listfiles[$i], $listfiles[$i] &".enc", $sPasswordRead, $iAlgorithm)
if @error then
msgbox(0, "Error", @error)
EndIf
FileDelete($listfiles[$i])
Next
endfunc