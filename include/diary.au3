;diary:
Func diario()
$lb1 = GUICtrlCreateLabel(translate($idioma, "Diary name (optional)"), 10, 50, 100, 20)
global $dname = GUICtrlCreateInput("", 10, 80, 100, 20)
$label2 = GUICtrlCreateLabel(translate($idioma, "Short description of the diary"), 60, 50, 100, 20)
global $desc = GUICtrlCreateInput("", 60, 80, 150, 20)
global $BTNOk = GUICtrlCreateButton(translate($idioma, "OK"), 110, 50, 100, ,20)
GUICtrlSetOnEvent(-1, "diaryhandler")
global $BTN_Close = GUICtrlCreateButton(translate($idioma, "Close"), 110, 95, 100, ,20)
GUICtrlSetOnEvent(-1, "diaryhandler")
EndFunc
func diarihandler()
Select
Case @GUI_CtrlId = $idCancelalarm
$question = msgBox(4, translate($idioma, "Question"), translate($idioma, "Are you sure you want to exit? Your alarm will not be saved and these changes will be lost."))
If $question == 6 Then
$enCurso="0"
guiDelete($guialarm)
GUISetState(@SW_SHOW, $gui_Main)
EndIf
EndSelect
EndFunc