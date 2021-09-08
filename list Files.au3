#include <fileConstants.au3>
#include <Include\mergefiles_utf16le_v2.au3>
;ReOrganizar()
Func ReOrganizar()
$Extension = "mp3"
$listaudios =  _GetFilesFolder_Rekursiv("Sounds\soundsdata.dat", $Extension, 0, 0)
$freq = 440
For $i = 1 to $listaudioS[0]
$txtfile = FileOpen ("SoundList.txt", $FC_OVERWRITE  + $FC_CREATEPATH)
FileWrite ($txtfile, $listaudios[$i] &@crlf)
beep($freq, 50)
$freq = $freq +9
FileClose ($txtfile)
Next
endfunc