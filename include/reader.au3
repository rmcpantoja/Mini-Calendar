#include-once
#include "kbc.au3"
#include "log.au3"
#include "jfw.au3"
#include "NVDAControllerClient.au3"
#include "sapi.au3"
#include "translator.au3"
global $idioma
;este es un script para los lectores de pantalla. this is a script for screen readers.
;Author: Mateo Cedillo.
Func speaking($text)
$speak = IniRead(@ScriptDir & "\config\config.st", "accessibility", "Speak Whit", "")
Select
Case $speak = "NVDA"
if @AutoItX64 = 1 then
_nvdaControllerClient_Load(@ScriptDir & "\nvdaControllerClient64.dll")
else
_nvdaControllerClient_Load()
EndIF
If @error Then
MsgBox(16, "error", "cant load the NVDA DLL file")
Else
;_NVDAControllerClient_CancelSpeech()
_NVDAControllerClient_SpeakText($text)
_NVDAControllerClient_BrailleMessage($text)
EndIf
Case $speak = "Sapi"
speak($text, 3)
Case $speak = "JAWS"
JFWSpeak($text)
Case Else
autodetect()
EndSelect
EndFunc   ;==>speaking
Func autodetect()
If ProcessExists("NVDA.exe") Then
IniWrite(@ScriptDir & "\config\config.st", "accessibility", "Speak Whit", "NVDA")
EndIf
If ProcessExists("JFW.exe") Then
IniWrite(@ScriptDir & "\config\config.st", "accessibility", "Speak Whit", "JAWS")
EndIf
If Not ProcessExists("NVDA.exe") Or ProcessExists("JFW.exe") Then
IniWrite(@ScriptDir & "\config\config.st", "accessibility", "Speak Whit", "Sapi")
EndIf
EndFunc   ;==>autodetect
Func TTsDialog($text, $ttsString = " press enter to continue, space to repeat information.")
$pressed = 0
$repeatinfo = 0
If ProcessExists("NVDA.exe") Then
_NVDAControllerClient_CancelSpeech()
EndIf
speaking($text & @LF & $ttsString)
While 1
$active_window = WinGetProcess("")
If $active_window = @AutoItPID Then
Else
Sleep(10)
ContinueLoop
EndIf
If _IsPressed($spacebar) Or _IsPressed($up) Or _IsPressed($down) Or _IsPressed($left) Or _IsPressed($right) Then
speaking($text & @LF & $ttsString)
While _IsPressed($spacebar) Or _IsPressed($up) or _IsPressed($down) Or _IsPressed($left) Or _IsPressed($right)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($c) Then
ClipPut($text)
speaking($text &" " &translate($idioma, "Copied to clipboard."))
While _IsPressed($control) And _IsPressed($c)
Sleep(100)
WEnd
EndIf
If _IsPressed($enter) Then
speaking("ok")
ExitLoop
While _IsPressed($enter)
Sleep(100)
WEnd
EndIf
Sleep(10)
WEnd
EndFunc   ;==>TTsDialog
Func createTtsOutput($filetoread, $title)
$move_doc = 0
Local $r_file = FileReadToArray($filetoread)
Local $iCountLines = @extended
$not = 0
$docError=0
$selectionmode = 0
local $textselected=""
If @error Then
speaking(translate($idioma, "Error reading file..."))
writeinlog("error reading file...")
$DocError=1
Else
speaking($title &" " &translate($idioma, "document.") &@crlf &translate($idioma, "Selection mode off"))
writeinlog("Dialog: " & $title)
writeinlog("file: " & $filetoread)
writeinlog("File information: Lines: " & $iCountLines)
EndIf
hotkeyset("{f1}")
While 1
if $DocError=1 then exitLoop
$active_window = WinGetProcess("")
If $active_window = @AutoItPID Then
Else
Sleep(10)
ContinueLoop
EndIf
If _IsPressed($f1) then
Speaking(translate($idioma, "Use the up and down arrows to read the document.") &@crlf &translate($idioma, "Use the home and end keys to go to the beginning or end of the document.") &@crlf &translate($idioma, "Use page up and page down to go forward or backward ten lines.") &@crlf &translate($idioma, "Use control + shift + s to open selection mode, which will allow you to select multiple text marks and perform editing commands and operations.") &@crlf &translate($idioma, "Use the l key to speak the line number you are on.") &@crlf &translate($idioma, "Use the editing commands to cut, copy, paste and select all the text."))
While _IsPressed($f1)
Sleep(100)
WEnd
EndIf
If _IsPressed($home) then
If $selectionmode=1 then
if not $textselected = "" then
Speaking(translate($idioma, "Unselected"))
$textselected = ""
EndIf
EndIF
$move_doc = "0"
speaking($r_file[$move_doc])
writeinlog($move_doc)
While _IsPressed($home)
Sleep(100)
WEnd
EndIf
If _IsPressed($page_down) Then
$move_doc = $move_doc +10
if $move_doc >= $iCountLines then
$move_doc = $iCountLines -1
speaking(translate($idioma, "document end. Press enter to back."))
EndIF
speaking($r_file[$move_doc])
writeinlog($move_doc)
While _IsPressed($page_down)
Sleep(100)
WEnd
EndIf
If _IsPressed($page_up) Then
$move_doc = $move_doc -10
if $move_doc <= 0 then $move_doc="0"
speaking($r_file[$move_doc])
writeinlog($move_doc)
While _IsPressed($page_up)
Sleep(100)
WEnd
EndIf
If _IsPressed($end) Then
If $selectionmode = 1 then
if not $textselected = "" then
Speaking(translate($idioma, "Unselected"))
$textselected = ""
EndIf
EndIf
$move_doc = $iCountLines -1
speaking($r_file[$move_doc] &@crlf &translate($idioma, "document end. Press enter to back."))
writeinlog($move_doc)
While _IsPressed($end)
Sleep(100)
WEnd
EndIf
If _IsPressed($up) Then
$move_doc = $move_doc - 1
if $move_doc <= 0 then
If $selectionmode=1 then speaking(translate($idioma, "You have reached the home of the document, there is nothing else to select."))
$move_doc="0"
EndIf
If $selectionmode=1 then 
$textselected &= $r_file[$move_doc] &@crlf
speaking(translate($idioma, "Was selected") &" " &$r_file[$move_doc])
Else
speaking($r_file[$move_doc])
writeinlog($move_doc)
EndIf
While _IsPressed($up)
if $selectionmode = 1 then beep(4000, 50)
Sleep(100)
WEnd
EndIf
If _IsPressed($down) then
$move_doc = $move_doc +1
if $move_doc >= $iCountLines then
If $selectionmode=1 then speaking(translate($idioma, "You have reached the end of the document, there is nothing else to select."))
speaking("document end. Press enter to back.")
$move_doc=$iCountLines -1
EndIF
If $selectionmode = 1 then
$textselected &= $r_file[$move_doc] &@crlf
speaking(translate($idioma, "Was selected") &" " &$r_file[$move_doc])
else
speaking($r_file[$move_doc])
writeinlog($move_doc)
EndIf
While _IsPressed($down)
If $selectionmode = 1 then beep(4000, 50)
Sleep(100)
WEnd
EndIf
If _IsPressed($l) then
Speaking(translate($idioma, "Line:") &" " &$move_doc)
While _IsPressed($l)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($c) then
if $textSelected = "" then
Speaking(translate($idioma, "You have not selected text to copy!"))
Else
ClipPut($textselected)
Speaking(translate($idioma, "the text has been copied to that clipboard"))
if $selectionmode=1 then $selectionmode=0
EndIf
While _IsPressed($control) And _IsPressed($c)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($a) Then
speaking(translate($idioma, "Selecting all..."))
for $selecting = 0 to $iCountLines - 1
$textselected = $r_file[$selecting]
Next
Speaking(translate($idioma, "All text was selected"))
if $selectionmode=1 then $selectionmode=0
While _IsPressed($control) And _IsPressed($a)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($shift) And _IsPressed($s) Then
if not $selectionmode = 0 then
Speaking(translate($idioma, "He left the selection mode"))
$selectionmode=0
Else
speaking(translate($idioma, "Entered to the selection mode"))
$selectionmode=1
EndIf
While _IsPressed($control) And _IsPressed($shift) And _IsPressed($s)
Sleep(100)
WEnd
EndIf
If _IsPressed($enter) Then
return $move_doc
$not = 0
ExitLoop
EndIf
Sleep(10)
WEnd
EndFunc   ;==>createTtsOutput