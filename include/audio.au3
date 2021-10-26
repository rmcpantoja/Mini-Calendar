; This file has no functions, it is simply used to initialize COMAudio, the com library that ; I use for audio playback. All it does is to register the object using regsvr32, and then 
; it initializes it.
$comaudio = ObjCreate("ComAudio.Service")
If @Error then
$dwncomaudio = InetGet("https://www.dropbox.com/s/vqi3yi50mti9gp8/comaudio.exe?dl=1", "comaudio.exe")
RunWait("comaudio.exe /SILENT")
InetClose($dwncomaudio)
$comaudio = ObjCreate("ComAudio.Service")
If @Error then
MsgBox(16, "Error", "No fue posible instalar las librerías de audio necesarias. Por favor, ejecuta este programa como administrador.")
Exit
EndIf
endif
;$comaudio.archiveExtension = "sounds.dat"
$comaudio.UseEncryption = true
$comaudio.EncryptionKey = "superpollo"
$device = $comaudio.openDevice("","")