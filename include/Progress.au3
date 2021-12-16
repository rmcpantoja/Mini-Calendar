#include "audio.au3"
#include-once
global $count
Func CreateBeepProgress($numero)
If $numero < "0" Then
;msgbox(0, "Error", "Wrong value")
EndIf
If $numero > "100" Then
;msgbox(0, "Error", "Wrong value")
EndIf
Local $iFreqStart = 110
Local $iFreqEnd = 2.00
$count = 0
$count = $numero * 16.5
$progress = $iFreqStart * 1.5
beep($count, 60)
;msgbox(0, "count", $count)
EndFunc
Func CreateAudioProgress($numero)
if $numero <= 0 then
;msgbox(0, "Error", "Wrong value")
EndIf
if $numero >= 100 then
;msgbox(0, "Error", "Wrong value")
EndIf
Local $iFreqStart =0.01
Local $iFreqEnd = 2.00
$count = 0
$tin = $device.opensound (@ScriptDir &"\sounds/progress.ogg", 0)
$count = $numero *0.04
if $count = 0 then
$tin.pitchshift = 0.125
$tin.play()
Else
$progress = $IFreqstart *0.1
$tin.pitchshift = $count
$tin.play()
EndIf
;msgbox(0, "count", $count)
EndFunc
Func progresReverse()
Local $iFreqStart = 110
Local $iFreqEnd = 2.00
$tin = $device.opensound ("sounds/progress.ogg", 0)
For $iFreq = $iFreqEnd To $iFreqStart Step -0.02
$tin.pitchshift = $iFreq
$tin.play()
$count = $count -1
sleep(50)
Next
MsgBox(0, "_WinAPI_Beep Example", "Results: " &$count)
EndFunc   ;==>Example