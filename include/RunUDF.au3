#include <FileConstants.au3>
#include <FTPEx.au3>
Global $rundata = ""
Global $openfile = ""
Global $program = ""
func Register_Run($program)
;Ftp:
$sServer = "ftpupload.net"
$sUsername = "n260m_27330965"
$sPass = "mrcp123"
Local $hOpen = _FTP_Open("mateocedillo.260mb.net")
;Ftp connect:
Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)
If @error Then
MsgBox(16, "Error", "Unable to connect to server: Reason: " & @error)
EndIf
;Set variable for file:
$openfile = $program &".txt"
;Get the current execution number from the server.
$getfile = _FTP_FileGet ($hConn, "htdocs/runs/" &$openfile, @TempDir &"\" &$openfile)
If @error then
beep(1000, 100)
EndIf
$abrirlocal = FileOpen(@TempDir &"\" &$openfile, $FO_READ)
;Read statistics from local file:
$getdata = FileRead($abrirlocal)
If @error then
beep(1000, 200)
EndIf
;Apply operations:
$rundata = _RunData($getdata)
FileClose ($abrirlocal)
sleep(200)
;Send the file with the sum of the new execution:
$Enviararchivo = _FTP_FilePut ($hConn, @tempDir &"\" &$program &".txt", "htdocs/runs/" &$program &".txt")
if @error then
beep(1000, 500)
EndIf
;MsgBox(0, "This program has been ran", $rundata &" Times")
sleep(200)
;Close all:
FileDelete(@TempDir &"\" &$program &".txt")
Local $iFtpc = _FTP_Close($hConn)
Local $iFtpo = _FTP_Close($hOpen)
EndFunc

Func _RunData($_vGetData)
Local $vGetData = Number(StringStripWS($_vGetData, 8))
Local $sFilePath = @tempDir & "\" &$openfile
;~ Create a new blank file
Local $hFilePath = FileOpen($sFilePath, 10)
FileClose($hFilePath)
If $vGetData = "" Then
FileWrite($sFilePath, 1)
Else
FileWrite($sFilePath, Number($vGetData) + 1)
EndIf
Return $vGetData + 1
EndFunc
Func _LocalRun($program)
Local $sNumber, $sFilePath = @tempDir & "\" &$program &".txt"
If Not FileExists($sFilePath) Then
;~ If file doesn't exist, create a new blank file
Local $hFilePath = FileOpen($sFilePath, 10)
FileClose($hFilePath)
Else
;~ Read file content
$sNumber = FileRead($sFilePath)
;~ Check if the file is blank or not
If StringStripWS($sNumber, 8) = "" Then
;~ If blank write the first count
FileWrite($sFilePath, 1)
Else
;~ Add + 1 and write the results to the first line of the file
_FileWriteToLine($sFilePath, 1, Number($sNumber) + 1, True)
EndIf
EndIf
EndFunc
Func __FileWriteToLine($sFilePath, $iLine, $sText, $bOverWrite = False, $bFill = False)
If $bOverWrite = Default Then $bOverWrite = False
If $bFill = Default Then $bFill = False
If Not FileExists($sFilePath) Then Return SetError(2, 0, 0)
If $iLine <= 0 Then Return SetError(4, 0, 0)
If Not (IsBool($bOverWrite) Or $bOverWrite = 0 Or $bOverWrite = 1) Then Return SetError(5, 0, 0)
If Not IsString($sText) Then
$sText = String($sText)
If $sText = "" Then Return SetError(6, 0, 0)
EndIf
If Not IsBool($bFill) Then Return SetError(7, 0, 0)
; Read current file into array
Local $aArray = FileReadToArray($sFilePath)
; Create empty array if empty file
If @error Then Local $aArray[0]
Local $iUBound = UBound($aArray) - 1
; If Fill option set
If $bFill Then
; If required resize array to allow line to be written
If $iUBound < $iLine Then
ReDim $aArray[$iLine]
$iUBound = $iLine - 1
EndIf
Else
If ($iUBound + 1) < $iLine Then Return SetError(1, 0, 0)
EndIf
; Write specific line - array is 0-based so reduce by 1 - and either replace or insert
$aArray[$iLine - 1] = ($bOverWrite ? $sText : $sText & @CRLF & $aArray[$iLine - 1])
; Concatenate array elements
Local $sData = ""
For $i = 0 To $iUBound
$sData &= $aArray[$i] & @CRLF
Next
$sData = StringTrimRight($sData, StringLen(@CRLF)) ; Required to strip trailing EOL
; Write data to file
Local $hFileOpen = FileOpen($sFilePath, FileGetEncoding($sFilePath) + $FO_OVERWRITE)
If $hFileOpen = -1 Then Return SetError(3, 0, 0)
FileWrite($hFileOpen, $sData)
FileClose($hFileOpen)
Return 1
EndFunc   ;==>_FileWriteToLine