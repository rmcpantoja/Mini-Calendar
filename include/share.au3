;This is a small UDF that will allow us to share something to different social networks.
;Note: This works only if the OnEventMode is enabled and if a GUI is in progress with a while loop.
;Author: Mateo Cedillo.
#include <GuiConstantsEx.au3>
#include "translator.au3"
#include-once
$textToSend = ""
$UrlToShare = ""
func share($textToSend, $UrlToShare)
$shmessage=translate($idioma, "Share on") &" "
global $shareGui = Guicreate(translate($idioma, "Share with..."))
global $idWhatsapp = GUICtrlCreateButton($shmessage &"WhatsApp", 50, 50, 50, 25)
GuiCtrlSetOnEvent(-1, "ShareHanddler")
global $idFacebook = GUICtrlCreateButton($shmessage &"Facebook", 120, 50, 50, 25)
GuiCtrlSetOnEvent(-1, "ShareHanddler")
global $idSkype = GUICtrlCreateButton($shmessage &"Skype", 155, 50, 50, 25)
GuiCtrlSetOnEvent(-1, "ShareHanddler")
global $idBack = GUICtrlCreateButton(translate($idioma, "Back"), 200, 50, 70, 25)
GuiCtrlSetOnEvent(-1, "ShareHanddler")
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseShDialog")
endFunc
func ShareHanddler()
select
Case @GUI_CtrlId = $idWhatsapp
ShellExecute("https://api.whatsapp.com/send?text= " &$textToSend &@crlf &$UrlToShare)
if @error then
Return 0
EndIf
Case @GUI_CtrlId = $idFacebook
ShellExecute("https://www.facebook.com/sharer.php?u=" &$URLToShare &"&t=" &$TextToSend)
if @error then
Return 0
EndIf
Case @GUI_CtrlId = $idSkype
ShellExecute("https://web.skype.com/share?url=" &$URLToShare &"&lang=en-US=&source=jetpack")
if @error then
Return 0
EndIf
;Case @GUI_CtrlId = $idBack
;CloseShDialog()
EndSelect
CloseShDialog()
EndFunc
Func CloseShDialog()
GuiDelete($shareGui)
EndFunc