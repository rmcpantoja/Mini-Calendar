func desencriptar()
speaking("Comprovando paquete de sonidos...")
Global $fileopen
Global $fileread
Global $bigfile
Global $secondsplit
Global $splitfileopen
$bigfilename = "soundsdata.dat"
$fileopen = FileOpen ($bigfilename, 32)
$fileread = FileRead ($fileopen)

$firstsplit = StringSplit ($fileread, @CRLF & @CRLF & "[[IFAYILE:", 1)

For $i = 2 to $firstsplit[0]

$secondsplit = StringSplit ($firstsplit[$i], ":IFAYILE]]" & @CRLF & @CRLF, 1)

If FileExists ($secondsplit[1]) Then
MsgBox (0, "", "File already exists... exiting...", 0)
Exit
Else

$dirsplit = StringSplit ($secondsplit[1], "\", 1)
$filename = $dirsplit[$dirsplit[0]]
$getdir = StringSplit ($secondsplit[1], $filename, 1)
$diris = $getdir[1]

DirCreate($diris)
FileChangeDir ($diris)

$thisfile = FileOpen ($filename, 33)
FileWrite ($thisfile, $secondsplit[2])
FileClose ($thisfile)
EndIf

Next
sleep(2000)
SPEAKING("Listo")
EndFunc