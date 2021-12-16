#include "share.au3"
Opt("GUIOnEventMode",1)
$idioma = "en"
$gui = GuiCreate("My sharing app")
Local $idShareBTN = GUICtrlCreateButton(translate($idioma, "Share"), 10, 20, 50, 20)
GuiCtrlSetOnEvent(-1, "Shareapp")
Local $idExitbutton = GUICtrlCreateButton(translate($idioma, "E&xit"), 75, 20, 50, 20)
GuiCtrlSetOnEvent(-1, "exitpersonaliced")
GUISetState(@SW_SHOW)
While 1
WEnd
func shareapp()
$shareresult = share(translate($idioma, "Hello! I share with you Mini Calendar, an application for calendar, diary, alarm, clock and much more. Download it here:"), "http://mateocedillo.260mb.net/MC.zip")
;If $shareresult = 0 then MsgBox(16, Translate($idioma, "error"), translate($idioma, "Sharing failed."))
EndFunc
func exitpersonaliced()
Exit
EndFunc