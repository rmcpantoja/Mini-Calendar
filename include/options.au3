;These are the functions and the respective code for the options menu. Each of the functions understand by themselves what they are for.
Func opciones()
;@Danyfirex - en esta funcion cambie muchas posiciones de controles asi que no anote todo lo que se cambio pero todos los controles estan en posiciones
global $directorio = "c:\users\" &@username &"\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
Global $rutadelarchivo = $directorio & "\Mini Calendar.nlk"
global $ifsavesettings = IniRead("config\config.st", "General settings", "Save settings", "")
global $ifsavelogs = IniRead("config\config.st", "General settings", "Save logs", "")
global $ifcheckupds = IniRead("config\config.st", "General settings", "Check updates", "")
global $ifMinimize = IniRead("config\config.st", "General settings", "Minimize", "")
global $ifwritingsound = IniRead("config\config.st", "General settings", "Play sounds when typing", "")
global $guioptions2 = GuiCreate(translate($idioma, "Options menu"))
global $idStartWindows = GUICtrlCreateCheckbox(translate($idioma, "Start Mini Calendar and scheduler With Windows"), 50, 100 +(0*25), 350, 25)
GUICtrlSetOnEvent(-1, "iniciarconwindows")
global $idSavesettings = GUICtrlCreateCheckbox(translate($idioma, "Save options (recommended)"), 50, 100 +(1*25), 350, 25)
GUICtrlSetOnEvent(-1, "guardaropciones")
if $ifsavesettings = "yes" then GUICtrlSetState($idSavesettings, $GUI_CHECKED)
global $idSavelogs = GUICtrlCreateCheckbox(translate($idioma, "Save logs"), 50, 100 +(2*25), 350, 25)
GUICtrlSetOnEvent(-1, "guardarlogs")
if $ifsavelogs = "yes" then GUICtrlSetState($idSavelogs, $GUI_CHECKED)
global $idCheckUpds = GUICtrlCreateCheckbox(translate($idioma, "Check for updates (recommended)"), 50, 100 +(3*25), 350, 25)
GUICtrlSetOnEvent(-1, "buscaractualizaciones")
if $ifcheckupds = "yes" then GUICtrlSetState($idcheckupds, $GUI_CHECKED)
global $idMinimize = GUICtrlCreateCheckbox(translate($idioma, "Move the mini calendar to the system tray"), 50, 100 +(4*25), 350, 25)
GUICtrlSetOnEvent(-1, "minimizaralabandeja")
if $ifminimize = "yes" then GUICtrlSetState($idminimize, $GUI_CHECKED)
global $idPlaysounds = GUICtrlCreateCheckbox(translate($idioma, "Play sounds when typing"), 50, 100 +(5*25), 350, 25)
GUICtrlSetOnEvent(-1, "reproducir")
if $ifwritingsound = "yes" then GUICtrlSetState($idplaysounds, $GUI_CHECKED)
global $voice_Label = GUICtrlCreateLabel(translate($idioma, "Select text-to-speech output"), 50, 110 +(6*25), 200, 25)
global $idChangevoice1 = GUICtrlCreateCombo("Sapi", 230, 110 +(6*25)-5, 100, 30, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idChangevoice1, "NVDA|JAWS")
GUICtrlSetOnEvent(-1, "Cambiarvoz")
$idDeleteconfig = GUICtrlCreateButton(translate($idioma, "clear settings"), 160, 240, 50, 30)
GUICtrlSetOnEvent(-1, "clear")
$idBTN_Close = GUICtrlCreateButton(translate($idioma, "&aply"), 230, 240, 50, 30)
GUICtrlSetOnEvent(-1, "eliminar")
GUISetState(@SW_SHOW)
Local $sComboRead = ""
GUISetOnEvent($GUI_EVENT_CLOSE, "eliminar")
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
func guardarlogs()
If _IsChecked_audio($idSavelogs) Then
IniWrite("config\config.st", "General settings", "Save logs", "Yes")
Else
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Save logs", "No")
EndIf
EndFunc
func guardaropciones()
If _IsChecked_audio($idSavesettings) Then
IniWrite("config\config.st", "General settings", "Save settings", "Yes")
Else
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Save settings", "No")
EndIf
EndFunc
func buscaractualizaciones()
If _IsChecked_audio($idCheckUpds) Then
IniWrite("config\config.st", "General settings", "Check updates", "Yes")
Else
$updquest = MsgBox(4, translate($idioma, "question"), translate($idioma, "By uncheck this option you will not receive updates or messages of the day. We recommend that you keep up to date with the latest version soon. Do you want to continue?"))
if $updquest = "6" then
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Check updates", "No")
else
GUICtrlSetState($idcheckupds, $GUI_CHECKED)
EndIf
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
func reproducir()
If _IsChecked_audio($idPlaysounds) Then
IniWrite("config\config.st", "General settings", "Play sounds when typing", "Yes")
Else
$CHECKBOX2.play
IniWrite("config\config.st", "General settings", "Play sounds when typing", "No")
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
func clear()
$confirmarborrado = MsgBox(4, translate($idioma, "Clear settings"), translate($idioma, "Are you sure?"))
select
case $confirmarborrado = 6
DirRemove(@ScriptDir & "\config", 1)
MsgBox(48, translate($idioma, "Information"), translate($idioma, "Please restart Mini Calendar for the changes to take effect."))
Exitpersonaliced()
EndSelect
EndFunc