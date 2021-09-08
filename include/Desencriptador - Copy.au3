#include <Crypt.au3>
#include <StringConstants.au3>
func Desencriptar()
speaking("Comprovando paquete de sonidos...")
sleep(200)
$iAlgorithm = $CALG_AES_256
$sSourceRead = "soundsdata.dat"
$sDestinationRead = @TempDir &"\soundsdata.dat.zip"
$sPasswordRead = "Amarteeslomejorquemehapasadoenlavidaporquedesdecuandoteconocimehasenseñadomuchascosas1234567890abcdefghijklmnñopqrstuvwxyz"
If StringStripWS($sSourceRead, $STR_STRIPALL) <> "" And StringStripWS($sDestinationRead, $STR_STRIPALL) <> "" And StringStripWS($sPasswordRead, $STR_STRIPALL) <> "" And FileExists($sSourceRead) Then
If _Crypt_DecryptFile($sSourceRead, $sDestinationRead, $sPasswordRead, $iAlgorithm) Then
speaking("Listo")
;MsgBox($MB_SYSTEMMODAL, "Success", "Operation succeeded.")
Else
Switch @error
Case 30
MsgBox($MB_SYSTEMMODAL, "Error", "Failed to create the key.")
Case 2
MsgBox($MB_SYSTEMMODAL, "Error", "Couldn't open the source file.")
Case 3
MsgBox($MB_SYSTEMMODAL, "Error", "Couldn't open the destination file.")
Case 400 Or 500
MsgBox($MB_SYSTEMMODAL, "Error", "Decryption error.")
Case Else
MsgBox($MB_SYSTEMMODAL, "Error", "Unexpected @error = " & @error)
EndSwitch
EndIf
Else
MsgBox($MB_SYSTEMMODAL, "Error", "Please ensure the relevant information has been entered correctly.")
EndIf
EndFunc