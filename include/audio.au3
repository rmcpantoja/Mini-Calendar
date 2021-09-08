; This file has no functions, it is simply used to initialize COMAudio, the com library that ; I use for audio playback. All it does is to register the object using regsvr32, and then 
; it initializes it.
$comaudio = ObjCreate("ComAudio.Service")
If @Error then
$installing = GUICreate("Installing comaudio")
GUICtrlCreateLabel("Installing necessary audio libraries...", 55, 32)
GUISetState(@SW_SHOW)
sleep(500)
$dwncomaudio = InetGet("https://www.dropbox.com/s/vqi3yi50mti9gp8/comaudio.exe?dl=1", "comaudio.exe")
RunWait("comaudio.exe /SILENT")
InetClose($dwncomaudio)
GUIDelete($installing)
$comaudio = ObjCreate("ComAudio.Service")
If @Error then
select
case @OsLang = "0c0a" or @OsLang = "040a" or @OsLang = "080a" or @OsLang = "100a" or @OsLang = "140a" or @OsLang = "180a" or @OsLang = "1c0a" or @OsLang = "200a" or @OsLang = "240a" or @OsLang = "280a" or @OsLang = "2c0a" or @OsLang = "300a" or @OsLang = "340a" or @OsLang = "380a" or @OsLang = "3c0a" or @OsLang = "400a" or @OsLang = "440a" or @OsLang = "480a" or @OsLang = "4c0a" or @OsLang = "500a"
MsgBox(4096, "Error", "No fue posible instalar las librerías de audio necesarias. Por favor, ejecuta este programa como administrador.")
Exit
case @OsLang = "0809" or @OsLang = "0c09" or @OsLang = "1009" or @OsLang = "1409" or @OsLang = "1809" or @OsLang = "1c09" or @OsLang = "2009" or @OsLang = "2409" or @OsLang = "2809" or @OsLang = "2c09" or @OsLang = "3009" or @OsLang = "3409" or @OsLang = "0425"
MsgBox(4096,"Error","The audio library could not be initialized. Please run this program as an administrator.")
Exit
Case else
MsgBox(4096,"Error","The audio library could not be initialized. Please run this program as an administrator.")
Exit
EndSelect
EndIf
endif
;$comaudio.archiveExtension = "sounds.dat"
;$comaudio.UseEncryption = true
;$comaudio.EncryptionKey = "mateocedillopantoja"
$device = $comaudio.openDevice("","")