;alarm v0.4.
#include <ComboConstants.au3>
#include <Date.au3>
#include <guiConstantsEx.au3>
#include "soundlib.au3"
#include-once
global $contador=0
global $gui_Main
global $sndList = ""
global $repeat = 0
global $alarmrepeat = ""
global $notify = 0
global $showwindow=0
global $Minutetopost = ""
global $CHECKBOX = $device.opensound (@scriptDir &"\sounds/CHECKBOX.ogg", 0)
global $CHECKBOX2 = $device.opensound (@scriptDir &"\sounds/CHECKBOX_unchecked.ogg", 0)
global $scrollsound = $device.opensound (@scriptDir &"\sounds/scrollTop.ogg", 0)
func alarma()
GUISetState(@SW_hide, $gui_Main)
speaking(translate($idioma, "Loading gui..."))
;@Danyfirex - en esta funcion cambie muchas posiciones de controles asi que no anote todo lo que se cambio pero todos los controles estan en posiciones
global $guialarm = GuiCreate(translate($idioma, "new alarm..."))
GUISetBkColor(0x000000, $guialarm)
$lb1 = GUICtrlCreateLabel(translate($idioma, "Alarm name"), 20, 20, 120, 20)
global $alarmname = GUICtrlCreateInput("", 120, 20-5, 120, 20)
$lb2 = GUICtrlCreateLabel(translate($idioma, "Description (optional)"), 20, 20+30, 120, 20)
global $aDesc = GUICtrlCreateInput("", 130, 20+30-5, 120, 20)
$lb3 = GUICtrlCreateLabel(translate($idioma, "Select alarm hour"), 20, 80, 150, 20)
global $alarmhour = GUICtrlCreateInput(@hour, 160, 80-5, 50, 20)
$lb4 = GUICtrlCreateLabel(translate($idioma, "Select minute"), 20, 120, 120, 20)
global $alarmmt = GUICtrlCreateInput("", 120, 120-5, 50, 20)
$lb5 = GUICtrlCreateLabel(translate($idioma, "Select second"), 20, 150, 120, 20)
global $alarmsec = GUICtrlCreateInput("", 130, 150-5, 50, 20)
global $idRepeat = GUICtrlCreateCheckbox(translate($idioma, "Repeat"), 20, 170, 100, 25)
GUICtrlSetOnEvent(-1, "showrepetitiondays")
global $idrpt1 = GUICtrlCreateCheckbox(translate($idioma, "Monday"), 20, 190 +(0*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $idrpt2 = GUICtrlCreateCheckbox(translate($idioma, "Tuesday"), 20, 190 +(1*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $idrpt3 = GUICtrlCreateCheckbox(translate($idioma, "Wednesday"), 20,  190 +(2*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $idrpt4 = GUICtrlCreateCheckbox(translate($idioma, "Thursday"), 20,  190 +(3*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $idrpt5 = GUICtrlCreateCheckbox(translate($idioma, "Friday"), 20,  190 +(4*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $idrpt6 = GUICtrlCreateCheckbox(translate($idioma, "Saturday"), 20,  190 +(5*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $idrpt7 = GUICtrlCreateCheckbox(translate($idioma, "Sunday"), 20,  190 +(6*20), 100, 25)
GUICtrlSetOnEvent(-1, "configalarm")
GUICtrlSetState(-1, $GUI_HIDE)
global $lb6 = GUICtrlCreateLabel(translate($idioma, "Alarm sound, currently") &" " &IniRead(@scriptDir &"\config\config.st", "Alarm", "Sound", ""), 20, 340, 150, 40)
global $idSoundlist = GUICtrlCreateCombo("", 180, 340-5, 100, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetOnEvent(-1, "sounds")
$BTNRec = GUICtrlCreateButton(translate($idioma, "Record alarm"), 180, 360, 100, 20)
GUICtrlSetOnEvent(-1, "recordalarm")
global $idnotifyme = GUICtrlCreateCheckbox(translate($idioma, "Notify me when the alarm goes off"), 20, 360+20, 250, 20)
GUICtrlSetOnEvent(-1, "Configalarm")
global $idshowwindow = GUICtrlCreateCheckbox(translate($idioma, "Show dialog window"), 20, 360+40, 250, 25)
GUICtrlSetOnEvent(-1, "Configalarm")
$lb7 = GUICtrlCreateLabel(translate($idioma, "Duration to postpone"), 20, 430, 150, 20)
global $idMinutetopost = GUICtrlCreateCombo(translate($idioma, "1 minute"), 160, 430-5, 100, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idMinutetopost, translate($idioma, "5 minutes|10 minutes|15 minutes|30 minutes"))
global $BTNSabe = GUICtrlCreateButton(translate($idioma, "OK"), 60, 460, 100, 30)
GUICtrlSetOnEvent(-1, "startalarm")
global $idCancelalarm = GUICtrlCreateButton(translate($idioma, "Cancel and back"), 200, 460, 100, 30)
GUICtrlSetOnEvent(-1, "startalarm")
GUISetState(@SW_SHOW)
;GUISetOnEvent($GUI_EVENT_CLOSE, "startalarm")
$soundList = FileReadToArray(@TempDir &"\sounds\AlarmList.txt")
$Contarlineas = @extended
If @error Then
MsgBox(0, translate($idioma, "error"), translate($idioma, "There was an error reading sound List. Reason: ") &" " &@error)
Else
speaking(translate($idioma, "Loading sounds..."))
For $i = 0 To $contarlineas - 1
GUICtrlSetData($idSoundlist, $Soundlist[$i])
Next
speaking(translate($idioma, "Loaded sounds"))
EndIf
EndFunc
func showrepetitiondays()
If _IsChecked_audio($idRepeat) Then
$repeat=1
GUICtrlSetState($idrpt1, $GUI_SHOW)
GUICtrlSetState($idrpt2, $GUI_SHOW)
GUICtrlSetState($idrpt3, $GUI_SHOW)
GUICtrlSetState($idrpt4, $GUI_SHOW)
GUICtrlSetState($idrpt5, $GUI_SHOW)
GUICtrlSetState($idrpt6, $GUI_SHOW)
GUICtrlSetState($idrpt7, $GUI_SHOW)
else
$repeat=0
GUICtrlSetState($idrpt1, $GUI_HIDE)
GUICtrlSetState($idrpt2, $GUI_HIDE)
GUICtrlSetState($idrpt3, $GUI_HIDE)
GUICtrlSetState($idrpt4, $GUI_HIDE)
GUICtrlSetState($idrpt5, $GUI_HIDE)
GUICtrlSetState($idrpt6, $GUI_HIDE)
GUICtrlSetState($idrpt7, $GUI_HIDE)
$CHECKBOX2.play
EndIf
EndFunc
func sounds()
$sndlist = GUICtrlRead($idSoundlist)
$thisSonido = $device.opensound(@scriptDir &$sndlist, 0)
$thisSonido.play
if @error then
Msgbox(0, translate($idioma, "Error"), translate($idioma, "Impossible to play"))
EndIf
IniWrite(@scriptDir &"\config\config.st", "Alarm", "Sound", $sndlist)
GUICtrlSetData($lb6, translate($idioma, "Alarm sound, currently") &" " &$sndlist)
sleep(400)
SoundFade($thisSonido)
EndFunc
func configalarm()
If _IsChecked_audio($idrpt1) Then
$alarmrepeat=1
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idrpt2) Then
$alarmrepeat=2
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idrpt3) Then
$alarmrepeat=3
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idrpt4) Then
$alarmrepeat=4
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idrpt5) Then
$alarmrepeat=5
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idrpt6) Then
$alarmrepeat=6
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idrpt7) Then
$alarmrepeat=7
Else
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idnotifyme) Then
$notify=1
Else
$notify=0
$CHECKBOX2.play
EndIf
If _IsChecked_audio($idshowwindow) Then
$showwindow=1
Else
$showwindow=0
$CHECKBOX2.play
EndIf
EndFunc
func startalarm()
select
Case @GUI_CtrlId = $BTNSabe
$contador = $contador +1
Global $namealarm = GUICtrlRead($alarmname)
if $namealarm ="" then $namealarm = "Untitled"
Global $descalarm = GUICtrlRead($aDesc)
if $descalarm ="" then $descalarm = "Untitled"
Global $houralarm = GUICtrlRead($alarmhour)
Global $minalarm = GUICtrlRead($alarmmt)
Global $secalarm = GUICtrlRead($alarmsec)
if $secalarm ="" then $secalarm = "00"
Global $postalarm = GUICtrlRead($idMinutetopost)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Mode", "alarm")
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Name", $alarmname)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Description", $descalarm)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Hour", $houralarm)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Minute", $minalarm)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Second", $secalarm)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "time", $postalarm)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Sound", $sndlist)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Repeat", $repeat)
if $repeat= "1" then IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "repeat every", $alarmrepeat)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Notify", $notify)
IniWrite(@scriptDir &"\config\" &$namealarm &".ini", "settings", "Show window", $showwindow)
msgbox(64, translate($idioma, "Done"), "Your alarm has been created and will be executed at " &$houralarm &"hours, " &$minalarm &"minutes, " &$secalarm &"seconds.")
GUISetState(@SW_show, $gui_Main)
guiDelete($guialarm)
alarmfunc()
Case @GUI_CtrlId = $idCancelalarm
$question = msgBox(4, translate($idioma, "Question"), translate($idioma, "Are you sure you want to exit? Your alarm will not be saved and these changes will be lost."))
If $question == 6 Then
$enCurso="0"
guiDelete($guialarm)
GUISetState(@SW_SHOW, $gui_Main)
EndIf
EndSelect
EndFunc
func recordalarm()
if not FileExists(@scriptDir &"\recordings") then
DirCreate(@ScriptDir &"\recordings")
EndIf
$recInit = _mediacreate(6)
MsgBox(48, Translate($idioma, "Record alarm"), Translate($idioma, "The alarm recording will last approximately 10 seconds or less. when you're ready, hit accept to start recording."))
_mediarecord($recInit)
MsgBox(48, Translate($idioma, "Record alarm"), Translate($idioma, "This dialog disappears in 10 seconds. Press OK to stop and create an alarm for less time."), 10)
_mediastop($recInit)
MsgBox(48, Translate($idioma, "Done"), Translate($idioma, "Recording finished"))
$recresult="alarm_" &@username &"_" &@year &@mon &@MDAY &"_" &@hour &@min &@SEC &".wav"
_mediasave($recInit, @scriptDir & "\recordings\" &$recresult)
EndFunc
func alarmfunc()
While 1
if _NowTime() = $houralarm & ":" &$minalarm & ":" &$secalarm then
;speaking("It's time")
if $sndlist = "" then
beepalarm()
else
$sAlarm = $device.opensound(@scriptDir &$sndList, 0)
$sAlarm.play
if $sAlarm.playing = 1 then $sAlarm.reset
$sAlarm.repeating=1
EndIf
if $notify = 1 then
TrayTip(translate($idioma, "Alarm") &"! " &$alarmname, translate($idioma, "It is") &" " &_NowTime() & ". "&$descalarm, 0, $TIP_ICONASTERISK)
Speaking(translate($idioma, "Alarm") &"! " &$alarmname &", " &translate($idioma, "It is") &" " &_NowTime() & ". "&$descalarm)
$notify = 0
Else
EndIF
if $showwindow = 1 then
global $aGui = guicreate(translate($idioma, "Alarm") &"!")
$textlabel = GUICtrlCreateLabel($alarmname &@crlf &translate($idioma, "It is") &" " &_NowTime(), 10, 50, 150, 20)
$discardbtn = GuiCtrlCreateButton(translate($idioma, "discard"), 130, 50, 100, 20)
GuiCtrlSetOnEvent(-1, "discalarm")
$ready = GuiCtrlCreateButton(translate($idioma, "Postpone"), 130, 110, 100, 20)
GuiCtrlSetOnEvent(-1, "postpone")
$ready = GuiCtrlCreateButton(translate($idioma, "Done"), 130, 185, 100, 20)
GuiCtrlSetOnEvent(-1, "alarmcompleted")
GuiSetState(@Sw_SHOW)
$showwindow = 1
else
If _IsPressed($control) And _IsPressed($shift) And _IsPressed($d) Then
discalarm()
While _IsPressed($control) And _IsPressed($c)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($shift) And _IsPressed($p) Then
postpone()
While _IsPressed($control) And _IsPressed($c)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($shift) And _IsPressed($s) Then
alarmcompleted()
While _IsPressed($control) And _IsPressed($c)
Sleep(100)
WEnd
EndIf
EndIF
sleep(10)
EndIf
Wend
EndFunc