Func opciones()
$directorio = "c:\users\" &@username &"\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
Global $rutadelarchivo = $directorio & "\Mini Calendar.nlk"
global $guioptions2 = GuiCreate(translate($idioma, "Options menu"))
global $idStartWindows = GUICtrlCreateCheckbox(translate($idioma, "Start Mini Calendar and scheduler With Windows (beta)"), 50, 100, 20, 25)
GUICtrlSetOnEvent(-1, "iniciarconwindows")
global $idSabesettings = GUICtrlCreateCheckbox(translate($idioma, "Save options (recommended)"), 85, 100, 20, 25)
GUICtrlSetOnEvent(-1, "guardaropciones")
global $idCheckUpds = GUICtrlCreateCheckbox(translate($idioma, "Check for updates (recommended)"), 120, 100, 20, 25)
GUICtrlSetOnEvent(-1, "buscaractualizaciones")
global $idMinimize = GUICtrlCreateCheckbox(translate($idioma, "Move the mini calendar to the system tray"), 145, 100, 20, 25)
GUICtrlSetOnEvent(-1, "minimizaralabandeja")
global $voice_Label = GUICtrlCreateLabel(translate($idioma, "Select text-to-speech output"), 130, 100, 20, 25)
global $idChangevoice1 = GUICtrlCreateCombo("Sapi", 130, 120, 20, 30, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idChangevoice1, "NVDA|JAWS")
GUICtrlSetOnEvent(-1, "Cambiarvoz")
$idBTN_Close = GUICtrlCreateButton(translate($idioma, "close"), 150, 100, 50, 25)
GUICtrlSetOnEvent(-1, "eliminar")
GUISetState(@SW_SHOW)
Local $sComboRead = ""
Opt("GUIOnEventMode",1)
GUISetOnEvent($GUI_EVENT_CLOSE, "eliminar")
;while 1
;Wend
EndFunc
func iniciarconwindows()
If _IsChecked_audio($idStartWindows) Then
FileCreateShortcut(@ScriptFullPath, $rutadelarchivo, "", "", "", "", "")
If Not @error Then
Msgbox(48, translate($idioma, "Start created"), translate($idioma, "Please restart your pc for the changes to take effect. Close the windows of this application that you are using and then proceed to restart."))
Else
MSGBox(0, translate($idioma, "Error"), translate($idioma, "The shortcut could not be created... You can try the following:") &@crlf &translate($idioma, "Method 1: Run the program as administrator, open the menu, go to options and check the box you just checked.") &@crlf &translate($idioma, "Method 2: There may be other actions in progress that make it necessary to restart the pc. You should restart it, open this program and check this box again."))
EndIf
Else
$CHECKBOX2.play
FileDelete($rutadelarchivo)
EndIf
EndFunc
func guardaropciones()
If _IsChecked_audio($idSabesettings) Then
IniWrite("config\config.st", "General settings", "Sabe settings", "Yes")
Else
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Sabe settings", "No")
EndIf
EndFunc
func buscaractualizaciones()
If _IsChecked_audio($idCheckUpds) Then
IniWrite("config\config.st", "General settings", "Check updates", "Yes")
Else
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Check updates", "No")
EndIf
EndFunc
func minimizaralabandeja()
If _IsChecked_audio($idMinimize) Then
IniWrite("config\config.st", "General settings", "Minimize", "Yes")
Else
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Minimize", "No")
EndIf
EndFunc
func cambiarvoz()
;NO DISPONIBLE.
$sComboRead = GUICtrlRead($idchangevoice1)
IniWrite("Config\config.st", "Accessibility", "Speak Whit", $sComboRead)
$scrollsound.play
speaking(translate($idioma, "This is a speech synthesis test"))
EndFunc
func eliminar()
guiDelete($guioptions2)
EndFunc
Func _IsChecked_audio($idControlID)
$CHECKBOX.play
Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc