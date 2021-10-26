;Mini Calendario y ajenda
; #pragma compile(Icon, C:\Program Files\AutoIt3\Icons\au3.ico)
#pragma compile(UPX, False)
;#pragma compile(Compression, 0)
#pragma compile(FileDescription, Mini Calendar)
#pragma compile(ProductName, Mini Calendar)
#pragma compile(ProductVersion, 0.3.0.0)
#pragma compile(FileVersion, 0.3.0.0, 0.3.0.0)
#pragma compile(LegalCopyright, © 2018-2021 MT Programs, All rights reserved)
#pragma compile(CompanyName, 'MT Programs')
;include
#include <AutoItConstants.au3>
#include <ComboConstants.au3>
#include "include\desencriptador.au3"
#include <EditConstants.au3>
#Include<fileConstants.au3>
#include <guiConstantsEx.au3>
#include <include\reader.au3>
#include "include\options.au3"
#include <include\sapi.au3>
#include <misc.au3>
#include <include\NVDAControllerClient.au3>
#include <include\kbc.au3>
#include <include\menu_nvda.au3>
#include <TrayConstants.au3>
#include "updater.au3"
#include <WindowsConstants.au3>
;#include "include\zip.au3"
$l1 = GUICreate("Loading...")
GUISetState(@SW_SHOW)
sleep(10)
If not FileExists("MC.au3") Then
sleep(10)
Extractor()
else
sleep(25)
comprovar()
endif
Func Extractor()
GUICtrlCreateLabel("Extracting sounds...", 40, 20)
sleep(500)
Local $zip_carpeta = @scriptDir & '\soundsdata.dat'
If FileExists("sounds\soundsdata.dat\*.mp3") then
if @compiled then
msgbox (4096, "error", "Damn thief, stop stealing the sounds!")
exit
EndIf
comprovar()
endif
If FileExists(@TempDir &"\sounds\soundsdata.dat\*.mp3") then
if @compiled then
;remover esa carpeta
DirRemove(@TempDir & "/sounds", 1)
EndIf
endIf
desencriptar()
comprovar()
If FileExists($zip_carpeta) Then
;sleep(2000)
;_Zip_UnzipAll($zip_Carpeta, @TempDir, 0)
sleep(50)
GUIDelete($l1)
comprovar()
;else
;MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Fatal error", "Could not extract sounds.")
;exit
endIf
GUIDelete($l1)
EndFunc
func comprovar()
if not fileExists ("config") then
DirCreate("config")
EndIf
GUIDelete($l1)
checkselector()
EndFunc
func checkselector()
global $sLanguage = iniRead ("config\config.st", "General settings", "language", "")
select
case $sLanguage ="es"
checkupd()
case $sLanguage ="eng"
checkupd()
case else
selector()
endselect
endfunc
Func Selector()
local $widthCell,$msg,$iOldOpt
$langGUI= GUICreate("Language Selection")
$widthCell=70
$iOldOpt=Opt("GUICoordMode",$iOldOpt)
GUICtrlCreateLabel("Select language:", 30, 50,$widthCell)
GUISetBkColor(0x00E0FFFF)
GUISetState(@SW_SHOW)
$windowslanguage= @OSLang
;Spanish languages: Idiomas en español:
select
case $windowslanguage = "0c0a" or $windowslanguage = "040a" or $windowslanguage = "080a" or $windowslanguage = "100a" or $windowslanguage = "140a" or $windowslanguage = "180a" or $windowslanguage = "1c0a" or $windowslanguage = "200a" or $windowslanguage = "240a" or $windowslanguage = "280a" or $windowslanguage = "2c0a" or $windowslanguage = "300a" or $windowslanguage = "340a" or $windowslanguage = "380a" or $windowslanguage = "3c0a" or $windowslanguage = "400a" or $windowslanguage = "440a" or $windowslanguage = "480a" or $windowslanguage = "4c0a" or $windowslanguage = "500a"
$menu=Reader_create_menu("Por favor, selecciona tu idioma", "español,inglés,salir")
;English languages: Idiomas para inglés:
case $windowslanguage = "0809" or $windowslanguage = "0c09" or $windowslanguage = "1009" or $windowslanguage = "1409" or $windowslanguage = "1809" or $windowslanguage = "1c09" or $windowslanguage = "2009" or $windowslanguage = "2409" or $windowslanguage = "2809" or $windowslanguage = "2c09" or $windowslanguage = "3009" or $windowslanguage = "3409" or $windowslanguage = "0425"
$menu=Reader_create_menu("Please select language", "spanish,english,exit")
case else
$menu=Reader_create_menu("Please select language", "spanish,english,exit")
endselect
select
case $menu = 1
IniWrite("config\config.st", "General settings", "language", "es")
sleep(25)
GUIDelete($langGUI)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
checkupd()
case $menu = 2
IniWrite ("config\config.st", "General settings", "language", "eng")
sleep(25)
GUIDelete($langGUI)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
checkupd()
case $menu = 3
sleep(25)
exitpersonaliced()
EndSelect
endFunc
func checkupd()
global $main_u = GUICreate("Checking version...")
GUISetState(@SW_SHOW)
sleep(25)
toolTip("checking version...")
speaking("Checking version...")
sleep(25)
checkversion()
sleep(100)
GUIDelete($main_u)
sleep(100)
endfunc
func checkversion()
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
Local $yourexeversion = FileGetVersion("MC.exe")
select
case $sLanguage ="es"
$ttsString_Es = " Pulsa enter para continuar, espacio para repetir la información."
$newversion=" Tienes la "
$newversion2=", y está disponible la "
case $sLanguage ="eng"
$newversion=" You have the version "
$newversion2=", And is available the "
endselect
$fileinfo = InetGet("https://www.dropbox.com/s/hy22d9513bgbih9/MCWeb.dat?dl=1", "MCWeb.dat")
FileCopy("MCWeb.dat", @TempDir & "\MCWeb.dat")
$latestver = iniRead (@TempDir & "\MCWeb.dat", "updater", "LatestVersion", "")
if $sLanguage ="Es" then
select
Case $latestVer > $yourexeversion
speak("hay una nueva versión.")
TTSDialog("actualización disponible! " &$newversion &$yourexeversion &$newversion2 &$latestver& ". Presiona enter para descargar.", $ttsString_Es)
sleep(50)
GUIDelete($main_u)
_Updater_Update("MC.exe", "none", "https://www.dropbox.com/s/e2y1nb0r449wxq4/MCExtract.exe?dl=1")
Case else
GUIDelete($main_u)
checkmotd()
endselect
endif
if $sLanguage ="Eng" then
select
Case $latestVer > $yourexeversion
speak("there is a new version.")
TTSDialog("update available! " &$newversion &$yourexeversion &$newversion2 &$latestver& ". Press enter to download.")
GUIDelete($main_u)
_Updater_Update("MC.exe", "none", "https://www.dropbox.com/s/e2y1nb0r449wxq4/MCExtract.exe?dl=1")
case else
GUIDelete($main_u)
checkmotd()
endselect
endif
InetClose($fileinfo)
If @Compiled Then
FileDelete("MCWeb.dat")
FileDelete(@tempDir & "\MCWeb.dat")
EndIf
GUIDelete($main_u)
endfunc
func checkmotd()
;Function to check messaje of the day.
$LMotd = iniRead ("config\config.st", "misc", "motdversion", "")
$LatestMotd = iniRead (@TempDir & "\MCWeb.dat", "motd", "Latest", "")
select
Case $latestMotd > $lMotd
motdprincipal()
Case $latestMotd = $lMotd
principal()
endselect
InetClose($fileinfo)
endfunc
func motdprincipal()
$LatestMotd = iniRead (@TempDir & "\MCWeb.dat", "motd", "Latest", "")
$downloadingmotd = GUICreate("Descargando mensaje del día...")
GUICtrlCreateLabel("Espera, por favor.", 85, 20)
GUISetState(@SW_SHOW)
Sleep(10)
$grlanguage = iniRead ("config\config.st", "General settings", "language", "")
$M_mode = iniRead (@TempDir & "\MCWeb.dat", "motd", "Mode", "")
$ok = iniWrite ("config\config.st", "misc", "motdversion", $LatestMotd)
select
case $grlanguage ="es"
$ttsString_es = " Pulsa enter para continuar, espacio para repetir la información."
$M_text = iniRead (@TempDir & "\MCWeb.dat", "motd", "Text1", "")
TTSDialog($m_text, $ttsString_es)
case $grlanguage ="eng"
$M_text = iniRead (@TempDir & "\MCWeb.dat", "motd", "Text2", "")
TTSDialog($m_text)
endselect
GUIDelete($downloadingmotd)
PRINCIPAL()
endfunc
func principal()
if @compiled then
FileDelete("MCWeb.dat")
EndIf
$slanguage = iniRead ("config\config.st", "General settings", "language", "")
global $program_ver = 0.3
SoundPlay(@TempDir &"\sounds\soundsdata.dat\open.mp3",1)
$Gui_main = guicreate("Mini calendar " &$program_ver)
speaking("Cargando")
HotKeySet("{F1}", "playhelp")
global $programname="Mini Calendar"
select
case $slanguage ="es"
$mensaje12="Pulsa alt para abrir el menú."
$mensaje13="&Salir"
$menu1="Agendar..."
$menu1a="Opciones de Mini Calendario..."
$menu2="Salir"
$menu3="Ayuda"
$menu4="&Manual de usuario"
$menu4a="Cambios"
$menu5="Acerca de Mini Calendar"
$menu6="Reportero de errores..."
$menu7="Opciones"
$menu8="Visitar sitio web"
global $recordar1="Agenda programada"
global $recordar2="Te recordamos que tienes que hacer "
global $recordar3="Recuerda que tienes una agenda programada ya mismo. " 
global $recordar4="Prepárate para poner en marcha tus rutinas diarias a buen pie. "
global $recordar5="Es hora de realizar esta actividad "
global $recordar6="Buen ánimo, buena suerte y buena vibra para todo lo que propongas realizar "
global $recordar7="Esperemos que la siguiente actividad que hagas sea un éxito "
global $recordar8="Es hora de dejar el descanso y reanudar tu día con la siguiente actividad: "
global $recordar9="Buena suerte para esto, " &@username
case $sLanguage ="eng"
$mensaje12="Press alt to open the menu."
$mensaje13="E&xit"
$menu1="Schedule ..."
$menu1a="Mini Calendar Settings..."
$menu2="Exit"
$menu3="Help"
$menu4="&User manual"
$menu4a="Changes"
$menu5="About Mini Calendar"
$menu6="Bug reporter..."
$menu7="Options"
$menu8="Visit website"
global $recordar1="Scheduled schedule"
global $recordar2="We remind you what you have to do "
global $recordar3="Remember that you have an schedule programmed right now. "
global $recordar4="Get ready to start your daily routines on the right foot."
global $recordar5="It's time to do this activity"
global $recordar6="Good cheer, good luck and good vibes for everything you propose to do"
global $recordar7="Let's hope that the next activity you do is a success"
global $recordar8="It is time to leave the break and resume your day with the following activity:"
global $recordar9="Good luck for this, " &@username
EndSelect
$recuerdaa = Random(2, 9, 1)
select
case $recuerdaa = 2
global $recuerda = $recordar2
case $recuerdaa = 3
global $recuerda = $recordar3
case $recuerdaa = 4
global $recuerda = $recordar4
case $recuerdaa = 5
global $recuerda = $recordar5
case $recuerdaa = 6
global $recuerda = $recordar6
case $recuerdaa = 7
global $recuerda = $recordar7
case $recuerdaa = 8
global $recuerda = $recordar8
case $recuerdaa = 9
global $recuerda = $recordar9
EndSelect
$okmessaje="OK"
Local $idmc = GUICtrlCreateMenu($programname)
Local $idAgendaitem = GUICtrlCreateMenuItem($menu1, $idmc)
Local $idOptionsitem = GUICtrlCreateMenuItem($menu1a, $idmc)
Local $idExititem = GUICtrlCreateMenuItem($menu2, $idmc)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
Local $idHelpmenu = GUICtrlCreateMenu($menu3)
Local $idHelpitema = GUICtrlCreateMenuItem($menu5, $idHelpmenu)
Local $idHelpitemb = GUICtrlCreateMenuItem($menu8, $idHelpmenu)
Local $idHelpitemc = GUICtrlCreateMenuItem($menu4, $idHelpmenu)
Local $idChanges = GUICtrlCreateMenuItem($menu4a, $idHelpmenu)
local $idBGR = GUICtrlCreateMenuItem($menu6, $idHelpmenu)
GUICtrlCreateMenuItem("", $idmc, 2)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel($mensaje12, 0,100,20,20,$WS_TABSTOP)
GUICtrlSetState(-1, $GUI_FOCUS)
Local $idManualbutton = GUICtrlCreateButton($menu4, 65, 100, 20, 20)
Local $idExitbutton = GUICtrlCreateButton($mensaje13, 120, 100, 20, 20)
GUISetState(@SW_SHOW)
While 1
Switch GUIGetMsg()
Case $idAgendaitem
;GUISetState(@SW_Hide, $Gui_main)
Agendar()
Case $idOptionsitem
opciones()
Case $GUI_EVENT_CLOSE, $idExitbutton, $idExititem
exitpersonaliced()
case $idManualbutton 
playhelp()
Case $idHelpitema
select
case $slanguage ="es"
MsgBox(0, "Acerca de...", "Mini Calendario versión " &$program_ver &"beta, mini calendario y agenda para Windows. Programa desarrollado por Mateo Cedillo. 2018-2021 MT programs.")
case $slanguage ="eng"
MsgBox(0, "About", "Mini Calendar version " &$program_ver &"beta, mini calendar and scheduler for Windows. Program developed by Mateo Cedillo. 2018-2021 MT programs.")
endselect
continueLoop
case $idHelpitemb
ShellExecute("http://mateocedillo.260mb.net/")
case $idHelpitemc
playhelp()
case $idChanges
readchanges2()
case $idBGR 
Report()
EndSwitch
WEnd
EndFunc
func playhelp()
select
case $sLanguage  ="es"
Local $manualdoc = "documentation\manual1.txt"
$editmessage1="Manual del usuario."
$editmessage2="No se encuentra el archivo."
$editmessage3="abriendo..."
case $sLanguage ="eng"
Local $manualdoc = "documentation\manual2.txt"
$editmessage1="User manual."
$editmessage2="The file cannot be found."
$editmessage3="opening..."
endSelect
Local $DocOpen = FileOpen($manualdoc, $FO_READ)
ToolTip($editmessage3)
speaking($editmessage3)
sleep(50)
If $DocOpen = -1 Then
MsgBox($MB_SYSTEMMODAL, "error", "An error occurred when reading the file.")
Return False
EndIf
Local $openned = FileRead($DocOpen)
$manualwindow = GUICreate($manualdoc)
Local $idMyedit = GUICtrlCreateEdit($openned, 8, 92, 121, 97, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY, $WS_VSCROLL, $WS_VSCROLL, $WS_CLIPSIBLINGS))
GUISetState(@SW_SHOW)
; Loop until the user exits.
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
FileClose($DocOpen)
ExitLoop
EndSwitch
WEnd
GUIDelete()
EndFunc
func exitpersonaliced()
;This custom exit function is used to delete some files when exiting the program. 0 for disabled, 1 enabled (by default it is disabled for all general users). Esta función personalizada de salir, sirve para eliminar algunos archivos cuando se sale del programa. 0 para deshavilitado, 1 havilitado (por defecto está havilitado para todos los usuarios en general)
$delfiles = "1"
SoundPlay(@TempDir &"\sounds\soundsdata.dat\close.mp3",0)
sleep(1000)
select
case $delfiles = 1
FileDelete("MCWeb.dat")
FileDelete(@tempDir & "\MCWeb.dat")
DirRemove(@TempDir & "/sounds", 1)
FileDelete(@TempDir & "\soundsdata.dat.zip")
sleep(300)
exit
case $delfiles = 0
sleep(100)
exit
endselect
endfunc
func agendar()
speaking("Loading gui...")
select
case $slanguage ="es"
global $load1="Cargando sonidos..."
global $load2="Sonidos cargados"
global $mensaje0="Agendar"
global $mensaje0a="Fecha y hora"
global $mensaje1="Nombre de la aGenda (opcional) dejar en blanco para aGenda sin título"
global $mensaje2="Descripción (opcional)"
global $aGendaSinTitulo="AGenda sin título"
global $DescSinTitulo="Descripción sin título"
global $mensaje3="Día"
global $mensaje3a="Elegir mes"
global $mensaje4="Escribe la hora de inicio tu agenda"
global $mensaje4a="Hora de finalización"
global $mensaje5="Elige minuto"
global $mensaje5a="Agendas"
global $mensaje5b="Mis agendas"
global $mensaje5c="Elige minuto de finalización"
global $mensaje6="ELige el segundo"
global $mensaje6a="ELige el segundo de finalización"
global $mensaje7="Muy bien"
global $mensaje8="Has configurado una agenda llamada "
global $mensaje9="A las "
global $mensaje9a="Para el "
global $mensaje9b="Hasta "
global $mensaje10="Puedes minimizar esta aplicación para que se ejecute en segundo plano. No obstante, tu agenda seguirá disponible hasta la hora definida por ti, salbo  que mates este proceso..."
global $mensaje11="Aceptar"
global $mensaje11a="Volber a la ventana anterior"
global $opcion1="¿Cómo quieres obtener tu agenda?"
global $opcion2="Recuérdame, por favor. Recordar mediante mensaje a tu correo electrónico, en caso de que no tengas el pc disponible."
global $opcion3="Anótame esta agenda en un archivo de texto"
global $opcion4="Notifícame 5 o más minutos antes de la agenda"
global $mopcion1="agenda a correo electrónico"
global $mopcion2="¿Cuál es tu correo electrónico?"
global $mopcion3="Listo"
global $mopcion4="Te enviaremos un mensaje a tu coreo electrónico 10 minutos antes de tu agenda. Gracias."
global $mopcion5="Se ha guardado tu agenda a un archivo de texto. Encuéntralo en agendas\mis agendas "
global $mopcion5a="Agendas"
global $mopcion5b="Mis agendas"
global $mopcion6="Puedes compartir ese archivo o imprimirlo, si lo deseas"
global $mopcion7="Cómo quieres el aviso?"
global $mopcion8="Sonido"
global $mopcion9="notificación"
GLOBAL $mopcion10="Sonido y notificación"
global $mopcion11="Selecciona un sonido de la lista"
global $mopcion12="Elige cuántos minutos de anticipación notificarte"
global $mopcion12a="5 minutos antes|10 minutos antes|15 minutos antes|30 minutos antes|45 minutos antes|una hora antes"
global $mopcion12b="En tiempo real (sin anticipación) no recomendado "
global $mopcion13="Te notificaremos mediante "
global $mopcion14="Antes de tu agenda programada."
global $mopcion15="Enviando correo, por favor espera..."
global $mopcion16="Correo enviado a "
global $mopcion17="No has seleccionado ninguna opción de recordatorio!"
global $primermes="enero"
global $meses="Febrero|Marzo|Abril|Mayo|Junio|Julio|Agosto|Septiembre|Octubre|Noviembre|Diciembre"
Global $mes2="Febrero"
global $mes3="Marzo"
global $mes4="Abril"
global $mes5="Mayo"
global $mes6="Junio"
global $mes7="Julio"
Global $mes8="Agosto"
Global $mes9="Septiembre"
Global $mes10="Octubre"
Global $mes11="Noviembre"
Global $mes12="Diciembre"
global $errsounds="Ha ocurrido un error al leer la lista de sonidos. Motivo: "
case $sLanguage ="eng"
global $load1="Loading sounds ..."
global $load2="Loaded sounds"
global $mensaje0="Schedule"
global $mensaje0a="Date and time"
global $mensaje1="Name of the schedule (optional) leave blank for untitled schedule"
global $mensaje2="Description (optional)"
global $agendaSinTitulo="Untitled schedule"
global $DescSinTitulo="untitled Description"
global $mensaje3="Day"
global $mensaje3a="Choose month"
global $mensaje4 = "Write the start hour of your schedule"
global $mensaje4a="End hour"
global $mensaje5="Choose minute"
global $mensaje5a="Schedules"
global $mensaje5b="My schedules"
global $mensaje5c="Choose minute end"
global $mensaje6="Choose second"
global $mensaje6a="Choose the second end"
global $mensaje7="Very good"
global $mensaje8="You have configured a schedule called "
global $mensaje9="At "
global $mensaje9a="For him "
global $mensaje9b="Until "
global $mensaje10="You can minimize this application so that it runs in the background. However, your agenda will remain available until the time defined by you, unless you kill this process..."
global $mensaje11="OK"
global $mensaje11a="Back to the previous window"
global $opcion1="How do you want to get your schedule?"
global $opcion2="Remember me, please. Remember by message to your e-mail, in case you do not have the computer available."
global $opcion3="Write me this schedule in a text file"
global $opcion4="Notify me 5 or more minutes before the schedule"
global $mopcion1="Schedule to email"
global $mopcion2="What is your email?"
global $mopcion3="Done"
global $mopcion4="We will send you a message to your email 10 minutes before your schedule. Thank you."
global $mopcion5="Your schedule has been saved to a text file. Find it in schedules\my schedules"
global $mopcion5a="Schedules"
global $mopcion5b="My schedules"
global $mopcion6="You can share that file or print it, if you want"
global $mopcion7="How do you want the notify?"
global $mopcion8="Sound"
global $mopcion9="notification"
GLOBAL $mopcion10="Sound and notification"
global $mopcion11="Select a sound from the list"
global $mopcion12="Choose how many minutes in advance to notify you"
global $mopcion12a="5 minutes before|10 minutes before|15 minutes before|30 minutes before|45 minutes before|one hour before"
global $mopcion12b="In real time (without anticipation) not recommended"
global $mopcion13="We will notify you by "
global $mopcion14="Before your schedule."
global $mopcion15="Sending mail, please wait ..."
global $mopcion16="Mail sent to "
global $mopcion17="You have not selected any reminder option!"
global $primermes= "January"
global $meses="February|March|April|May|June|July|August|September|October|November|December"
global $mes2="February"
global $mes3="March"
global $mes4="April"
global $mes5="May"
global $mes6="June"
global $mes7="July"
Global $mes8="August"
Global $mes9="September"
Global $mes10="October"
Global $mes11="November"
Global $mes12="December"
global $errsounds="There was an error reading sound List. Reason: "
EndSelect
local $mandar=""
local $anotar=""
local $notificar=""
$guioptions = GuiCreate($mensaje0)
$iRadio_Count = 7
GUICtrlCreateGroup($mensaje0a, 10, 10, 100, 20)
$label1 = GUICtrlCreateLabel($mensaje1, 30, 30, 100, 20)
$name = GUICtrlCreateInput("", 30, 30, 200, 20)
$label2 = GUICtrlCreateLabel($mensaje2, 50, 50, 100, 20)
$desc = GUICtrlCreateInput("", 50, 50, 200, 20)
$label3 = GUICtrlCreateLabel($mensaje3, 75, 75, 100, 20)
$day = GUICtrlCreateInput("", 75, 75, 200, 20)
$label3a = GUICtrlCreateLabel($mensaje3a, 110, 110, 100, 20)
$Mond = GUICtrlCreateCombo($primermes, 110, 110, 200, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($Mond, $meses)
$label4 = GUICtrlCreateLabel($mensaje4, 135, 135, 100, 20)
$hour = GUICtrlCreateInput("", 135, 135, 200, 20)
$label4a = GUICtrlCreateLabel($mensaje4a, 160, 160, 100, 20)
$hourend = GUICtrlCreateInput("", 160, 160, 200, 20)
$label5 = GUICtrlCreateLabel($mensaje5, 180, 180, 100, 20)
$Minute = GUICtrlCreateCombo("00", 180, 180, 200, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($Minute, "05|10|15|20|25|30|35|40|45|50|55")
$label5a = GUICtrlCreateLabel($mensaje5c, 210, 210, 100, 20)
$Minuteend = GUICtrlCreateCombo("00", 210, 210, 200, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($Minuteend, "05|10|15|20|25|30|35|40|45|50|55")
$label6 = GUICtrlCreateLabel($mensaje6, 240, 240, 100, 20)
$second = GUICtrlCreateCombo("00", 240, 240, 200, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($second, "05|10|15|20|25|30|35|40|45|50|55")
$label6a = GUICtrlCreateLabel($mensaje6a, 270, 270, 100, 20)
$secondend = GUICtrlCreateCombo("00", 270, 270, 200, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($secondend, "05|10|15|20|25|30|35|40|45|50|55")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup($opcion1, 5, 50, 50, 100)
$idagenda1 = GUICtrlCreateRadio($opcion2, 50, 50, 300, 20)
$idagenda2 = GUICtrlCreateRadio($opcion3, 100, 100, 300, 20)
$idagenda3 = GUICtrlCreateRadio($opcion4, 150, 150, 300, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetState($idAgenda1, $GUI_CHECKED)
$label7 = GUICtrlCreateLabel($mopcion7, 180, 180, 300, 20)
GUICtrlSetState(-1, $GUI_HIDE)
$idAviso = GUICtrlCreateCombo($mopcion8, 180, 180, 350, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idAviso, $mopcion9 &"|" &$mopcion10)
GUICtrlSetState(-1, $GUI_HIDE)
$label8 = GUICtrlCreateLabel($mopcion11, 230, 230, 300, 20)
GUICtrlSetState(-1, $GUI_HIDE)
$idAviso2 = GUICtrlCreateCombo("Beep", 230, 230, 350, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetState(-1, $GUI_HIDE)
$label9 = GUICtrlCreateLabel($mopcion12, 250, 250, 300, 20)
$idCuantosminutos = GUICtrlCreateCombo($mopcion12b, 250, 250, 350, 20, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData($idCuantosminutos, $mopcion12a)
$BTNOk = GUICtrlCreateButton($mensaje11, 50, 200, 250, 50)
$idBTN_Close = GUICtrlCreateButton($mensaje11a, 80, 240, 250, 50)
$soundList = FileReadToArray(@TempDir &"\sounds\soundsdata.dat\SoundList.txt")
$Contarlineas = @extended
If @error Then
MsgBox(0, "Error", $errsounds & @error)
Else
speaking($load1)
For $i = 0 To $contarlineas - 1
GUICtrlSetData($idAviso2, $Soundlist[$i])
Next
speaking($load2)
EndIf
GUISetState(@SW_SHOW)
Local $idMsg
Local $sComboRead = ""
Local $sComboRead2 = ""
Local $sComboRead3 = ""
While 1
$idMsg = GUIGetMsg()
Select
Case $idMsg = $GUI_EVENT_CLOSE
guiDelete($guioptions)
ExitLoop
Case $idMsg = $mond
$sComboRead = GUICtrlRead($mond)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\scroll.mp3",0)
select
case $sComboRead = $primermes
global $mes = "01"
case $sComboRead = $mes2
global $mes = "02"
case $sComboRead = $mes3
global $mes = "03"
case $sComboRead = $mes4
global $mes = "04"
case $sComboRead = $mes5
global $mes = "05"
case $sComboRead = $mes6
global $mes = "06"
case $sComboRead = $mes7
global $mes = "07"
case $sComboRead = $mes8
global $mes = "08"
case $sComboRead = $mes9
global $mes = "09"
case $sComboRead = $mes10
global $mes = "10"
case $sComboRead = $mes11
global $mes = "11"
case $sComboRead = $mes12
global $mes = "12"
EndSelect
Case $idMsg = $idagenda1 And BitAND(GUICtrlRead($idagenda1), $GUI_CHECKED) = $GUI_CHECKED
$anotar="False"
$notificar="False"
$mandar="true"
GUICtrlSetState($label7,$GUI_HIDE)
GUICtrlSetState($IDaviso,$GUI_HIDE)
GUICtrlSetState($label8,$GUI_HIDE)
GUICtrlSetState($IDaviso2,$GUI_HIDE)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\radio.MP3",0)
Case $idMsg = $idagenda2 And BitAND(GUICtrlRead($idagenda2), $GUI_CHECKED) = $GUI_CHECKED
$mandar="False"
$notificar="False"
$anotar="true"
GUICtrlSetState($label7,$GUI_HIDE)
GUICtrlSetState($IDaviso,$GUI_HIDE)
GUICtrlSetState($label8,$GUI_HIDE)
GUICtrlSetState($IDaviso2,$GUI_HIDE)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\radio.MP3",0)
Case $idMsg = $idagenda3 And BitAND(GUICtrlRead($idagenda3), $GUI_CHECKED) = $GUI_CHECKED
$mandar="False"
$anotar="False"
$notificar="true"
GUICtrlSetState($Label7,$GUI_SHOW)
GUICtrlSetState($IDAviso,$GUI_SHOW)
GUICtrlSetState($Label8,$GUI_SHOW)
GUICtrlSetState($IDAviso2,$GUI_SHOW)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\radio.MP3",0)
Case $idMsg = $idAviso
$sComboRead = GUICtrlRead($idAviso)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\scroll.mp3",0)
IniWrite("config\config.st", "General Settings", "Notify", $sComboRead)
select
case $sComboRead = $mopcion8
beep(2000, 180)
case $sComboRead = $mopcion9
SoundPlay(@WindowsDir & "\media\Windows Notify System Generic.wav", 0)
;notifyBeep()
case $sComboRead = $mopcion10
beep(2000, 180)
SoundPlay(@WindowsDir & "\media\Windows Notify System Generic.wav", 0)
EndSelect
Case $idMsg = $idAviso2
$sComboRead2 = GUICtrlRead($idAviso2)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\scroll.mp3",0)
select
case $sComboRead2 = "Beep"
beep(880, 500)
EndSelect
SoundPlay(@TempDir &"\sounds\soundsdata.dat\" &$sComboRead2, 0)
if @error then
Msgbox(0, "Error", "Impossible to play")
EndIf
IniWrite("config\config.st", "General Settings", "Sound", $sComboRead2)
Case $idMsg = $idCuantosminutos
$sComboRead3 = GUICtrlRead($idCuantosminutos)
$minuto = GUICtrlRead($minute)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\scroll.mp3",0)
select
case $sComboRead3 = $mopcion12b
global $minutoresta = $minuto
case $sComboRead3 = "5 minutos antes" or "5 minutes before"
global $minutoresta = $minuto -5
case $sComboRead2 = "10 minutos antes" or "10 minutes before"
global $minutoresta = $minuto -10
case $sComboRead3 = "15 minutos antes" or "15 minutes before"
global $minutoresta = $minuto -15
case $sComboRead3 = "30 minutos antes" or "30 minutes before"
global $minutoresta = $minuto -30
case $sComboRead3 = "45 minutos antes" or "45 minutes before"
global $minutoresta = $minuto -45
EndSelect
case $idMsg = $BTNOk
Speaking("OK, configurando tu agenda!")
sleep(250)
Global $nombredeagenda = GUICtrlRead($name)
if $nombredeagenda ="" then
$nombredeagenda = $aGendaSinTitulo
EndIf
Global $descripcion = GUICtrlRead($desc)
if $descripcion ="" then
$descripcion = $DescSinTitulo
EndIf
;Global $mes = GUICtrlRead($mond)
Global $dia = GUICtrlRead($day)
Global $hora = GUICtrlRead($hour)
Global $horafinal = GUICtrlRead($hourend)
Global $minuto = GUICtrlRead($minute)
Global $minutofinal = GUICtrlRead($minuteend)
Global $segundo = GUICtrlRead($second)
Global $segundofinal = GUICtrlRead($secondend)
if $segundo ="" then
$segundo = "00"
EndIf
IniWrite("config\" &$nombredeagenda &".ini", "Schedule", "Name", $nombredeagenda)
IniWrite("config\" &$nombredeagenda &".ini", "Schedule", "Description", $descripcion)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Mont", $mes)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Day", $dia)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Hour", $hora)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Hour End", $horafinal)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Minute", $minuto)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Minute end", $minutofinal)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Second", $segundo)
IniWrite("config\" &$nombredeagenda &".ini", "Date", "Second end", $segundofinal)
MSGBox(0, $mensaje7 &" " &@username, $mensaje8 &" " &$nombredeagenda &" " &$mensaje9a &" " &$dia &"/" &$mes &"/" &@year &" " &$mensaje9 &" " &$hora &":" &$minuto &":" &$segundo &$mensaje9b &$horafinal &":" &$minutofinal &":" &$segundofinal &". " &$mensaje10)
GUISetState(@SW_Hide, $Guioptions)
if $mandar ="" and $anotar ="" and $notificar ="" then
msgbox(0, "Error", $mopcion17)
ExitLoop
guiDelete($guioptions)
EndIf
if $mandar ="true" then
$aestecorreo=Inputbox($mopcion1, $mopcion2)
Local $sMsg = ""
$program="Mi agenda programada"
Select
case $sLanguage ="es"
$buenosdias="Buenos días"
$buenastardes="Buenas tardes"
$buenasnoches="Buenas noches"
$saludo4="Hola "
case $sLanguage ="eng"
$buenosdias="Good morning"
$buenastardes="Good afternoon"
$buenasnoches="Good night"
$saludo4="Hello "
EndSelect
Switch @HOUR
Case 6 To 11
$sMsg = $buenosdias
Case 12 To 17
$sMsg = $buenastardes
Case 18 To 21
$sMsg = $buenasnoches
Case Else
$sMsg = $saludo4
EndSwitch
select
case $sLanguage ="es"
$FromName = "Mini Calendario &agenda"
$Su1="Recordatorio de agenda"
$Subject = ($program &$su1)
$gr="Gracias, agenda de mini calendar and scheduler."
$mensaje= $sMsg &" " &@username &", " &@crlf &"Te recordamos que tienes una agenda para el " &$dia &"/" &$mes &"/" &@year &$mensaje9 &$hora &":" &$minuto &":" &$segundo &$mensaje9b &$horafinal &":" &$minutofinal &":" &$segundofinal &"." &@crlf &"Nombre de tu agenda: " &$nombredeagenda &@crlf &"Descripción: " &$descripcion &@crlf
$Body = ($mensaje &@crlf &$gr)
case $sLanguage ="eng"
$FromName = "Mini Calendar&scheduler"
$Su1="Schedule reminder"
$Subject = ($program &@username &$su1)                   ; subject from the email - can be anything you want it to be
$gr="Thank you, mini calendar and scheduler."
$mensaje= $sMsg &" " &@username &", " &@crlf &"We remind you that you have an schedule for him " &$dia &"/" &$mes &"/" &@year &MENSAJE9B &$HORAFINAL &":" &$MINUTOFINAL &":" &$SEGUNDOFINAL &"." &@crlf &"Name of your schedule: " &$nombredeagenda &@crlf &"Description: " &$descripcion &@crlf
$Body = ($mensaje &@crlf &$gr)                              ; the messagebody from the mail - can be left blank but then you get a blank mail
endselect
$SmtpServer = "smtp.gmail.com"
$FromAddress = "midimusic@outlook.es"
$ToAddress = $aestecorreo
$AttachFiles = ""
$CcAddress = ""
$BccAddress = ""
$Importance = "High"
$Username = "Reporterodeerrores"
$Password = "charli123"
$IPPort = 25
$ssl = 1
_SednMail ($SmtpServer, $FromName, $FromAddress, "angelitomateocedillo@gmail.com", $Subject, $Body &"Correo electrónico del agendador: " &$aestecorreo, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
MSGBox(0, $mopcion3, $mopcion4)
While 1
if @MON = $mes and @MDAY = $dia and @HOUR = $hora and @MIN = $minutoresta and @SEC = $segundo then
speaking($mopcion15)
_SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
sleep(800)
speaking($mopcion16 &$aestecorreo)
EndIf
Wend
GUISetState(@SW_SHOW, $guioptions)
EndIf
if $anotar ="true" then
speaking("Anotando agenda, por favor espera...")
sleep(400)
$scFile = FileOpen($mensaje5a &"\" &$mensaje5b &" " &@year &".txt",$FC_OVERWRITE  + $FC_CREATEPATH)
FileWrite($SCFile, $mensaje1 &": " &$nombredeagenda &@crlf &$mensaje2 &": " &$descripcion &@crlf &$mensaje3 &": " &$dia &@crlf &$mensaje3a &": " &$mes &@crlf &$mensaje4 &": " &$hora &@crlf &$MENSAJE4A &": " &$HORAFINAL &@crlf &$mensaje5 &": " &$minuto &@crlf &$mensaje5c &": " &$minutofinal &@crlf &$mensaje6 &": " &$segundo &@crlf &$mensaje6a &": " &$segundofinal &@crlf)
sleep(50)
FileClose($SCFile)
msgbox(0, $mopcion3, $mopcion5 &@year &".txt. " &$mopcion6)
ExitLoop
EndIf
if $notificar ="true" then
MSGBox(0, $mopcion3, $mopcion13 &$sComboRead &$sComboRead3 &$mopcion14)
notificar()
EndIf
Case $idMsg = $idBTN_Close
guiDelete($guioptions)
GUISetState(@SW_SHOW, $gui_Main)
ExitLoop
EndSelect
WEnd
EndFunc
Func _SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
Global $oMyRet[2]
Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
$rc = _INetSmtpMailCom($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
If @error Then
MsgBox(0, "Error sending message", "Error code:" & @error & "  Description:" & $rc)
EndIf
endfunc
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", $s_CcAddress = "", $s_BccAddress = "", $s_Importance="Normal", $s_Username = "", $s_Password = "", $IPPort = 465, $ssl = 1)
Local $objEmail = ObjCreate("CDO.Message")
$objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
$objEmail.To = $s_ToAddress
Local $i_Error = 0
Local $i_Error_desciption = ""
If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress
$objEmail.Subject = $s_Subject
If StringInStr($as_Body, "<") And StringInStr($as_Body, ">") Then
$objEmail.HTMLBody = $as_Body
Else
$objEmail.Textbody = $as_Body & @CRLF
EndIf
If $s_AttachFiles <> "" Then
Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
For $x = 1 To $S_Files2Attach[0]
$S_Files2Attach[$x] = _PathFull($S_Files2Attach[$x])
;~          ConsoleWrite('@@ Debug : $S_Files2Attach[$x] = ' & $S_Files2Attach[$x] & @LF & '>Error code: ' & @error & @LF) ;### Debug Console
If FileExists($S_Files2Attach[$x]) Then
ConsoleWrite('+> File attachment added: ' & $S_Files2Attach[$x] & @LF)
$objEmail.AddAttachment($S_Files2Attach[$x])
Else
ConsoleWrite('!> File not found to attach: ' & $S_Files2Attach[$x] & @LF)
SetError(1)
Return 0
EndIf
Next
EndIf
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
If Number($IPPort) = 0 then $IPPort = 25
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort
;Authenticated SMTP
If $s_Username <> "" Then
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
EndIf
If $ssl Then
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
EndIf
;Update settings
$objEmail.Configuration.Fields.Update
; Set Email Importance
Switch $s_Importance
Case "High"
$objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "High"
Case "Normal"
$objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "Normal"
Case "Low"
$objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "Low"
EndSwitch
$objEmail.Fields.Update
; Sent the Message
$objEmail.Send
If @error Then
SetError(2)
Return $oMyRet[1]
EndIf
$objEmail=""
EndFunc   ;==>_INetSmtpMailCom
Func MyErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
    $oMyRet[0] = $HexNumber
    $oMyRet[1] = StringStripWS($oMyError.description, 3)
    ConsoleWrite("### COM Error !  Number: " & $HexNumber & "   ScriptLine: " & $oMyError.scriptline & "   Description:" & $oMyRet[1] & @LF)
    SetError(1); something to check for when this function returns
    Return
EndFunc   ;==>MyErrFunc
func notificar()
$notificacion = iniRead ("config\config.st", "General Settings", "Notify", "")
$sonidoparareproducir = iniRead ("config\config.st", "General Settings", "Sound", "")
While 1
if @MON = $mes and @MDAY = $dia and @HOUR = $hora and @MIN = $minutoresta and @SEC = $segundo then
select
case $notificacion = $mopcion8
SoundPlay(@TempDir &"\sounds\soundsdata.dat\" &$sonidoparareproducir,0)
case $notificacion = $mopcion9
TrayTip($recordar1, $recuerda &$nombredeagenda &$mensaje9a &" " &$dia &"/" &$mes &"/" &@year &" " &$mensaje9 &" " &$hora &":" &$minuto &":" &$segundo &" " &$mensaje9b &$horafinal &":" &$minutofinal &":" &$segundofinal, 0, $TIP_ICONASTERISK)
speaking($recuerda &$nombredeagenda &$mensaje9a &" " &$dia &"/" &$mes &"/" &@year &" " &$mensaje9 &" " &$hora &":" &$minuto &":" &$segundo &$mensaje9b &$horafinal &":" &$minutofinal &":" &$segundofinal)
case $notificacion = $mopcion10
SoundPlay(@TempDir &"\sounds\soundsdata.dat\" &$sonidoparareproducir,0)
TrayTip($recordar1, $recuerda &$nombredeagenda &$mensaje9a &" " &$dia &"/" &$mes &"/" &@year &" " &$mensaje9 &" " &$hora &":" &$minuto &":" &$segundo &" " &$mensaje9b &$horafinal &":" &$minutofinal &":" &$segundofinal, 0, $TIP_ICONASTERISK)
speaking($recuerda &$nombredeagenda &$mensaje9a &" " &$dia &"/" &$mes &"/" &@year &" " &$mensaje9 &" " &$hora &":" &$minuto &":" &$segundo &$mensaje9b &$horafinal &":" &$minutofinal &":" &$segundofinal)
EndSelect
EndIf
sleep(100)
Wend
EndFunc
Func report()
$program="Mini Calendar, "
select
case $sLanguage ="es"
$mensaje=InputBox("Errores y sugerencias", "Cuál es tu reporte o sugerencia?", "", " M2000")
if $mensaje="" then
$mensaje="Este mensaje está en blanco..."
endif
$yourname=InputBox("tu nombre", "A continuación, escribe tu nombre en este campo", "")
if $yourname="" then
$yourname="Alguien sin identificarse"
endif
$combo=InputBox("Correo Electrónico, opcional", "Escribe tu correo electrónico en caso de que necesitemos ponernos en contacto contigo.", "")
if $combo="" then
$combo="No se ha especificado."
endif
$correo="Correo electrónico: " (&$combo)
$FromName = "Reportero de errores"                      ; name from who the email was sent
$Su1=" nos ha enbiado un reporte de error"
$Subject = ($program &$yourname &$su1)                   ; subject from the email - can be anything you want it to be
$gr="Gracias, el reportero de errores."
$Body = ($mensaje &@crlf &$correo &@crlf &$gr)                             ; the messagebody from the mail - can be left blank but then you get a blank mail
case $sLanguage ="eng"
$mensaje=InputBox("Errors and suggestions", "What is your report or suggestion?", "")
if $mensaje="" then
$mensaje="This message is blank ..."
endif
$yourname=InputBox("Your name", "write your name in this field below:", "", " M2000")
if $yourname="" then
$yourname="Someone unidentified"
endif
$combo=InputBox("Email, optional", "Write your email in case we need to contact you.", "")
if $combo="" then
$combo="Not specified."
endif
$correo="Email: " (&$combo)
$FromName = "Bug reporter"                      ; name from who the email was sent
$Su1=" You have sent us an error report"
$Subject = ($program &$yourname &$su1)                   ; subject from the email - can be anything you want it to be
$gr="Thanks, the bug reporter."
$Body = ($mensaje &@crlf &$correo &@crlf &$gr)                              ; the messagebody from the mail - can be left blank but then you get a blank mail
endselect
$SmtpServer = "smtp.gmail.com"              ; address for the smtp-server to use - REQUIRED
$FromAddress = "midimusic@outlook.es" ; address from where the mail should come
$ToAddress = "angelitomateocedillo@gmail.com"   ; destination address of the email - REQUIRED
$AttachFiles = ""                       ; the file(s) you want to attach seperated with a ; (Semicolon) - leave blank if not needed
$CcAddress = ""       ; address for cc - leave blank if not needed
$BccAddress = ""     ; address for bcc - leave blank if not needed
$Importance = "High"                  ; Send message priority: "High", "Normal", "Low"
$Username = "Reporterodeerrores"                    ; username for the account used from where the mail gets sent - REQUIRED
$Password = "charli123"
$IPPort = 25                            ; port used for sending the mail
$ssl = 1                                ; enables/disables secure socket layer sending - put to 1 if using httpS
;~ $IPPort=465                          ; GMAIL port used for sending the mail
;~ $ssl=1                               ; GMAILenables/disables secure socket layer sending - put to 1 if using httpS
_SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
EndFunc
Func notifyBeep()
beep(520, 120)
beep(655, 120)
beep(390, 120)
beep(262, 700)
EndFunc
func ReadChanges2()
$grLanguage = iniRead ("config\config.st", "General settings", "language", "")
select
case $grlanguage ="es"
Local $manualdoc = "documentation\changes1.txt"
$editmessage1="Manual del usuario."
$editmessage2="No se encuentra el archivo."
$editmessage3="abriendo..."
$editmessage4="Ocurrió un error al leer el archivo."
$editmessage5="error"
case $grlanguage ="eng"
Local $manualdoc = "documentation\changes2.txt"
$editmessage1="User manual."
$editmessage2="The file cannot be found."
$editmessage3="opening..."
$editmessage4="An error occurred while reading the file."
$editmessage5="error"
endSelect
Local $DocOpen = FileOpen($manualdoc, $FO_READ)
ToolTip($editmessage3)
speaking($editmessage3)
sleep(200)
If $DocOpen = -1 Then
MsgBox($MB_SYSTEMMODAL, $editmessage5, $editmessage4)
Return False
EndIf
Local $openned = FileRead($DocOpen)
$manualwindow = GUICreate($manualdoc)
Local $idMyedit = GUICtrlCreateEdit($openned, 8, 92, 121, 97, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY, $WS_VSCROLL, $WS_VSCROLL, $WS_CLIPSIBLINGS))
GUISetState(@SW_SHOW)
; Loop until the user exits.
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
FileClose($DocOpen)
ExitLoop
EndSwitch
WEnd
GUIDelete()
EndFunc
