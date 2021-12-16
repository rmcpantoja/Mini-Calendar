#cs ----------------------------------------------------------------------------
*Spanish:
say UDF 0.6 abril 2021
Soporte para Sapi5 y JAWS usando el UDF "Reader".
Corrección de errores.
say UDF 0.5 enero 2021
Agregado el soporte para las teclas especiales.
Mejoras de estabilidad y rendimiento.
Reescrito este script. ahora se usan otros atrivutos para el UDF.
Ahora antes de anunciar cualquier texto, se cancela la voz primero.
Mejoras en verbalizar capturas de textos del portapapeles.
*ENglish:
say UDF 0.6 April 2021
Support for Sapi5 and JAWS using the "reader" UDF.
Error correction.
say UDF 0.5 January 2021
Added support for special keys.
Stability and performance improvements.
Rewritten this script. now other attributes are used for the UDF.
Now before announcing any text, the speech is canceled first.
Improvements in saying text captures from the clipboard.
#ce ----------------------------------------------------------------------------
$Say_UDfversion = "0.6"
Global $say = "1"
$Lang = IniRead("config\config.st", "General settings", "language", "")
$tipedText = ""
Func configure_key()
Switch @HotKeyPressed
Case "{f3}"
Select
Case $Lang = "es"
speaking("Hablar mientras escribes desactivado")
Case $Lang = "eng"
speaking("speak while typing off")
EndSelect
$say = "0"
Case "{f2}"
Select
Case $Lang = "es"
speaking("Hablar mientras escribes activado")
Case $Lang = "eng"
speaking("speak while typing on")
EndSelect
$say = "1"
EndSwitch
HotKeySet("{enter}", "say")
HotKeySet("{space}", "say")
HotKeySet("{escape}", "say")
HotKeySet("{del}", "say")
HotKeySet("{bs}", "say")
HotKeySet("{up}", "say")
HotKeySet("{down}", "say")
HotKeySet("{left}", "say")
HotKeySet("{right}", "say")
HotKeySet("{home}", "say")
HotKeySet("{end}", "say")
HotKeySet("{PGUP}", "say")
HotKeySet("{PGDN}", "say")
HotKeySet("a", "say")
HotKeySet("b", "say")
HotKeySet("c", "say")
HotKeySet("d", "say")
HotKeySet("e", "say")
HotKeySet("f", "say")
HotKeySet("g", "say")
HotKeySet("h", "say")
HotKeySet("i", "say")
HotKeySet("j", "say")
HotKeySet("k", "say")
HotKeySet("l", "say")
HotKeySet("m", "say")
HotKeySet("n", "say")
HotKeySet("ñ", "say")
HotKeySet("o", "say")
HotKeySet("p", "say")
HotKeySet("q", "say")
HotKeySet("r", "say")
HotKeySet("s", "say")
HotKeySet("t", "say")
HotKeySet("u", "say")
HotKeySet("v", "say")
HotKeySet("w", "say")
HotKeySet("x", "say")
HotKeySet("y", "say")
HotKeySet("z", "say")
HotKeySet("1", "say")
HotKeySet("2", "say")
HotKeySet("3", "say")
HotKeySet("4", "say")
HotKeySet("5", "say")
HotKeySet("6", "say")
HotKeySet("7", "say")
HotKeySet("8", "say")
HotKeySet("9", "say")
HotKeySet("0", "say")
HotKeySet("^z", "say")
HotKeySet("^x", "say")
HotKeySet("^c", "say")
HotKeySet("^v", "say")
HotKeySet("^a", "say")
HotKeySet("^y", "say")
EndFunc   ;==>configure_key
Func say()
HotKeySet("{f2}", "configure_key")
HotKeySet("{f3}", "configure_key")
If $say = "1" Then
Switch @HotKeyPressed
Case "{enter}"
speaking("enter")
$tipedText &= @CRLF
Case "{space}"
Select
Case $Lang = "es"
speaking("Espacio")
Case $Lang = "eng"
speaking("Space")
EndSelect
$tipedText &= " "
Case "{escape}"
speaking("escape")
Case "{del}"
Select
Case $Lang = "es"
speaking("Borrar")
Case $Lang = "eng"
speaking("Delete")
EndSelect
Case "{up}"
speaking($tipedText)
Case "{down}"
speaking($tipedText)
Case "{left}"
Select
Case $Lang = "es"
speaking("Flecha izquierda")
Case $Lang = "eng"
speaking("left")
EndSelect
Case "{right}"
Select
Case $Lang = "es"
speaking("Flecha derecha")
Case $Lang = "eng"
speaking("Right")
EndSelect
Case "{PGUP}"
Select
Case $Lang = "es"
speaking("Avance de página")
Case $Lang = "eng"
speaking("page up")
EndSelect
Case "{PGDN}"
Select
Case $Lang = "es"
speaking("Retroceso de página")
Case $Lang = "eng"
speaking("page down")
EndSelect
Case "{home}"
Select
Case $Lang = "es"
speaking("Inicio")
Case $Lang = "eng"
speaking("home")
EndSelect
Case "{end}"
Select
Case $Lang = "es"
speaking("Fin")
Case $Lang = "eng"
speaking("end")
EndSelect
Case "a"
speaking("a")
$tipedText &= "a"
Case "b"
speaking("b")
$tipedText &= "b"
Case "c"
speaking("c")
$tipedText &= "c"
Case "d"
speaking("d")
$tipedText &= "d"
Case "e"
speaking("e")
$tipedText &= "e"
Case "f"
speaking("f")
$tipedText &= "f"
Case "g"
speaking("g")
$tipedText &= "g"
Case "h"
speaking("h")
$tipedText &= "h"
Case "i"
speaking("i")
$tipedText &= "i"
Case "j"
speaking("j")
$tipedText &= "j"
Case "k"
speaking("k")
$tipedText &= "k"
Case "l"
speaking("l")
$tipedText &= "l"
Case "m"
speaking("m")
$tipedText &= "m"
Case "n"
speaking("n")
$tipedText &= "n"
Case "ñ"
speaking("ñ")
$tipedText &= "ñ"
Case "o"
speaking("o")
$tipedText &= "o"
Case "p"
speaking("p")
$tipedText &= "p"
Case "q"
speaking("q")
$tipedText &= "q"
Case "r"
speaking("r")
$tipedText &= "r"
Case "s"
speaking("s")
$tipedText &= "s"
Case "t"
speaking("t")
$tipedText &= "t"
Case "u"
speaking("u")
$tipedText &= "u"
Case "v"
speaking("v")
$tipedText &= "v"
Case "w"
speaking("w")
$tipedText &= "w"
Case "x"
speaking("x")
$tipedText &= "x"
Case "y"
speaking("y")
$tipedText &= "y"
Case "z"
speaking("z")
$tipedText &= "z"
Case "1"
speaking("1")
$tipedText &= "1"
Case "2"
speaking("2")
$tipedText &= "2"
Case "3"
speaking("3")
$tipedText &= "3"
Case "4"
speaking("4")
$tipedText &= "4"
Case "5"
speaking("5")
$tipedText &= "5"
Case "6"
speaking("6")
$tipedText &= "6"
Case "7"
speaking("7")
$tipedText &= "7"
Case "8"
speaking("8")
$tipedText &= "8"
Case "9"
speaking("9")
$tipedText &= "9"
Case "0"
speaking("0")
$tipedText &= "0"
Case "^z"
Sleep(100)
Select
Case $Lang = "es"
speaking("Deshacer")
Case $Lang = "eng"
speaking("undo")
EndSelect
Case "^x"
Sleep(100)
Local $Clipdata1 = ClipGet()
Select
Case $Lang = "es"
speaking("Se ha cortado " & $Clipdata1 & " desde el portapapeles.")
Case $Lang = "eng"
speaking($Clipdata1 & "it has been cut trom clipboard.")
EndSelect
Case "^c"
Sleep(100)
Local $Clipdata2 = ClipGet()
Select
Case $Lang = "es"
speaking("Se copió " & $Clipdata2 & " al portapapeles")
Case $Lang = "eng"
speaking($Clipdata2 & "Copied to clipboard.")
EndSelect
Case "^v"
Sleep(100)
Local $Clipdata3 = $tipedText
ClipPut($Clipdata3)
Select
Case $Lang = "es"
speaking($Clipdata3 & "pegado al campo de texto")
Case $Lang = "eng"
speaking($Clipdata3 & "Pasted into text box")
EndSelect
Case "^a"
Sleep(100)
Select
Case $Lang = "es"
speaking("Seleccionar todo")
Case $Lang = "eng"
speaking("Select all")
EndSelect
Case "^y"
Sleep(100)
Select
Case $Lang = "es"
speaking("Rehacer")
Case $Lang = "eng"
speaking("Redo")
EndSelect
case else
speaking(@HotKeyPressed)
EndSwitch
EndIf
EndFunc   ;==>say
