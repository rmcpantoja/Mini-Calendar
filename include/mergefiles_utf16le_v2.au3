func CreatePack($filetype, $bigfilename)
Global $fileopen
Global $fileread
Global $bigfile
$filelist =  _GetFilesFolder_Rekursiv(@ScriptDir, $filetype, 0, 0)
For $i = 1 to $filelist[0]
$fileopen = FileOpen ($filelist[$i], 32)
$fileread = FileRead ($fileopen)

$bigfile = FileOpen ($bigfilename, 33)
FileWrite ($bigfile, @CRLF & @CRLF & "[[IFAYILE:" & $filelist[$i] & ":IFAYILE]]" & @CRLF & @CRLF & $fileread)
FileClose ($bigfile)

Next
endFunc
;======================================================================================
; Function Name:   _GetFilesFolder_Rekursiv($sPath [, $sExt='*' [, $iDir=-1 [, $iRetType=0 ,[$sDelim='0']]]])
; Description:     recursive listing of files and/or folders
; Parameter(s):    $sPath     Basicpath of listing ('.' -current path, '..' -parent path)
;                  $sExt      Extension for file selection '*' or -1 for all (Default)
;                  $iDir      -1 files+Folder(Default), 0 only files, 1 only Folder
;      optional:   $iRetType  0 for Array, 1 for String as Return
;      optional:   $sDelim    Delimiter for string return
;                             0 -@CRLF (Default)  1 -@CR  2 -@LF  3 -';'  4 -'|'
; Return Value(s): Array (Default) or string with found pathes of files and/or folder
;                  Array[0] includes count of found files/folder
; Author(s):       BugFix (bugfix@autoit.de)

Func _GetFilesFolder_Rekursiv($sPath, $sExt='*', $iDir=-1, $iRetType=0, $sDelim='0')
Global $oFSO = ObjCreate('Scripting.FileSystemObject')
Global $strFiles = ''
Switch $sDelim
Case '1'
$sDelim = @CR
Case '2'
$sDelim = @LF
Case '3'
$sDelim = ';'
Case '4'
$sDelim = '|'
Case Else
$sDelim = @CRLF
EndSwitch
If ($iRetType < 0) Or ($iRetType > 1) Then $iRetType = 0
If $sExt = -1 Then $sExt = '*'
If ($iDir < -1) Or ($iDir > 1) Then $iDir = -1
_ShowSubFolders($oFSO.GetFolder($sPath),$sExt,$iDir,$sDelim)
If $iRetType = 0 Then
Local $aOut
$aOut = StringSplit(StringTrimRight($strFiles, StringLen($sDelim)), $sDelim, 1)
If $aOut[1] = '' Then
ReDim $aOut[1]
$aOut[0] = 0
EndIf
Return $aOut
Else
Return StringTrimRight($strFiles, StringLen($sDelim))
EndIf
EndFunc
Func _ShowSubFolders($Folder, $Ext='*', $Dir=-1, $Delim=@CRLF)
If Not IsDeclared("strFiles") Then Global $strFiles = ''
If ($Dir = -1) Or ($Dir = 0) Then
For $file In $Folder.Files
If $Ext <> '*' Then
If StringRight($file.Name, StringLen($Ext)) = $Ext Then _
$strFiles &= $file.Path & $Delim
Else
$strFiles &= $file.Path & $Delim
EndIf
Next
EndIf
For $Subfolder In $Folder.SubFolders
If ($Dir = -1) Or ($Dir = 1) Then $strFiles &= $Subfolder.Path & '\' & $Delim
_ShowSubFolders($Subfolder, $Ext, $Dir, $Delim)
Next
EndFunc