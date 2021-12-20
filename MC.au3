#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=N
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Res_Description=Mini Calendar
#AutoIt3Wrapper_Res_Fileversion=0.5.0.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_ProductName=Mini Calendar
#AutoIt3Wrapper_Res_ProductVersion=0.5.0.0
#AutoIt3Wrapper_Res_CompanyName=MT Programs
#AutoIt3Wrapper_Res_LegalCopyright=© 2018-2021 MT Programs, All rights reserved
;#AutoIt3Wrapper_Res_Language=12298
;#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -v1 -v2 -v3
;#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
;#AutoIt3Wrapper_Run_Tidy=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;Mini Calendar and schedule
; #pragma compile(Icon, C:\Program Files\AutoIt3\Icons\au3.ico)
#pragma compile(UPX, False)
;#pragma compile(Compression, 2)
;#pragma compile(inputboxres, false)
#pragma compile(FileDescription, Mini Calendar)
#pragma compile(ProductName, Mini Calendar)
#pragma compile(ProductVersion, 0.5.0.0)
#pragma compile(Fileversion, 0.5.0.6)
#pragma compile(InternalName, "mateocedillo.Mc")
#pragma compile(LegalCopyright, © 2018-2021 MT Programs, All rights reserved)
#pragma compile(CompanyName, 'MT Programs')
$idioma = iniRead (@scriptDir &"\config\config.st", "General settings", "language", "")
;Set no tray icon.
;#NoTrayIcon
;include
#include "include\alarm.au3"
;#include "include\audio.au3"
#include <AutoItConstants.au3>
#include <ComboConstants.au3>
#include "include\diary.au3"
#include <EditConstants.au3>
#Include<file.au3>
#include <guiConstantsEx.au3>
#include <Inet.au3>
#include <include\kbc.au3>
#INCLUDE "INCLUDE\MEDIA.AU3"
#include <include\menu_nvda.au3>
#include <misc.au3>
#include <include\NVDAControllerClient.au3>
#include "include\options.au3"
#include "include\progress.au3"
#include <include\reader.au3>
#include <include\sapi.au3>
#include "include\share.au3"
#include "include\soundlib.au3"
#include "include\translator.au3"
#include <TrayConstants.au3>
#include "updater.au3"
#include <WindowsConstants.au3>
dircreate(@tempDir &"\sounds")
FileInstall("sounds\Alarmlist.txt", @TempDIR &"\sounds\AlarmList.txt")
FileInstall("sounds\soundlist.txt", @TempDIR &"\sounds\soundlist.txt")
Opt("GUIOnEventMode",1)
$l1 = GUICreate(translate($idioma, "Loading..."))
GUISetState(@SW_SHOW)
global $program_ver = "0.5"
global $ifitisupdate = IniRead(@scriptDir &"\Config\config.st", "General settings", "Check updates", "")
If $ifitisupdate = "" then
IniWrite(@scriptDir &"\Config\config.st", "General settings", "Check updates", "Yes")
$ifitisupdate = "Yes"
else
EndIF
global $ifitisaccelerate = IniRead(@scriptDir &"\Config\config.st", "General settings", "Speed up GUI controls", "")
If $ifitisaccelerate = "" then
IniWrite(@scriptDir &"\Config\config.st", "General settings", "Speed up GUI controls", "No")
$ifitisaccelerate = "No"
else
EndIF
global $soundclose = $device.opensound (@scriptDir &"\sounds/close.ogg", true)
global $open = $device.opensound (@scriptDir &"\sounds/open.ogg", true)
global $radiosound = $device.opensound (@scriptDir &"\sounds/radio.ogg", true)
If FileExists("MCExtract.exe") then
$readinst = iniRead(@scriptDir &"\config\config.st", "update", "Pending installation", "")
select
case $readinst = ""
IniWrite(@scriptDir &"\Config\config.st", "Update", "Pending installation", "not completed")
pendingInstallation()
case else
FileDelete("MCExtract.exe")
endselect
EndIf
If not FileExists("MC.au3") Then
Extractor()
else
comprovar()
endif
func pendinginstallation()
$ifinstallation = iniRead(@scriptDir &"\config\config.st", "update", "Pending installation", "")
if $ifinstallation = "not completed" then
$questupd = msgBox(4, translate($idioma, "pending update"), translate($idioma, "there is a pending update. Do you want to install it right now?"))
If $questupd = 6 Then
IniWrite(@scriptDir &"\Config\config.st", "Update", "Pending installation", "completed")
ShellExecute(@scriptDir &"\MCExtract.exe")
;exitpersonaliced()
endIF
else
FileDelete("MCExtract.exe")
EndIf
EndFunc
Func Extractor()
GUICtrlCreateLabel(translate($idioma, "Extracting sounds..."), 40, 20)
sleep(100)
Local $zip_carpeta = @scriptDir & '\soundsdata.dat'
If FileExists("sounds\*.ogg") then
if @compiled then
msgbox (4096, translate($idioma, "error"), translate($idioma, "Damn thief, stop stealing the sounds!"))
exit
EndIf
comprovar()
endif
If FileExists(@TempDir &"\sounds\*.ogg") then
if @compiled then
;remover esa carpeta
DirRemove(@TempDir & "/sounds", 1)
EndIf
endIf
;desencriptar()
comprovar()
If FileExists($zip_carpeta) Then
;_Zip_UnzipAll($zip_Carpeta, @TempDir, 0)
sleep(50)
GUIDelete($l1)
comprovar()
endIf
GUIDelete($l1)
EndFunc
func comprovar()
if not fileExists ("config") then DirCreate("config")
GUIDelete($l1)
firstlaunch()
EndFunc
func firstlaunch()
global $accessibility = iniRead (@scriptDir &"\config\config.st", "accessibility", "Enable enanced accessibility", "")
select
case $accessibility =""
configure()
Case Else
checkselector()
endselect
endfunc
; The next question is to activate the enhanced accessibility, made exclusively and only for people with disability.
func configure()
$Warning=MsgBox(4, translate($idioma, "Enable enhanced accessibility?"), translate($idioma, "This new Enhanced Accessibility functionality is designed for the visually impaired, in which most of the program interface can be used by voice and keyboard shortcuts. Activate?"))
if $warning == 6 then
IniWrite(@scriptDir &"\config\config.st", "accessibility", "Enable enanced accessibility", "Yes")
else
IniWrite(@scriptDir &"\config\config.st", "accessibility", "Enable enanced accessibility", "No")
endif
global $accessibility = iniRead (@scriptDir &"\config\config.st", "accessibility", "Enable enanced accessibility", "")
checkselector()
endfunc
func checkselector()
global $idioma = iniRead (@scriptDir &"\config\config.st", "General settings", "language", "")
select
case $idioma =""
selector()
case else
checkupd()
endselect
endfunc
;This is the function off language selector menu, the first alternative using the main menu speech.
Func Selector()
local $widthCell,$msg,$iOldOpt
global $langGUI= GUICreate("Language Selection")
global $seleccionado="0"
$widthCell=70
$iOldOpt=Opt("GUICoordMode",$iOldOpt)
$beep = "0"
$busqueda = "0"
dim $langcodes[50]
GUICtrlCreateLabel("Select language:", -1,0)
GUISetBkColor(0x00E0FFFF)
$recolectalosidiomasporfavor = FileFindFirstFile("lng\*.lang")
If $recolectalosidiomasporfavor = -1 Then MsgBox(16, "Fatal error", "We cannot find the language files. Please download the program again...")
Local $Recoleccion = "", $obteniendo = ""
While 1
$beep = $Beep +1
$busqueda = $busqueda +1
$Recoleccion = FileFindNextFile($recolectalosidiomasporfavor)
If @error Then
;MsgBox(16, "Error", "We cannot find the language files or they are corrupted.")
CreateAudioProgress("100")
ExitLoop
EndIf
$splitCode = StringLeft($Recoleccion, 2)
$obteniendo &= GetLanguageName($splitCode) &", " &GetLanguageCode($splitCode) &"|"
$langcodes[$busqueda] = GetLanguageCode($splitcode)
;MSGBox(0, "debug", $langcodes[$busqueda])
CreateAudioProgress($beep)
Sleep(100)
WEnd
GUISetState(@SW_SHOW)
$langcount = StringSplit($obteniendo, "|")
$fix_audiomenu=StringTrimRight($obteniendo, 1)
$configureaccs = iniRead (@scriptDir &"\config\config.st", "accessibility", "Enable enanced accessibility", "")
if $configureaccs ="yes" then
$menu=Reader_create_menu("Please select a language with the up and down arrows and press enter to continue", $fix_audiomenu)
EndIf
if $configureaccs ="no" then
global $Choose = GUICtrlCreateCombo("", 100, 50, 200, 30, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GuiCtrlSetOnEvent(-1, "seleccionar")
GUICtrlSetData($Choose, $obteniendo)
global $idBtn_OK = GUICtrlCreateButton("OK", 155, 50, 70, 30)
GuiCtrlSetOnEvent(-1, "save")
global $idBtn_Close = GUICtrlCreateButton("Close", 180, 50, 70, 30)
GuiCtrlSetOnEvent(-1, "exitpersonaliced")
Global $LEER = ""
while 1
if $seleccionado="1" then
;msgbox(0, "Correct", "We should close this.")
exitloop
EndIf
Wend
GUIDelete($langGui)
checkupd()
endif
if $configureaccs ="yes" then
IniWrite(@scriptDir &"\config\config.st", "General settings", "language", $langcodes[$menu])
if @error then
MSGBox (0, "Error", "Configuration data could not be written.")
Exitpersonaliced()
EndIf
GUIDelete($langGUI)
checkupd()
endif
endFunc
func seleccionar()
global $leer = GUICtrlRead($choose)
global $queidiomaes = StringSplit($leer, ",")
;speaking("Has seleccionado " &StringStripWS($queidiomaes[2], $STR_STRIPLEADING))
EndFunc
func save()
IniWrite(@scriptDir &"\config\config.st", "General settings", "language", StringStripWS($queidiomaes[2], $STR_STRIPLEADING))
$seleccionado="1"
EndFunc
func checkupd()
global $main_u = GUICreate(translate($idioma, "Checking version..."))
GUISetState(@SW_SHOW)
toolTip(translate($idioma, "checking version..."))
if $ifitisupdate = "Yes" then
GUIDelete($main_u)
checkversion()
else
GUIDelete($main_u)
principal()
EndIF
endfunc
func checkversion()
Local $yourexeversion = $program_ver
$fileinfo = InetGet("https://www.dropbox.com/s/hy22d9513bgbih9/MCWeb.dat?dl=1", @tempDir &"\MCWeb.dat")
$latestver = iniRead (@TempDir & "\MCWeb.dat", "updater", "LatestVersion", "")
select
Case $latestVer > $yourexeversion
TTSDialog(translate($idioma, "Update available!") &" " &translate($idioma, "You have the version") &$yourexeversion &translate($idioma, "and is available the") &$latestver, translate($idioma, " press enter to continue, space to repeat information."))
sleep(50)
_Updater_Update("MC.exe", "none", "https://www.dropbox.com/s/e2y1nb0r449wxq4/MCExtract.exe?dl=1")
Case else
checkmotd()
endselect
InetClose($fileinfo)
endfunc
func checkmotd()
;Function to check messaje of the day.
$LMotd = iniRead (@scriptDir &"\config\config.st", "misc", "motdversion", "")
if $LMotd = "" then $LMotd = "1"
$LatestMotd = iniRead (@TempDir & "\MCWeb.dat", "motd", "Latest", "")
select
Case $latestMotd > $lMotd
motdprincipal()
Case $latestMotd = $lMotd
principal()
case else
principal()
endselect
endfunc
func motdprincipal()
$downloadingmotd = GUICreate(translate($idioma, "Downloading message of the day..."))
$mtdlabel = GUICtrlCreateLabel(translate($idioma, "Please wait."), 85, 20)
GUISetState(@SW_SHOW)
$LatestMotd = iniRead (@TempDir & "\MCWeb.dat", "motd", "Latest", "")
$bagground = $device.opensound (@scriptDir &"\sounds/update.ogg", true)
$bagground.play
$bagground.repeating=1
$idioma = iniRead (@scriptDir &"\config\config.st", "General settings", "language", "")
$M_mode = iniRead (@TempDir & "\MCWeb.dat", "motd", "Mode", "")
$ok = iniWrite (@scriptDir &"\config\config.st", "misc", "motdversion", $LatestMotd)
select
case $idioma ="es"
Select
case $m_mode = "text"
if $bagground.playing == "1" then $bagground.stop
$M_text = iniRead (@TempDir & "\MCWeb.dat", "motd", "Text1", "")
TTSDialog($m_text, translate($idioma, " press enter to continue, space to repeat information."))
case $m_mode = "audio"
$iPlaces = 2
$fileurl = "https://drive.google.com/uc?id=1epPH-945GiUFfnHuUcevYk_txhCFFSwt&export=download"
$audio = InetGet($fileurl, @scriptDir &"\motd.ogg", 1, 1)
$fileSize = InetGetSize($FileUrl)
While Not InetGetInfo($audio, 2)
Sleep(50)
$Size = InetGetInfo($audio, 0)
$Percent = Int($Size / $fileSize * 100)
$iSize = $fileSize - $Size
CreateAudioProgress(int($percent))
WEnd
CreateAudioProgress("100")
InetClose($audio)
sleep(100)
GuiCtrlSetData($mtdlabel, translate($idioma, "Playing audio..."))
if $bagground.playing == "1" then $bagground.stop
$comaudio.UseEncryption = false
$comaudio.EncryptionKey = ""
$motd = $device.opensound(@scriptDir &"\motd.ogg", 0)
$motd.play
While $motd.playing = 1
sleep(10)
Wend
$comaudio.UseEncryption = true
$comaudio.EncryptionKey = "superpollo"
EndSelect
case $idioma ="en"
if $bagground.playing == "1" then $bagground.stop
$M_text = iniRead (@TempDir & "\MCWeb.dat", "motd", "Text2", "")
TTSDialog($m_text, translate($idioma, " press enter to continue, space to repeat information."))
endselect
If @Compiled Then FileDelete(@tempDir & "\MCWeb.dat")
GUIDelete($downloadingmotd)
endfunc
principal()
func principal()
ToolTip("")   ;@Danyfirex  agregada para eliminar el tooltip que deja la ventana verificando version
$idioma = iniRead (@scriptDir &"\config\config.st", "General settings", "language", "")
$open.play
global $Gui_main = guicreate("Mini calendar " &$program_ver)
HotKeySet("{F1}", "playhelp")
global $programname="Mini Calendar"
global $recordar1=translate($idioma, "Scheduled schedule")
$recuerdaa = Random(2, 9, 1)
select
case $recuerdaa = 2
global $recuerda = translate($idioma, "We remind you what you have to do") &" "
case $recuerdaa = 3
global $recuerda = translate($idioma, "Remember that you have an schedule programmed right now.") &" "
case $recuerdaa = 4
global $recuerda = translate($idioma, "Get ready to start your daily routines on the right foot.")
case $recuerdaa = 5
global $recuerda = translate($idioma, "It's time to do this activity")
case $recuerdaa = 6
global $recuerda = translate($idioma, "Good cheer, good luck and good vibes for everything you propose to do")
case $recuerdaa = 7
global $recuerda = translate($idioma, "Let's hope that the next activity you do is a success")
case $recuerdaa = 8
global $recuerda = translate($idioma, "It is time to leave the break and resume your day with the following activity:")
case $recuerdaa = 9
global $recuerda = translate($idioma, "Good luck for this, ") &@username
EndSelect
$okmessaje="OK"
Local $idmc = GUICtrlCreateMenu($programname)
Local $idschmenu = GUICtrlCreateMenu(translate($idioma, "Schedules"), $idmc)
Local $idAgendaitem = GUICtrlCreateMenuItem(translate($idioma, "Schedule..."), $idschmenu)
GUICtrlSetOnEvent(-1, "agendar")
Local $idmschitem = GUICtrlCreateMenuItem(translate($idioma, "Manage schedules..."), $idschmenu)
GUICtrlSetOnEvent(-1, "administrar")
Local $idroutineitem = GUICtrlCreateMenuItem(translate($idioma, "Create my daily routine"), $idschmenu)
GUICtrlSetOnEvent(-1, "crearrutina")
Local $idAlarmenu = GUICtrlCreateMenu(translate($idioma, "Alarm"), $idmc)
Local $idAlarmitem = GUICtrlCreateMenuItem(translate($idioma, "new alarm..."), $idAlarmenu)
GUICtrlSetOnEvent(-1, "alarma")
Local $idAlarmitem2 = GUICtrlCreateMenuItem(translate($idioma, "Manage alarms"), $idAlarmenu)
;GUICtrlSetOnEvent(-1, "managealarms")
Local $iddiarymenu = GUICtrlCreateMenu(translate($idioma, "diary"), $idmc)
Local $idDiary1 = GUICtrlCreateMenuItem(translate($idioma, "New diary..."), $iddiarymenu)
GUICtrlSetOnEvent(-1, "diario")
Local $idDiary2 = GUICtrlCreateMenuItem(translate($idioma, "manage diaries..."), $iddiarymenu)
GUICtrlSetOnEvent(-1, "gestionadiario")
Local $clockmenu = GUICtrlCreateMenu(translate($idioma, "Clock..."), $idmc)
Local $clock = GUICtrlCreateMenuItem(translate($idioma, "Run Clock ..."), $clockmenu)
GUICtrlSetOnEvent(-1, "runclock")
Local $clockst = GUICtrlCreateMenuItem(translate($idioma, "Clock Settings..."), $clockmenu)
;GUICtrlSetOnEvent(-1, "clockst")
Local $clocksp = GUICtrlCreateMenuItem(translate($idioma, "Speak the current time"), $clockmenu)
;GUICtrlSetOnEvent(-1, "clocksp")
Local $idOptionsitem = GUICtrlCreateMenuItem(translate($idioma, "Mini Calendar Settings..."), $idmc)
GUICtrlSetOnEvent(-1, "Opciones")
Local $idExititem = GUICtrlCreateMenuItem(translate($idioma, "Exit"), $idmc)
GUICtrlSetOnEvent(-1, "exitpersonaliced")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
Local $idHelpmenu = GUICtrlCreateMenu(translate($idioma, "Help"))
Local $idHelpitema = GUICtrlCreateMenuItem(translate($idioma, "About Mini Calendar"), $idHelpmenu)
GUICtrlSetOnEvent(-1, "ayuda")
Local $idHelpitemb = GUICtrlCreateMenuItem(translate($idioma, "Visit website"), $idHelpmenu)
GUICtrlSetOnEvent(-1, "WEBSITE")
Local $idHelpitemc = GUICtrlCreateMenuItem(translate($idioma, "&User manual"), $idHelpmenu)
GUICtrlSetOnEvent(-1, "Playhelp")
Local $idChanges = GUICtrlCreateMenuItem(translate($idioma, "Changes"), $idHelpmenu)
GUICtrlSetOnEvent(-1, "readchanges2")
local $idBGR = GUICtrlCreateMenuItem(translate($idioma, "Errors and suggestions"), $idHelpmenu)
GUICtrlSetOnEvent(-1, "Report")
local $idBGR2 = GUICtrlCreateMenuItem(translate($idioma, "Errors and suggestions (GitHub)"), $idHelpmenu)
GUICtrlSetOnEvent(-1, "newIssue")
;GUICtrlCreateMenuItem("", $idmc, 2)
;GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel(translate($idioma, "Open the menu or explore the following options:"), 20, 50) ;@Danyfirex - Pasando solo "x" y "y" el label obtiene el tamaño necesario para vizualizar el texto)
GUICtrlSetState(-1, $GUI_FOCUS)
Local $idMenubtn = GUICtrlCreateButton(translate($idioma, "Open menu"), 20, 50 + (1 * 40), 100, 30) ;@Danyfirex - Cambio el "x" por 20 y "y" por 50 + (1 * 40) y el ancho y alto del boton por 100x30 que es un tamaño muy visible en cualquier resolucion
GuiCtrlSetOnEvent(-1, "openmenu")
Local $idManualbutton = GUICtrlCreateButton(translate($idioma, "&User manual"), 20, 50 + (2 * 40), 100, 30) ;@Danyfirex - Cambio el "x" por 20 y "y" por 50 + (2 * 40) y el ancho y alto del boton por 100x30
GuiCtrlSetOnEvent(-1, "playhelp")
Local $idChangesbutton = GUICtrlCreateButton(translate($idioma, "Changes"), 20, 50 + (3 * 40), 100, 30) ;@Danyfirex - Cambio el "x" por 20 y "y" por 50 + (3 * 40) y el ancho y alto del boton por 100x30
GuiCtrlSetOnEvent(-1, "readchanges2")
Local $idGithubBTN = GUICtrlCreateButton("Github", 20, 50 + (4 * 40), 100, 30) ;@Danyfirex - Cambio el "x" por 20 y "y" por 50 + (4 * 40) y el ancho y alto del boton por 100x30
GuiCtrlSetOnEvent(-1, "github")
Local $idShareBTN = GUICtrlCreateButton(translate($idioma, "Share"), 20, 50 + (5 * 40), 100, 30) ;New button
GuiCtrlSetOnEvent(-1, "Shareapp")
Local $idExitbutton = GUICtrlCreateButton(translate($idioma, "E&xit"), 20, 50 + (6 * 40), 100, 30) ;@Danyfirex - Cambio el "x" por 20 y "y" por 50 + (5 * 40) y el ancho y alto del boton por 100x30
GuiCtrlSetOnEvent(-1, "exitpersonaliced")
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "exitpersonaliced")  ;@Danyfirex  agregado para poder cerrar la ventana tambien con el boton superior X arriba a la derecha
While 1
if $ifitisaccelerate = "no" then sleep(10)
WEnd
EndFunc
func openmenu()
Send("{alt}")
EndFunc
func github()
ShellExecute("https://github.com/rmcpantoja/")
EndFunc
Func Website()
ShellExecute("http://mateocedillo.260mb.net/")
EndFunc
func shareapp()
$shareresult = share(translate($idioma, "Hello! I share with you Mini Calendar, an application for calendar, diary, alarm, clock and much more. Download it here:"), "http://mateocedillo.260mb.net/MC.zip")
;If $shareresult = 0 then MsgBox(16, Translate($idioma, "error"), translate($idioma, "Sharing failed."))
EndFunc
Func ayuda()
MsgBox(0, translate($idioma, "About..."), translate($idioma, "Mini Calendar") &", " &translate($idioma, "Version") &" " &$program_ver &", " &translate($idioma, "mini calendar and scheduler for Windows. program for schedule, alarm, calendar and diary. 2018-2021 MT programs."))
EndFunc
func playhelp()
Local $manualdoc = "documentation\" &$idioma &"\manual.txt"
global $DocOpen = FileOpen($manualdoc, $FO_READ)
if $accessibility = "yes" then
speaking(translate($idioma, "Opening..."))
else
ToolTip(translate($idioma, "Opening..."))
Endif
sleep(50)
If $DocOpen = -1 Then MsgBox($MB_SYSTEMMODAL, translate($idioma, "error"), translate($idioma, "An error occurred when reading the file."))
Local $openned = FileRead($DocOpen)
if $accessibility = "no" then ToolTip("")
global $manualwindow = GUICreate(translate($idioma, "User manual"))  ;@Danyfirex hacer la variable $manualwindow global para poder cerrar la interface
Local $idMyedit = GUICtrlCreateEdit($openned, 5, 5, 390, 360, BitOR($WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))  ;@Danyfirex Arreglado Scroll y  Cambio tamaño para hacer el edit casi del tamaño de la interfaz que por defecto es de 400x400 dejando espacion para colocar el boton cerrar
Local $idExitBtn2 = GUICtrlCreateButton(translate($idioma, "Close"), 100, 370, 150, 30) ;@Danyfirex  colocar debajo del edit box
GuiCtrlSetOnEvent(-1, "delete") ;@Danyfirex GUICtrlSetOnEvent not permite pasar functiones con parametros agregada la funcion
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "delete")  ;@Danyfirex  agregado para poder cerrar la ventana tambien con el boton superior X arriba a la derecha
EndFunc
func delete()
FileClose($DocOpen)
GUIDelete($manualwindow)
EndFunc
func exitpersonaliced()
;This custom exit function is used to delete some files when exiting the program. 0 for disabled, 1 enabled (by default it is disabled for all general users).
_nvdaControllerClient_free()
$delfiles = "1"
$soundclose.play
sleep(1000)
select
case $delfiles = 1
FileDelete(@tempDir & "\MCWeb.dat")
FileDelete("motd.ogg")
DirRemove(@TempDir & "/sounds", 1)
FileDelete(@TempDir & "\soundsdata.dat.zip")
sleep(100)
exit
case $delfiles = 0
sleep(100)
exit
endselect
endfunc
func agendar()
;GUISetState(@SW_HIDE, $gui_Main)
if $accessibility = "yes" then
speaking(translate($idioma, "Loading gui..."))
Else
ToolTip(translate($idioma, "Loading gui..."))
EndIF
global $mandar=""
global $anotar=""
global $notificar=""
global $enCurso = "0"
global $contador = "0"
global $mes
;@Danyfirex - en esta funcion cambie muchas posiciones de controles asi que no anote todo lo que se cambio pero todos los controles estan en posiciones
global $guioptions = GuiCreate(translate($idioma, "Schedule..."),420,570)
$iRadio_Count = 7 ;#danyfirex fix controls here
GUICtrlCreateGroup(translate($idioma, "Date and time"), 10, 10, 390-10+20, 320)
$label1 = GUICtrlCreateLabel(translate($idioma, "Name of the schedule (optional) leave blank for untitled schedule"), 20, 30 + (1 * 0), 360, 20)
global $name = GUICtrlCreateInput("", 20, 30 + 15 +(1 * 0), 200, 20)
$label2 = GUICtrlCreateLabel(translate($idioma, "Description (optional)"), 20,  70 + (1 * 0), 300, 20)
global $desc = GUICtrlCreateInput("", 20, 70 + 15 +(1 * 0), 200, 20)
$label3 = GUICtrlCreateLabel(translate($idioma, "Day"), 20, 110 +(1 * 0), 300, 20)
global $day = GUICtrlCreateInput("", 20, 110 + 15 +(1 * 0), 200, 20)
$label3a = GUICtrlCreateLabel(translate($idioma, "Choose month"), 20, 155, 100, 20)
global $Mond = GUICtrlCreateCombo(translate($idioma, "January"), 100, 155, 200, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetOnEvent(-1, "setmond")
global $meses=translate($idioma, "February|March|April|May|June|July|August|September|October|November|December")
global $mesesStr = StringSplit(translate($idioma, "February|March|April|May|June|July|August|September|October|November|December"), "|")
GUICtrlSetData($Mond, $meses)
$label4 = GUICtrlCreateLabel(translate($idioma, "Write the start hour of your schedule"), 20, 190, 300, 20)
global $hour = GUICtrlCreateInput("", 200, 190-5, 100, 20)
$label4a = GUICtrlCreateLabel(translate($idioma, "End hour"), 20, 190+30, 100, 20)
global $hourend = GUICtrlCreateInput("", 130, 190+30-5, 200, 20)
$label5 = GUICtrlCreateLabel(translate($idioma, "Choose minute"), 20, 270, 100, 20)
global $Minute = GUICtrlCreateCombo("00", 80, 270-5, 60, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData($Minute, "05|10|15|20|25|30|35|40|45|50|55")
$label5a = GUICtrlCreateLabel(translate($idioma, "Choose minute end"), 150, 270, 150, 20)
global $Minuteend = GUICtrlCreateCombo("00", 210, 210, 200, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($Minuteend, "05|10|15|20|25|30|35|40|45|50|55")
$label6 = GUICtrlCreateLabel(translate($idioma, "Choose second"), 20, 300, 100, 20)
global $second = GUICtrlCreateCombo("00", 110, 300-5, 60, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData($second, "05|10|15|20|25|30|35|40|45|50|55")
$label6a = GUICtrlCreateLabel(translate($idioma, "Choose the second end"), 175, 300, 200, 20)
global $secondend = GUICtrlCreateCombo("00", 330, 300-5, 60, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData($secondend, "05|10|15|20|25|30|35|40|45|50|55")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup(translate($idioma, "How do you want to get your schedule?"), 10, 340, 380+20, 100)
$labelidagenda1=GUICtrlCreateLabel(translate($idioma, "Remember me, please. Remember by message to your e-mail, in case you do not have the computer available."),40,360,350,40)
Global $idagenda1 = GUICtrlCreateRadio("", 20, 360, 20, 20)
GUICtrlSetOnEvent(-1, "configurarcontroles")
global $idagenda2 = GUICtrlCreateRadio(translate($idioma, "Write me this schedule in a text file"), 20, 390, 300, 20)
GUICtrlSetOnEvent(-1, "configurarcontroles")
global $idagenda3 = GUICtrlCreateRadio(translate($idioma, "Notify me 5 or more minutes before the schedule"), 20, 410, 300, 20)
GUICtrlSetOnEvent(-1, "configurarcontroles")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetState($idAgenda1, $GUI_CHECKED)
global $label7 = GUICtrlCreateLabel(translate($idioma, "How do you want the notify?"), 20, 450, 160, 20)
GUICtrlSetState(-1, $GUI_HIDE)
global $idAviso = GUICtrlCreateCombo(translate($idioma, "Sound"), 160, 450-5, 200, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData($idAviso, translate($idioma, "notification") &"|" &translate($idioma, "Sound and notification"))
GUICtrlSetOnEvent(-1, "avisos")
GUICtrlSetState(-1, $GUI_HIDE)
global $label8 = GUICtrlCreateLabel(translate($idioma, "Select a sound from the list"), 20, 480, 200, 20)
GUICtrlSetState(-1, $GUI_HIDE)
global $idAviso2 = GUICtrlCreateCombo("Beep", 180, 480-5, 200, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetOnEvent(-1, "avisos")
GUICtrlSetState(-1, $GUI_HIDE)
$label9 = GUICtrlCreateLabel(translate($idioma, "Choose how many minutes in advance to notify you"), 20, 510, 300, 20)
global $idCuantosminutos = GUICtrlCreateCombo(translate($idioma, "In real time (without anticipation) not recommended"), 250, 510-5, 160, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData($idCuantosminutos, translate($idioma, "5 minutes before|10 minutes before|15 minutes before|30 minutes before|45 minutes before|one hour before"))
GUICtrlSetOnEvent(-1, "tiempo")
global $BTNOk = GUICtrlCreateButton(translate($idioma, "OK"), 50, 530, 60, 30)
GUICtrlSetOnEvent(-1, "configureschedule")
global $idBTN_Close = GUICtrlCreateButton(translate($idioma, "Back to the previous window"), 150, 530, 150, 30)
GUICtrlSetOnEvent(-1, "cerraragenda")
$soundList = FileReadToArray(@TempDir &"\sounds\SoundList.txt")
$Contarlineas = @extended
If @error Then
MsgBox(0, translate($idioma, "error"), translate($idioma, "There was an error reading sound List. Reason: ") &" " &@error)
Else
if $accessibility = "yes" then speaking(translate($idioma, "Loading sounds..."))
For $i = 0 To $contarlineas - 1
if $accessibility = "yes" then
$progress = int($I /$contarlineas * 100)
CreateAudioProgress($progress)
sleep(25)
EndIf
GUICtrlSetData($idAviso2, $Soundlist[$i])
Next
EndIF
if $accessibility = "yes" then
CreateAudioProgress("100")
speaking(translate($idioma, "Loaded sounds"))
else
ToolTip("")
EndIf
GUISetState(@SW_SHOW)
Local $idMsg
global $sComboRead = ""
global $sComboRead2 = ""
Global $sComboRead3 = ""
GUISetOnEvent($GUI_EVENT_CLOSE, "cerraragenda")
Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1) 
GUISetOnEvent($GUI_EVENT_MINIMIZE, "MinToTray")
$showitem = TrayCreateItem(translate($idioma, "Show window"))
TrayItemSetOnEvent(-1, "showagenda")
$exitAction = TrayCreateItem(translate($idioma, "Close this action"))
TrayItemSetOnEvent(-1, "cerraragenda")
$exitProgram = TrayCreateItem(translate($idioma, "Exit the program"))
TrayItemSetOnEvent(-1, "exitpersonaliced")
TraySetState(2)
EndFunc
Func MinToTray()
speaking(translate($idioma, "the window has been minimized"))
GuiSetState(@SW_HIDE, $guioptions)
TraySetState(1)
EndFunc
Func showagenda()
GuiSetState(@SW_SHOW, $guioptions)
GuiSetState(@SW_RESTORE, $guioptions)
TraySetState(2)
EndFunc
func cerraragenda()
$questsch = MsgBox(4, translate($idioma, "Question"), translate($idioma, "Are you sure you want to cancel the creation of this schedule?"))
if $questsch = "6" then
guiDelete($guioptions)
GUISetState(@SW_SHOW, $gui_Main)
endIf
EndFunc
func setmond()
$sComboRead = GUICtrlRead($mond)
$scrollsound.play
select
case $sComboRead = translate($idioma, "January")
global $mes = "01"
case $sComboRead = $mesesStr[1]
global $mes = "02"
case $sComboRead = $mesesStr[2]
global $mes = "03"
case $sComboRead = $mesesStr[3]
global $mes = "04"
case $sComboRead = $mesesStr[4]
global $mes = "05"
case $sComboRead = $mesesStr[5]
global $mes = "06"
case $sComboRead = $mesesStr[6]
global $mes = "07"
case $sComboRead = $mesesStr[7]
global $mes = "08"
case $sComboRead = $mesesStr[8]
global $mes = "09"
case $sComboRead = $mesesStr[9]
global $mes = "10"
case $sComboRead = $mesesStr[10]
global $mes = "11"
case $sComboRead = $mesesStr[11]
global $mes = "12"
case else
global $mes = @mon
EndSelect
EndFunc
func configurarcontroles()
select
Case @GUI_CtrlId = $idagenda1
$anotar="False"
$notificar="False"
$mandar="true"
GUICtrlSetState($label7,$GUI_HIDE)
GUICtrlSetState($IDaviso,$GUI_HIDE)
GUICtrlSetState($label8,$GUI_HIDE)
GUICtrlSetState($IDaviso2,$GUI_HIDE)
$radiosound.play
Case @GUI_CtrlId = $idagenda2
$mandar="False"
$notificar="False"
$anotar="true"
GUICtrlSetState($label7,$GUI_HIDE)
GUICtrlSetState($IDaviso,$GUI_HIDE)
GUICtrlSetState($label8,$GUI_HIDE)
GUICtrlSetState($IDaviso2,$GUI_HIDE)
$radiosound.play
Case @GUI_CtrlId = $idagenda3
$mandar="False"
$anotar="False"
$notificar="true"
GUICtrlSetState($Label7,$GUI_SHOW)
GUICtrlSetState($IDAviso,$GUI_SHOW)
GUICtrlSetState($Label8,$GUI_SHOW)
GUICtrlSetState($IDAviso2,$GUI_SHOW)
$radiosound.play
EndSelect
EndFunc
func avisos()
select
Case @GUI_CtrlId = $idAviso
$sComboRead = GUICtrlRead($idAviso)
$scrollsound.play
IniWrite(@scriptDir &"\config\config.st", "General Settings", "Notify", $sComboRead)
select
case $sComboRead = translate($idioma, "Sound")
beep(2000, 100)
case $sComboRead = translate($idioma, "notification")
$notsound = $device.opensound(@scriptDir &"\sounds/NewMessageNotification.ogg", true)
$notsound.play
sleep(400)
SoundFade($notsound)
case $sComboRead = translate($idioma, "Sound and notification")
beep(2000, 100)
$notsound = $device.opensound(@scriptDir &"\sounds/NewMessageNotification.ogg", true)
$notsound.play
sleep(400)
SoundFade($notsound)
EndSelect
Case @GUI_CtrlId = $idAviso2
$sComboRead2 = GUICtrlRead($idAviso2)
$scrollsound.play
select
case $sComboRead2 = "Beep"
beep(880, 500)
Case else
$ring = $device.opensound(@scriptDir &$sComboRead2, true)
$ring.play
if @error then
Msgbox(0, translate($idioma, "Error"), translate($idioma, "Impossible to play"))
EndIf
sleep(1400)
SoundFade($ring)
EndSelect
IniWrite(@scriptDir &"\config\config.st", "General Settings", "Sound", $sComboRead2)
endSelect
EndFunc
func tiempo()
$sComboRead3 = GUICtrlRead($idCuantosminutos)
$minuto = GUICtrlRead($minute)
$scrollsound.play
$minStr = StringSplit(translate($idioma, "5 minutes before|10 minutes before|15 minutes before|30 minutes before|45 minutes before|one hour before"), "|")
select
case $sComboRead3 = translate($idioma, "In real time (without anticipation) not recommended")
global $minutoresta = $minuto
case $sComboRead3 = $minStr[1]
global $minutoresta = $minuto -5
case $sComboRead2 = $minStr[2]
global $minutoresta = $minuto -10
case $sComboRead3 = $minStr[3]
global $minutoresta = $minuto -15
case $sComboRead3 = $minStr[4]
global $minutoresta = $minuto -30
case $sComboRead3 = $minStr[5]
global $minutoresta = $minuto -45
EndSelect
EndFunc
func configureschedule()
if $accessibility = "yes" then
Speaking(translate($idioma, "Good, configuring your schedule!"))
else
ToolTip(translate($idioma, "Good, configuring your schedule!"))
EndIf
sleep(50)
GUISetState(@SW_Hide, $Guioptions)
$contador = $contador +1
Global $nombredeagenda = GUICtrlRead($name)
if $nombredeagenda ="" then $nombredeagenda = translate($idioma, "Untitled schedule")
Global $descripcion = GUICtrlRead($desc)
if $descripcion ="" then $descripcion = translate($idioma, "untitled Description")
if $mes ="" then $mes = @MON
Global $dia = GUICtrlRead($day)
if $dia ="" then $dia = @MDAY
Global $hora = GUICtrlRead($hour)
if $hora ="" then $hora = @HOUR
Global $horafinal = GUICtrlRead($hourend)
Global $minuto = GUICtrlRead($minute)
if $minuto ="" then $minuto = @MIN +5
Global $minutofinal = GUICtrlRead($minuteend)
Global $segundo = GUICtrlRead($second)
if $segundo ="" then $segundo = @SEC
Global $segundofinal = GUICtrlRead($secondend)
if $segundofinal ="" then $segundofinal = "00"
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Schedule", "Name", $nombredeagenda)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Schedule", "Description", $descripcion)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Mont", $mes)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Day", $dia)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Hour", $hora)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Hour End", $horafinal)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Minute", $minuto)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Minute end", $minutofinal)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Second", $segundo)
IniWrite(@scriptDir &"\config\" &$nombredeagenda &".ini", "Date", "Second end", $segundofinal)
MSGBox(0, translate($idioma, "Very good") &" " &@username, translate($idioma, "You have configured a schedule called") &" " &$nombredeagenda &" " &translate($idioma, "For him") &" " &$dia &"/" &$mes &"/" &@year &" " &translate($idioma, "At") &" " &$hora &":" &$minuto &":" &$segundo &" " &translate($idioma, "Until") &" " &$horafinal &":" &$minutofinal &":" &$segundofinal &". " &translate($idioma, "You can minimize this application so that it runs in the background. However, your schedule will remain available until the time defined by you, unless you kill this process..."))
if $mandar ="" and $anotar ="" and $notificar ="" then
msgbox(0, translate($idioma, "error"), translate($idioma, "You have not selected any reminder option!"))
GUISetState(@SW_SHOW, $Guioptions)
EndIf
if $mandar ="true" then
$enCurso="1"
$aestecorreo=Inputbox(translate($idioma, "Schedule to email"), translate($idioma, "What is your email?"))
Local $sMsg = ""
Switch @HOUR
Case 1 To 11
$sMsg = translate($idioma, "Good morning")
Case 12 To 17
$sMsg = translate($idioma, "Good afternoon")
Case 18 To 23
$sMsg = translate($idioma, "Good night")
Case Else
$sMsg = translate($idioma, "Hello")
EndSwitch
$FromName = translate($idioma, "Mini Calendar&scheduler")
$Subject = translate($idioma, "My scheduled schedule") &translate($idioma, "Schedule reminder")
$mensaje= $sMsg &" " &@username &", " &@crlf &translate($idioma, "We remind you that you have an schedule for him") &" " &$dia &"/" &$mes &"/" &@year &translate($idioma, "at") &" " &$hora &":" &$minuto &":" &$segundo &translate($idioma, "Until") &$horafinal &":" &$minutofinal &":" &$segundofinal &"." &@crlf &translate($idioma, "Name of your schedule:") &" " &$nombredeagenda &@crlf &translate($idioma, "Description:") &" " &$descripcion &@crlf
$Body = $mensaje &@crlf &translate($idioma, "Thank you, mini calendar and scheduler.")
MSGBox(0, translate($idioma, "Done"), translate($idioma, "We will send you a message to your email 10 minutes before your schedule. Thank you."))
global $guisch1=guicreate("mini calendar - " &$nombredeagenda &" " &translate($idioma, "Schedule to email"))
$schtime=GUICtrlCreateLabel($dia &"/" &$mes &"/" &@year &" " &$hora &":" &$minutoresta &":" &$segundo, 0, 100, 20, 20)
$idCanceloperation = GUICtrlCreateButton(translate($idioma, "Cancel schedule"), 150, 100, 20, 20)
GUICtrlSetOnEvent(-1, "cancelemail")
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "cancelemail")
sleep(100)
While 1
if not $enCurso = "1" then exitLoop
if @MON = $mes and @MDAY = $dia and @HOUR = $hora and @MIN = $minutoresta and @SEC = $segundo then
speaking(translate($idioma, "Sending mail, please wait ..."))
_INetMail($aestecorreo, $Subject, $Body)
sleep(400)
speaking(translate($idioma, "Mail sent to") &" " &$aestecorreo)
ExitLoop
EndIf
$enCurso="0"
Wend
GUISetState(@SW_SHOW, $guioptions)
EndIf
if $anotar ="true" then
global $guichoose = GuiCreate(translate($idioma, "Write schedule"))
GUICtrlCreateLabel(translate($idioma, "what do you want to do?"), 10, 10, 130, 20)
global $act1 = GUICtrlCreateCheckbox(translate($idioma, "Annotate only"), 10, 70, 100, 20)
global $act2 = GUICtrlCreateCheckbox(translate($idioma, "print (requires having an schedule written down)"), 10, 110, 100, 20)
global $ready = GUICtrlCreateButton(translate($idioma, "OK"), 80, 10, 100, 20)
GuiCtrlSetOnEvent(-1, "writeandprynt")
global $cancel = GUICtrlCreateButton(translate($idioma, "Cancel"), 80, 80, 100, 20)
GuiCtrlSetOnEvent(-1, "cwriteandprynt")
GuiSetState(@sw_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "cwriteandprynt")
EndIf
if $notificar ="true" then
MSGBox(0, translate($idioma, "Done"), translate($idioma, "We will notify you by") &" " &$sComboRead &$sComboRead3 &translate($idioma, "Before your schedule."))
notificar()
EndIf
endfunc
func annotateText($numchars)
$checkoption = IniRead(@scriptDir &"\config\config.st", "General settings", "Play sounds when typing", "")
if $checkoption = "yes" then
for $letters = 1 to $numchars step 2
PlayWait("Sounds/paper" &random(1, 10, 1) &".ogg")
next
EndIf
if $checkoption = "" then
IniWrite(@scriptDir &"\config\config.st", "General settings", "Play sounds when typing", "Yes")
EndIf
endFunc
func writeandprynt()
If _IsChecked_audio($act1) Then
speaking(translate($idioma, "Writing schedule, please wait ..."))
global $scFile = FileOpen(translate($idioma, "Schedules") &"\" &translate($idioma, "My schedules") &" " &@year &".txt",$FC_OVERWRITE  + $FC_CREATEPATH)
PlayWait("sounds/annotate.ogg")
If $scFile = -1 Then MsgBox($MB_SYSTEMMODAL, translate($idioma, "error"), translate($idioma, "An error occurred when writing the file."))
FileWrite($SCFile, translate($idioma, "Name of the schedule (optional) leave blank for untitled schedule") &": " &$nombredeagenda &@crlf)
annotateText(StringLen($nombredeagenda))
FileWrite($SCFile, translate($idioma, "Description (optional)") &": " &$descripcion &@crlf)
annotateText(StringLen($descripcion))
FileWrite($SCFile, translate($idioma, "Day") &": " &$dia &@crlf)
annotateText(StringLen($dia))
FileWrite($SCFile, translate($idioma, "Choose month") &": " &$mes &@crlf)
annotateText(StringLen($mes))
FileWrite($SCFile, translate($idioma, "Write the start hour of your schedule") &": " &$hora &@crlf)
annotateText(StringLen($hora))
FileWrite($SCFile, translate($idioma, "End hour") &": " &$HORAFINAL &@crlf)
annotateText(StringLen($horafinal))
FileWrite($SCFile, translate($idioma, "Choose minute") &": " &$minuto &@crlf)
annotateText(StringLen($minuto))
FileWrite($SCFile, translate($idioma, "Choose minute end") &": " &$minutofinal &@crlf)
annotateText(StringLen($minutofinal))
FileWrite($SCFile, translate($idioma, "Choose second") &": " &$segundo &@crlf)
annotateText(StringLen($segundo))
FileWrite($SCFile, translate($idioma, "Choose the second end") &": " &$segundofinal &@crlf)
annotateText(StringLen($segundofinal))
sleep(200)
PlayWait("sounds/selected.ogg")
msgbox(0, translate($idioma, "Done"), translate($idioma, "Your schedule has been saved to a text file. Find it in schedules\my schedules") &@year &".txt. " &translate($idioma, "You can share that file or print it, if you want"))
EndIF
If _IsChecked_audio($act2) Then
speaking(translate($idioma, "printing file, please wait..."))
if not FileExists(translate($idioma, "Schedules") &"\" &translate($idioma, "My schedules") &" " &@year &".txt") then
MsgBox(16, translate($idioma, "Error"), translate($idioma, "The schedules document was not found"))
Else
$estaimprimido = _FilePrint(translate($idioma, "Schedules") &"\" &translate($idioma, "My schedules") &" " &@year &".txt")
If $estaimprimido Then
MsgBox(48, translate($idioma, "Done"), translate($idioma, "the file has been printed successfully!"))
Else
MsgBox(16, translate($idioma, "Error"), translate($idioma, "The document could not be printed.") &@crlf &translate($idioma, "Error code:") &" " &@error)
EndIf
EndIF
cwriteandprynt()
EndIf
If not _IsChecked_audio($act1) and not _IsChecked_audio($act2) Then
msgBox(16, translate($idioma, "Error"), translate($idioma, "you don't have any checked actions"))
cwriteandprynt()
EndIf
EndFunc
func cwriteandprynt()
FileClose($SCFile)
GuiDelete($guichoose)
EndFunc
func cancelemail()
$question = msgBox(4, translate($idioma, "Question"), translate($idioma, "Are you sure you want to cancel the operation?"))
If $question == 6 Then
$enCurso="0"
guiDelete($guisch1)
Else
EndIf
EndFunc
func notificar()
$notificacion = iniRead (@scriptDir &"\config\config.st", "General Settings", "Notify", "")
$sonidoparareproducir = iniRead (@scriptDir &"\config\config.st", "General Settings", "Sound", "")
global $guisch3=guicreate("Mini calendar - " &$nombredeagenda &" - " &translate($idioma, "Notification"))
$schtime=GUICtrlCreateLabel($dia &"/" &$mes &"/" &@year &" " &$hora &":" &$minutoresta &":" &$segundo, 0, 100, 20, 20)
global $idCancelsch = GUICtrlCreateButton(translate($idioma, "Cancel schedule"), 150, 100, 20, 20)
GUICtrlSetOnEvent(-1, "cancelarorecordar")
global $idremindme = GUICtrlCreateButton(translate($idioma, "Remember me the next time"), 260, 100, 20, 20)
GUICtrlSetOnEvent(-1, "cancelarorecordar")
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "cancelarorecordar")
While 1
if not $enCurso = "1" then exitLoop
if @MON = $mes and @MDAY = $dia and @HOUR = $hora and @MIN = $minutoresta and @SEC = $segundo then
select
case $notificacion = translate($idioma, "Sound")
$stoplay = $device.opensound(@scriptDir &$sonidoparareproducir, true)
$stoplay.play
exitloop
case $notificacion = translate($idioma, "notification")
TrayTip($recordar1, $recuerda &" " &$nombredeagenda &translate($idioma, "For him ") &" " &$dia &"/" &$mes &"/" &@year &" " &translate($idioma, "At") &" " &$hora &":" &$minuto &":" &$segundo &" " &translate($idioma, "Until") &$horafinal &":" &$minutofinal &":" &$segundofinal, 0, $TIP_ICONASTERISK)
speaking($recuerda &" " &$nombredeagenda &translate($idioma, "For him") &" " &$dia &"/" &$mes &"/" &@year &" " &translate($idioma, "At") &" " &$hora &":" &$minuto &":" &$segundo &translate($idioma, "Until") &$horafinal &":" &$minutofinal &":" &$segundofinal)
exitloop
case $notificacion = translate($idioma, "Sound and notification")
$stoplay = $device.opensound(@scriptDir &$sonidoparareproducir, true)
$stoplay.play
TrayTip($recordar1, $recuerda &" " &$nombredeagenda &translate($idioma, "For him ") &" " &$dia &"/" &$mes &"/" &@year &" " &translate($idioma, "At") &" " &$hora &":" &$minuto &":" &$segundo &" " &translate($idioma, "Until") &$horafinal &":" &$minutofinal &":" &$segundofinal, 0, $TIP_ICONASTERISK)
speaking($recuerda &" " &$nombredeagenda &translate($idioma, "For him") &" " &$dia &"/" &$mes &"/" &@year &" " &translate($idioma, "At") &" " &$hora &":" &$minuto &":" &$segundo &translate($idioma, "Until") &$horafinal &":" &$minutofinal &":" &$segundofinal)
exitloop
EndSelect
EndIf
Wend
EndFunc
func cancelarorecordar()
select
Case @GUI_CtrlId = $idCancelsch
$question = msgBox(4, translate($idioma, "Question"), translate($idioma, "Are you sure you want to cancel the operation?"))
If $question == 6 Then
$enCurso="0"
FileDelete(@scriptDir &"\config\" &$nombredeagenda &".ini")
guiDelete($guisch3)
EndIF
Case @GUI_CtrlId = $idremindme
$rmfile = FileOpen(translate($idioma, "Schedules") &"\" &translate($idioma, "Reminders") &".mcremind",$FC_OVERWRITE  + $FC_CREATEPATH)
FileWrite($rmfile, $nombredeagenda &",")
FileClose($rmfile)
$enCurso="0"
guiDelete($guisch3)
msgBox(48, translate($idioma, "Done"), translate($idioma, "Done"))
EndSelect
EndFunc
Func report()
ShellExecute("https://docs.google.com/forms/d/e/1FAIpQLSdDW6LqMKGHjUdKmHkAZdAlgSDilHaWQG9VZjwLz0CJSXKqHA/viewform?usp=sf_link")
EndFunc
func ReadChanges2()
global $openned
$doc = "documentation\" &$idioma &"\changes.txt"
global $DocOpen = FileOpen($doc, $FO_READ)
ToolTip(translate($idioma, "Opening..."))
speaking(translate($idioma, "Opening..."))
If $DocOpen = "-1" Then MsgBox($MB_SYSTEMMODAL, translate($idioma, "error"), translate($idioma, "An error occurred when reading the file."))
$openned = FileRead($DocOpen)
ToolTip("")
global $mwindow = GUICreate(translate($idioma, "Changes"))
$idMyedit = GUICtrlCreateEdit($openned, 5, 5, 390, 360, BitOR($WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))   ;@Danyfirex Arreglado Scroll y  Cambio tamaño para hacer el edit casi del tamaño de la interfaz que por defecto es de 400x400
$idExitDoc = GUICtrlCreateButton(translate($idioma, "Close"), 100, 370, 150, 30)
GuiCtrlSetOnEvent(-1, "delete2")
GUISetOnEvent($GUI_EVENT_CLOSE, "delete2")  ;@Danyfirex  agregado para poder cerrar  con el boton superior X arriba a la derecha
GUISetState(@SW_SHOW)
EndFunc
func delete2()
FileClose($DocOpen)
GUIDelete($mwindow)
EndFunc
func newIssue()
ShellExecute("https://github.com/rmcpantoja/mini-calendar/issues/new")
EndFunc