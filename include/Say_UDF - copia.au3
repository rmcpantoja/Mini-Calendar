$Say_UDfversion = "0.4"
Global $say = "0"
$keyenter = 0
$key0 = 0
$key1 = 0
$key2 = 0
$key3 = 0
$key4 = 0
$key5 = 0
$key6 = 0
$key7 = 0
$key8 = 0
$key9 = 0
$keyspace = 0
$keyescape = 0
$keydelete = 0
$keymove = 0
$keyup = 0
$keydown = 0
$keyleft = 0
$keyright = 0
$keypgu = 0
$keypgd = 0
$keyhome = 0
$keyend = 0
$keya = 0
$keyb = 0
$keyc = 0
$keyd = 0
$keye = 0
$keyf = 0
$keyg = 0
$keyh = 0
$keyi = 0
$keyj = 0
$keyk = 0
$keyl = 0
$keym = 0
$keyn = 0
$keyo = 0
$keyp = 0
$keyq = 0
$keyr = 0
$key_s = 0
$keyt = 0
$keyu = 0
$keyv = 0
$keyx = 0
$keyy = 0
$keyz = 0
$keynumber = 0
$keyundo = 0
$keycut = 0
$keycopy = 0
$keypaste = 0
$keyselectall = 0
$keyredo = 1
Func NVDA_SayCharacters()
	$Lang = IniRead("config\config.st", "General settings", "language", "")
	While $say = 1
		If _IsPressed($shift) And _IsPressed($f2) Then
			Select
				Case $Lang = "es"
					speaking("Hablar mientras escribes desactivado")
				Case $Lang = "eng"
					speaking("speak while typing off")
			EndSelect
			$say = 0
			ContinueLoop
		EndIf
		If _IsPressed($shift) And _IsPressed($f3) Then
			Select
				Case $Lang = "es"
					speaking("Hablar mientras escribes activado")
				Case $Lang = "eng"
					speaking("speak while typing on")
			EndSelect
			$say = 1
			ContinueLoop
		EndIf
		;wend
		If Not _IsPressed($enter) Then $keyenter = 0
		If _IsPressed($enter) And $keyenter = 0 Then
			$keyenter = 1
			speaking("enter")
		EndIf
		If Not _IsPressed($spacebar) Then $keyspace = 0
		If _IsPressed($spacebar) And $keyspace = 0 Then
			$keyspace = 1
			Select
				Case $Lang = "es"
					speaking("Espacio")
				Case $Lang = "eng"
					speaking("Space")
			EndSelect
		EndIf
		If Not _IsPressed($escape) Then $keyescape = 0
		If _IsPressed($escape) And $keyescape = 0 Then
			$keyescape = 1
			speaking("escape")
		EndIf
		If Not _IsPressed($delete) Or _IsPressed($backspace) Then $keydelete = 0
		If _IsPressed($delete) Or _IsPressed($backspace) And $keydelete = 0 Then
			$keydelete = 1
			Select
				Case $Lang = "es"
					speaking("Borrar")
				Case $Lang = "eng"
					speaking("Delete")
			EndSelect
		EndIf
		If Not _IsPressed($up) Then $keyup = 0
		If Not _IsPressed($down) Then $keydown = 0
		If Not _IsPressed($left) Then $keyleft = 0
		If Not _IsPressed($right) Then $keyright = 0
		If Not _IsPressed($home) Then $keyhome = 0
		If Not _IsPressed($end) Then $keyend = 0
		If Not _IsPressed($page_up) Then $keypgu = 0
		If Not _IsPressed($page_down) Then $keypgd = 0
		If _IsPressed($up) And $keyup = 0 Then
			$keyup = 1
			Select
				Case $Lang = "es"
					speaking("Flecha arriba")
				Case $Lang = "eng"
					speaking("Up")
			EndSelect
		EndIf
		If _IsPressed($down) And $keydown = 0 Then
			$keydown = 1
			Select
				Case $Lang = "es"
					speaking("Flecha abajo")
				Case $Lang = "eng"
					speaking("Down")
			EndSelect
		EndIf
		If _IsPressed($left) And $keyleft = 0 Then
			$keyleft = 1
			Select
				Case $Lang = "es"
					speaking("Flecha izquierda")
				Case $Lang = "eng"
					speaking("left")
			EndSelect
		EndIf
		If _IsPressed($right) And $keyright = 0 Then
			$keyright = 1
			Select
				Case $Lang = "es"
					speaking("Flecha derecha")
				Case $Lang = "eng"
					speaking("Right")
			EndSelect
		EndIf
		If _IsPressed($page_up) And $keypgu = 0 Then
			$keypgu = 1
			Select
				Case $Lang = "es"
					speaking("Avance de página")
				Case $Lang = "eng"
					speaking("page up")
			EndSelect
		EndIf
		If _IsPressed($page_down) And $keypgd = 0 Then
			$keypgd = 1
			Select
				Case $Lang = "es"
					speaking("Retroceso de página")
				Case $Lang = "eng"
					speaking("page down")
			EndSelect
		EndIf
		If _IsPressed($home) And $keyhome = 0 Then
			$keyhome = 1
			Select
				Case $Lang = "es"
					speaking("Inicio")
				Case $Lang = "eng"
					speaking("home")
			EndSelect
		EndIf
		If _IsPressed($end) And $keyend = 0 Then
			$keyend = 1
			Select
				Case $Lang = "es"
					speaking("Fin")
				Case $Lang = "eng"
					speaking("end")
			EndSelect
		EndIf
		If Not _IsPressed($a) Then $keya = 0
		If Not _IsPressed($b) Then $keyb = 0
		If Not _IsPressed($c) Then $keyc = 0
		If Not _IsPressed($d) Then $keyd = 0
		If Not _IsPressed($e) Then $keye = 0
		If Not _IsPressed($f) Then $keyf = 0
		If Not _IsPressed($g) Then $keyg = 0
		If Not _IsPressed($h) Then $keyh = 0
		If Not _IsPressed($i) Then $keyi = 0
		If Not _IsPressed($j) Then $keyj = 0
		If Not _IsPressed($k) Then $keyk = 0
		If Not _IsPressed($l) Then $keyl = 0
		If Not _IsPressed($m) Then $keym = 0
		If Not _IsPressed($n) Then $keyn = 0
		If Not _IsPressed($o) Then $keyo = 0
		If Not _IsPressed($p) Then $keyp = 0
		If Not _IsPressed($q) Then $keyq = 0
		If Not _IsPressed($r) Then $keyr = 0
		If Not _IsPressed($s) Then $key_s = 0
		If Not _IsPressed($t) Then $keyt = 0
		If Not _IsPressed($u) Then $keyu = 0
		If Not _IsPressed($v) Then $keyv = 0
		If Not _IsPressed($w) Then $keyw = 0
		If Not _IsPressed($x) Then $keyx = 0
		If Not _IsPressed($y) Then $keyy = 0
		If Not _IsPressed($z) Then $keyz = 0
		If _IsPressed($a) And $keya = 0 Then
			$keya = 1
			speaking("a")
		EndIf
		If _IsPressed($b) And $keyb = 0 Then
			$keyb = 1
			speaking("b")
		EndIf
		If _IsPressed($c) And $keyc = 0 Then
			$keyc = 1
			speaking("c")
		EndIf
		If _IsPressed($d) And $keyd = 0 Then
			$keyd = 1
			speaking("d")
		EndIf
		If _IsPressed($e) And $keye = 0 Then
			$keye = 1
			speaking("e")
		EndIf
		If _IsPressed($f) And $keyf = 0 Then
			$keyf = 1
			speaking("f")
		EndIf
		If _IsPressed($g) And $keyg = 0 Then
			$keyg = 1
			speaking("g")
		EndIf
		If _IsPressed($h) And $keyh = 0 Then
			$keyh = 1
			speaking("h")
		EndIf
		If _IsPressed($i) And $keyi = 0 Then
			$keyi = 1
			speaking("i")
		EndIf
		If _IsPressed($j) And $keyj = 0 Then
			$keyj = 1
			speaking("j")
		EndIf
		If _IsPressed($k) And $keyk = 0 Then
			$keyk = 1
			speaking("k")
		EndIf
		If _IsPressed($l) And $keyl = 0 Then
			$keyl = 1
			speaking("l")
		EndIf
		If _IsPressed($m) And $keym = 0 Then
			$keym = 1
			speaking("m")
		EndIf
		If _IsPressed($n) And $keyn = 0 Then
			$keyn = 1
			speaking("n")
		EndIf
		If _IsPressed($o) And $keyo = 0 Then
			$keyo = 1
			speaking("o")
		EndIf
		If _IsPressed($p) And $keyp = 0 Then
			$keyp = 1
			speaking("p")
		EndIf
		If _IsPressed($q) And $keyq = 0 Then
			$keyq = 1
			speaking("q")
		EndIf
		If _IsPressed($r) And $keyr = 0 Then
			$keyr = 1
			speaking("r")
		EndIf
		If _IsPressed($s) And $key_s = 0 Then
			$key_s = 1
			speaking("s")
		EndIf
		If _IsPressed($t) And $keyt = 0 Then
			$keyt = 1
			speaking("t")
		EndIf
		If _IsPressed($u) And $keyu = 0 Then
			$keyu = 1
			speaking("u")
		EndIf
		If _IsPressed($v) And $keyv = 0 Then
			$keyv = 1
			speaking("v")
		EndIf
		If _IsPressed($w) And $keyw = 0 Then
			$keyw = 1
			speaking("w")
		EndIf
		If _IsPressed($x) And $keyx = 0 Then
			$keyx = 1
			speaking("x")
		EndIf
		If _IsPressed($y) And $keyy = 0 Then
			$keyy = 1
			speaking("y")
		EndIf
		If _IsPressed($z) And $keyz = 0 Then
			$keyz = 1
			speaking("z")
		EndIf
		If Not _IsPressed($t1) Then $key1 = 0
		If Not _IsPressed($t2) Then $key2 = 0
		If Not _IsPressed($t3) Then $key3 = 0
		If Not _IsPressed($t4) Then $key4 = 0
		If Not _IsPressed($t5) Then $key5 = 0
		If Not _IsPressed($t6) Then $key6 = 0
		If Not _IsPressed($t7) Then $key7 = 0
		If Not _IsPressed($t8) Then $keyt8 = 0
		If Not _IsPressed($t9) Then $key9 = 0
		If _IsPressed($t1) And $key1 = 0 Then
			$key1 = 1
			speaking("1")
		EndIf
		If _IsPressed($t2) And $key2 = 0 Then
			$key2 = 1
			speaking("2")
		EndIf
		If _IsPressed($t3) And $key3 = 0 Then
			$key3 = 1
			speaking("3")
		EndIf
		If _IsPressed($t4) And $key4 = 0 Then
			$key4 = 1
			speaking("4")
		EndIf
		If _IsPressed($t5) And $key5 = 0 Then
			$key5 = 1
			speaking("5")
		EndIf
		If _IsPressed($t6) And $key6 = 0 Then
			$key6 = 1
			speaking("6")
		EndIf
		If _IsPressed($t7) And $key7 = 0 Then
			$key7 = 1
			speaking("7")
		EndIf
		If _IsPressed($t8) And $key8 = 0 Then
			$key8 = 1
			speaking("8")
		EndIf
		If _IsPressed($t9) And $key9 = 0 Then
			$key9 = 1
			speaking("9")
		EndIf
		If _IsPressed($t0) And $key0 = 0 Then
			$key0 = 1
			speaking("0")
		EndIf
		If _IsPressed($n1) Or _IsPressed($n2) Or _IsPressed($n3) Or _IsPressed($n4) Or _IsPressed($n5) Or _IsPressed($n6) Or _IsPressed($n7) Or _IsPressed($n8) Or _IsPressed($n9) Or _IsPressed($n0) And $keynumber = 0 Then
			$keynumber = 1
			Select
				Case $Lang = "es"
					speaking("Teclado numérico")
				Case $Lang = "eng"
					speaking("numpad")
			EndSelect
		EndIf
		If Not _IsPressed($control) And _IsPressed($z) Then $keyundo = 0
		If Not _IsPressed($control) And _IsPressed($x) Then $keycut = 0
		If Not _IsPressed($control) And _IsPressed($c) Then $keycopy = 0
		If Not _IsPressed($control) And _IsPressed($v) Then $keypaste = 0
		If Not _IsPressed($control) And _IsPressed($a) Then $keyselectall = 0
		If Not _IsPressed($control) And _IsPressed($y) Then $keyredo = 0
		If _IsPressed($control) And _IsPressed($z) And $keyundo = 0 Then
			$keyundo = 1
			Sleep(100)
			Select
				Case $Lang = "es"
					speaking("Deshacer")
				Case $Lang = "eng"
					speaking("undo")
			EndSelect
		EndIf
		If _IsPressed($control) And _IsPressed($x) And $keycut = 0 Then
			$keycut = 1
			Sleep(100)
			Local $Clipdata1 = ClipGet()
			Select
				Case $Lang = "es"
					speaking("Se ha cortado " & $Clipdata1 & " desde el portapapeles.")
				Case $Lang = "eng"
					speaking(&$Clipdata1 & "it has been cut trom clipboard.")
			EndSelect
		EndIf
		If _IsPressed($control) And _IsPressed($c) And $keycopy = 0 Then
			$keycopy = 1
			Sleep(100)
			Local $Clipdata2 = ClipGet()
			Select
				Case $Lang = "es"
					speaking("Se copió " & $Clipdata2 & " al portapapeles")
				Case $Lang = "eng"
					speaking($Clipdata2 & "Copied to clipboard.")
			EndSelect
		EndIf
		If _IsPressed($control) And _IsPressed($v) And $keypaste = 0 Then
			$keypaste = 1
			Sleep(100)
			Local $Clipdata3 = ClipGet()
			Select
				Case $Lang = "es"
					speaking($Clipdata3 & "pegado al campo de texto")
				Case $Lang = "eng"
					speaking($Clipdata3 & "Pasted into text box")
			EndSelect
		EndIf
		If _IsPressed($control) And _IsPressed($a) And $keyselectall = 0 Then
			$keyselectall = 1
			Sleep(100)
			Select
				Case $Lang = "es"
					speaking("Seleccionar todo")
				Case $Lang = "eng"
					speaking("Select all")
			EndSelect
		EndIf
		If _IsPressed($control) And _IsPressed($y) And $keyredo = 0 Then
			$keyredo = 1
			Sleep(100)
			Select
				Case $Lang = "es"
					speaking("Rehacer")
				Case $Lang = "eng"
					speaking("Redo")
			EndSelect
		EndIf
		;Sleep(5)
	WEnd
EndFunc   ;==>NVDA_SayCharacters
