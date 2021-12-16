;These are the functions and the respective code for the options menu. Each of the functions understand by themselves what they are for.
#include <GuiConstantsEx.au3>
global $errorsound = $device.opensound (@scriptDir &"\sounds/error.ogg", 0)
Func opciones()
;@Danyfirex - en esta funcion cambie muchas posiciones de controles asi que no anote todo lo que se cambio pero todos los controles estan en posiciones
If FileExists(@StartupDir & "\Mini Calendar.lnk") Then
global $ifstartWindows = "yes"
Else
global $ifstartWindows = "no"
EndIf
global $ifsavesettings = IniRead(@scriptDir &"\config\config.st", "General settings", "Save settings", "")
global $ifsavelogs = IniRead(@scriptDir &"\config\config.st", "General settings", "Save logs", "")
global $ifcheckupds = IniRead(@scriptDir &"\config\config.st", "General settings", "Check updates", "")
global $ifMinimize = IniRead(@scriptDir &"\config\config.st", "General settings", "Minimize", "")
global $ifwritingsound = IniRead(@scriptDir &"\config\config.st", "General settings", "Play sounds when typing", "")
global $ifSpeedup = IniRead(@scriptDir &"\config\config.st", "General settings", "Speed up GUI controls", "")
global $guioptions2 = GuiCreate(translate($idioma, "Options menu"))
global $idStartWindows = GUICtrlCreateCheckbox(translate($idioma, "Start Mini Calendar and scheduler With Windows"), 50, 100 +(0*25), 350, 25)
GUICtrlSetOnEvent(-1, "iniciarconwindows")
if $ifstartWindows = "yes" then GUICtrlSetState($idStartWindows, $GUI_UNCHECKED)
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
global $idspeedup = GUICtrlCreateCheckbox(translate($idioma, "Accelerate graphical interface controls"), 50, 100 +(6*25), 350, 25)
GUICtrlSetOnEvent(-1, "acelerarinterfaz")
if $ifspeedup = "yes" then GUICtrlSetState($idspeedup, $GUI_CHECKED)
global $voice_Label = GUICtrlCreateLabel(translate($idioma, "Select text-to-speech output"), 50, 110 +(7*25), 200, 25)
global $idChangevoice1 = GUICtrlCreateCombo("Sapi", 230, 110 +(7*25)-5, 100, 30, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
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
if not @compiled then
$ifstartWindows = "no"
$errorsound.play
MSgBox(16, translate($idioma, "Error"), translate($idioma, "It seems that you are running the source code version, which does not allow the creation of the shortcut. Please compile the program."))
GUICtrlSetState($idStartWindows, $GUI_CHECKED)
Else
$ifstartWindows = "Yes"
FileCreateShortcut(@AutoItExe, @startupDir &"\Mini Calendar.lnk", "", "", "", "", "")
EndIf
If Not @error and $ifstartWindows = "yes" Then
$restartmsg = Msgbox(4, translate($idioma, "Start created"), translate($idioma, "Please restart your pc for the changes to take effect. Close the windows of this application that you are using and then proceed to restart. Would you like to restart now?"))
select
case $restartmsg = "6"
Shutdown($SD_REBOOT)
if @error then
$errorsound.play
MsgBox(16, translate($idioma, "Error"), translate($idioma, "The system could not be rebooted. You will have to do it manually."))
exitpersonaliced()
Else
Speaking(translate($idioma, "Restarting..."))
EndIf
Case else
MsgBox(48, "OK", "but you will have to do it later.")
EndSelect
Else
$errorsound.play
MSGBox(0, translate($idioma, "Error"), translate($idioma, "The shortcut could not be created... You can try the following:") &@crlf &translate($idioma, "Method 1: Run the program as administrator, open the menu, go to options and check the box you just checked.") &@crlf &translate($idioma, "Method 2: There may be other actions in progress that make it necessary to restart the pc. You should restart it, open this program and check this box again."))
EndIf
Else
$CHECKBOX2.play
$siseestaeliminando = FileDelete(@startupDir &"\Mini Calendar.lnk")
if $siseestaeliminando = 0 then
$errorsound.play
MSgBox(16, translate($idioma, "Error"), translate($idioma, "the shortcut cannot be deleted or has not been created yet."))
EndIf
EndIf
EndFunc
func guardarlogs()
If _IsChecked_audio($idSavelogs) Then
IniWrite(@scriptDir &"\config\config.st", "General settings", "Save logs", "Yes")
Else
$CHECKBOX2.play
IniWrite(@scriptDir &"\config\config.st", "General settings", "Save logs", "No")
EndIf
EndFunc
func guardaropciones()
If _IsChecked_audio($idSavesettings) Then
IniWrite(@scriptDir &"\config\config.st", "General settings", "Save settings", "Yes")
Else
$CHECKBOX2.play
IniWrite(@scriptDir &"\config\config.st", "General settings", "Save settings", "No")
EndIf
EndFunc
func buscaractualizaciones()
If _IsChecked_audio($idCheckUpds) Then
IniWrite(@scriptDir &"\config\config.st", "General settings", "Check updates", "Yes")
Else
$updquest = MsgBox(4, translate($idioma, "question"), translate($idioma, "By uncheck this option you will not receive updates or messages of the day. We recommend that you keep up to date with the latest version soon. Do you want to continue?"))
if $updquest = "6" then
$CHECKBOX2.play
IniWrite(@scriptDir &"\config\config.st", "General settings", "Check updates", "No")
else
GUICtrlSetState($idcheckupds, $GUI_CHECKED)
EndIf
EndIf
EndFunc
func minimizaralabandeja()
If _IsChecked_audio($idMinimize) Then
IniWrite(@scriptDir &"\config\config.st", "General settings", "Minimize", "Yes")
Else
$CHECKBOX2.play
IniWrite(@scriptDir &"\config\config.st", "General settings", "Minimize", "No")
EndIf
EndFunc
func reproducir()
If _IsChecked_audio($idPlaysounds) Then
IniWrite(@scriptDir &"\config\config.st", "General settings", "Play sounds when typing", "Yes")
Else
$CHECKBOX2.play
IniWrite(@scriptDir &"\config\config.st", "General settings", "Play sounds when typing", "No")
EndIf
EndFunc
func cambiarvoz()
;NO DISPONIBLE.
$sComboRead = GUICtrlRead($idchangevoice1)
IniWrite(@scriptDir &"\Config\config.st", "Accessibility", "Speak Whit", $sComboRead)
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
$ifisdeleting = FileDelete(@ScriptDir & "\config\config.st")
If $ifisdeleting = 0 then
$errorsound.play
MSgBox(16, "Error", "Cannot delete configs file.")
Else
MsgBox(48, translate($idioma, "Information"), translate($idioma, "Please restart Mini Calendar for the changes to take effect."))
Exitpersonaliced()
EndIf
EndSelect
EndFunc
func acelerarinterfaz()
If _IsChecked_audio($idspeedup) Then
$accquest = MsgBox(4, translate($idioma, "Accelerate graphical interface controls"), translate($idioma, "Enabling this option might increase your CPU usage, but it improves the performance of the GUI controls throughout the program, especially for the visually impaired. Are you really sure you want to activate acceleration?"))
if $accquest = "6" then
GUICtrlSetState($idcheckupds, $GUI_CHECKED)
$CHECKBOX.play
IniWrite(@scriptDir &"\config\config.st", "General settings", "Speed up GUI controls", "yes")
MsgBox(48, translate($idioma, "Information"), translate($idioma, "Please restart Mini Calendar for the changes to take effect."))
Exitpersonaliced()
else
IniWrite(@scriptDir &"\config\config.st", "General settings", "Speed up GUI controls", "no")
GUICtrlSetState($idcheckupds, $GUI_UNCHECKED)
EndIf
else
IniWrite(@scriptDir &"\config\config.st", "General settings", "Speed up GUI controls", "no")
EndIf
EndFunc