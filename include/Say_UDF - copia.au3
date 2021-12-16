#include "translator.au3"
$Say_UDfversion = "0.8"
Global $say = "0"
$tipedText = ""
Func SayCharacters()
While 1
$active_window = WinGetProcess("")
If $active_window = @AutoItPID Then
Else
Sleep(10)
ContinueLoop
EndIf
If _IsPressed($shift) And _IsPressed($f2) Then
speaking(translate($idioma, "speak while typing off"))
$say = 0
While _IsPressed($shift) And _IsPressed($f2)
Sleep(100)
WEnd
EndIf
If _IsPressed($shift) And _IsPressed($f3) Then
speaking(translate($idioma, "speak while typing on"))
$say = 1
While _IsPressed($shift) And _IsPressed($f3)
Sleep(100)
WEnd
EndIf
If _IsPressed($enter) Then
speaking("enter")
$tipedText &= @CRLF
While _IsPressed($enter)
Sleep(100)
WEnd
EndIf
If _IsPressed($spacebar) Then
speaking(translate($idioma, "Space"))
$tipedText &= " "
While _IsPressed($spacebar)
Sleep(100)
WEnd
EndIf
If _IsPressed($escape) Then
speaking("escape")
While _IsPressed($escape)
Sleep(100)
WEnd
EndIf
If _IsPressed($delete) Or _IsPressed($backspace) Then
speaking(translate($idioma, "Deleting") &StringRight($tipedText, 1))
$tipedText &= StringTrimRight($tipedText, 1)
While _IsPressed($delete) Or _IsPressed($backspace)
Sleep(100)
WEnd
EndIf
If _IsPressed($up) Then
speaking(translate($idioma, "Up"))
While _IsPressed($up)
Sleep(100)
WEnd
EndIf
If _IsPressed($down) Then
speaking(translate($idioma, "Down"))
While _IsPressed($down)
Sleep(100)
WEnd
EndIf
If _IsPressed($left) Then
speaking(translate($idioma, "left"))
While _IsPressed($left)
Sleep(100)
WEnd
EndIf
If _IsPressed($right) Then
speaking(translate($idioma, "Right"))
While _IsPressed($right)
Sleep(100)
WEnd
EndIf
If _IsPressed($page_up) Then
speaking(translate($idioma, "page up"))
While _IsPressed($page_up)
Sleep(100)
WEnd
EndIf
If _IsPressed($page_down) Then
speaking(translate($idioma, "page down"))
While _IsPressed($page_down)
Sleep(100)
WEnd
EndIf
If _IsPressed($home) Then
speaking(translate($idioma, "home"))
While _IsPressed($home)
Sleep(100)
WEnd
EndIf
If _IsPressed($end) Then
speaking(translate($idioma, "end"))
While _IsPressed($end)
Sleep(100)
WEnd
EndIf
If _IsPressed($a) then
speaking("a")
$tipedText &= "a"
While _IsPressed($a)
Sleep(100)
WEnd
EndIf
If _IsPressed($b) then
speaking("b")
$tipedText &= "b"
While _IsPressed($b)
Sleep(100)
WEnd
EndIf
If _IsPressed($c) then
$tipedText &= "c"
speaking("c")
While _IsPressed($c)
Sleep(100)
WEnd
EndIf
If _IsPressed($d) then
$tipedText &= "d"
speaking("d")
While _IsPressed($d)
Sleep(100)
WEnd
EndIf
If _IsPressed($e) then
$tipedText &= "e"
speaking("e")
While _IsPressed($e)
Sleep(100)
WEnd
EndIf
If _IsPressed($f) then
$tipedText &= "f"
speaking("f")
While _IsPressed($f)
Sleep(100)
WEnd
EndIf
If _IsPressed($g) then
$tipedText &= "g"
speaking("g")
While _IsPressed($g)
Sleep(100)
WEnd
EndIf
If _IsPressed($h) then
$tipedText &= "h"
speaking("h")
While _IsPressed($h)
Sleep(100)
WEnd
EndIf
If _IsPressed($i) then
$tipedText &= "i"
speaking("i")
While _IsPressed($i)
Sleep(100)
WEnd
EndIf
If _IsPressed($j) then
$tipedText &= "j"
speaking("j")
While _IsPressed($j)
Sleep(100)
WEnd
EndIf
If _IsPressed($k) then
$tipedText &= "k"
speaking("k")
While _IsPressed($k)
Sleep(100)
WEnd
EndIf
If _IsPressed($l) then
$tipedText &= "l"
speaking("l")
While _IsPressed($l)
Sleep(100)
WEnd
EndIf
If _IsPressed($m) then
$tipedText &= "m"
speaking("m")
While _IsPressed($m)
Sleep(100)
WEnd
EndIf
If _IsPressed($n) then
$tipedText &= "n"
speaking("n")
While _IsPressed($n)
Sleep(100)
WEnd
EndIf
If _IsPressed($o) then
$tipedText &= "o"
speaking("o")
While _IsPressed($o)
Sleep(100)
WEnd
EndIf
If _IsPressed($p) then
$tipedText &= "p"
speaking("p")
While _IsPressed($p)
Sleep(100)
WEnd
EndIf
If _IsPressed($q) then
$tipedText &= "q"
speaking("q")
While _IsPressed($q)
Sleep(100)
WEnd
EndIf
If _IsPressed($r) then
$tipedText &= "r"
speaking("r")
While _IsPressed($r)
Sleep(100)
WEnd
EndIf
If _IsPressed($s) then
$tipedText &= "s"
speaking("s")
While _IsPressed($s)
Sleep(100)
WEnd
EndIf
If _IsPressed($t) then
$tipedText &= "t"
speaking("t")
While _IsPressed($t)
Sleep(100)
WEnd
EndIf
If _IsPressed($u) then
$tipedText &= "u"
speaking("u")
While _IsPressed($u)
Sleep(100)
WEnd
EndIf
If _IsPressed($v) then
$tipedText &= "v"
speaking("v")
While _IsPressed($v)
Sleep(100)
WEnd
EndIf
If _IsPressed($w) then
$tipedText &= "w"
speaking("w")
While _IsPressed($w)
Sleep(100)
WEnd
EndIf
If _IsPressed($x) then
$tipedText &= "x"
speaking("x")
While _IsPressed($x)
Sleep(100)
WEnd
EndIf
If _IsPressed($y) then
$tipedText &= "y"
speaking("y")
While _IsPressed($y)
Sleep(100)
WEnd
EndIf
If _IsPressed($z) then
$tipedText &= "z"
speaking("z")
While _IsPressed($z)
Sleep(100)
WEnd
EndIf
If _IsPressed($t1) or _IsPressed($n1) then
$tipedText &= "1"
speaking("1")
While _IsPressed($t1) or _IsPressed($n1)
Sleep(100)
WEnd
EndIf
If _IsPressed($t2) or _IsPressed($n2) then
$tipedText &= "2"
speaking("2")
While _IsPressed($t2) or _IsPressed($n2)
Sleep(100)
WEnd
EndIf
If _IsPressed($t3) or _IsPressed($n3) then
$tipedText &= "3"
speaking("3")
While _IsPressed($t3) or _IsPressed($n3)
Sleep(100)
WEnd
EndIf
If _IsPressed($t4) or _IsPressed($n4) then
$tipedText &= "4"
speaking("4")
While _IsPressed($t4) or _IsPressed($n4)
Sleep(100)
WEnd
EndIf
If _IsPressed($t5) or _IsPressed($n5) then
$tipedText &= "5"
speaking("5")
While _IsPressed($t5) or _IsPressed($n5)
Sleep(100)
WEnd
EndIf
If _IsPressed($t6) or _IsPressed($n6) then
$tipedText &= "6"
speaking("6")
While _IsPressed($t6) or _IsPressed($n6)
Sleep(100)
WEnd
EndIf
If _IsPressed($t7) or _IsPressed($n7) then
$tipedText &= "7"
speaking("7")
While _IsPressed($t7) or _IsPressed($n7)
Sleep(100)
WEnd
EndIf
If _IsPressed($t8) or _IsPressed($n8) then
$tipedText &= "8"
speaking("8")
While _IsPressed($t8) or _IsPressed($n8)
Sleep(100)
WEnd
EndIf
If _IsPressed($t9) or _IsPressed($n9) then
$tipedText &= "9"
speaking("9")
While _IsPressed($t9) or _IsPressed($n9)
Sleep(100)
WEnd
EndIf
If _IsPressed($t0) or _IsPressed($n0) then
$tipedText &= "0"
speaking("0")
While _IsPressed($t0) or _IsPressed($n0)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($z) then
speaking(translate($idioma, "undo"))
While _IsPressed($control) And _IsPressed($z)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($x) then
Local $Clipdata1 = ClipGet()
speaking($Clipdata1 &translate($idioma, "it has been cut trom clipboard."))
While _IsPressed($control) And _IsPressed($x)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($c) then
Local $Clipdata2 = ClipGet()
speaking($Clipdata2 &translate($idioma, "Copied to clipboard."))
While _IsPressed($control) And _IsPressed($c)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($v) then
Local $Clipdata3 = ClipGet()
speaking($Clipdata3 &translate($idioma, "Pasted into text box"))
While _IsPressed($control) And _IsPressed($v)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($a) And Then
speaking(translate($idioma, "Select all"))
While _IsPressed($control) And _IsPressed($a)
Sleep(100)
WEnd
EndIf
If _IsPressed($control) And _IsPressed($y) then
speaking(translate($idioma, "Redo"))
While _IsPressed($control) And _IsPressed($y)
Sleep(100)
WEnd
EndIf
;Sleep(5)
WEnd
EndFunc   ;==>SayCharacters