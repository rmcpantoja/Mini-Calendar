#include <fileConstants.au3>
Global $ifSabe = IniRead("config\config.st", "General settings", "Sabe Logs", "")
Select
	Case $ifSabe = "yes"
		Local $logfile = FileOpen("logs\" & @YEAR & @MON & @MDAY & ".log", $FC_OVERWRITE + $FC_CREATEPATH)
	Case $ifSabe = "no"
		Sleep(5)
	Case Else
		IniWrite("config\config.st", "General settings", "Sabe Logs", "Yes")
EndSelect
Func writeinlog($text)
	If $ifSabe = "yes" Then
		FileWrite($logfile, @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ": " & $text & @CRLF)
	EndIf
EndFunc   ;==>writeinlog
Func ___DeBug($iError, $sAction)
	Switch $iError
		Case -1
			FileWrite($logfile, @CRLF & "-" & $sAction & @CRLF)
		Case 0
			FileWrite($logfile, @CRLF & "+" & $sAction & " - OK" & @CRLF)
		Case Else
			FileWrite($logfile, @CRLF & "!" & $sAction & " - FAILED" & @CRLF)
			Exit
	EndSwitch
EndFunc   ;==>___DeBug
