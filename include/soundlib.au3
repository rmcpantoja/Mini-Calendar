#INCLUDE-ONCE
#cs
Sound library coded by Oriol Gómez
This is a useful library especially designed for coding audio games.
It requires comaudio (audio.au3) and array.au3.
#ce
#include "audio.au3"
;#include <array.au3>
#cs
PlayWait($sound)
It just plays a sound and waits till its done playing then destroys the object. Useful for playing sounds that you'll only play once and you don't want to have to load them etc, like intros.
#ce
func PlayWait($sound)
$tempsound=$device.opensound($sound,false)
$tempsound.play()
while $tempsound.playing
sleep(50)
WEnd
$tempsound=0
endfunc
#cs
function name: SoundLoad
Loads a sound into memory without having to type all the $device deal.
example: global $sound=SoundLoad("sound/numbers/1.ogg")
Sets flag to true. If you want to stream a sound from the hard drive use SoundStream instead.
#ce
func SoundLoad($sound)
return $device.OpenSound($sound,true)
endfunc
#cs
Sound stream: Streams a sound from the hard drive.
Example: global $stream=SoundStream("2.ogg")
#ce
func SoundStream($sound)
return $device.OpenSound($sound,false)
endfunc
#cs
SoundLoadFolder
Innovative function that loads an entire folder of sounds into an array and prepares it for playing. To play this you can either use SoundRandomize to random a sound inside this array or $array[#].play()
$array[0] is the total number of sounds.
Remarks
This function will not load subdirectories!
If you want to use a folder inside your script path for example you could use something like
global $array=SoundLoadFolder("sounds/game/crowd")
Also make sure that there are no text files or anything inside the sounds folder you are loading, if you are smart about it you shouldn't have too many problems.
There is a variable, $SoundsLoading, that stays at 1 when the sounds are being loaded and sets to 0 when its done.
#ce
func SoundLoadFolder($path)
$search=FileFindFirstFile($path&"/*.*") 
If $search = -1 Then
MsgBox(0, "Error", "No files inside that folder. Make sure you are giving it a correct path.")
return
EndIf
Dim $array
global $SoundsLoading=1
while 1
$file = FileFindNextFile($search) 
If @error Then ExitLoop
If (IsArray($array)=1) then
$Bound = UBound($array)
ReDim $array[$Bound+1]
$array[$Bound]=$device.opensound($path&"/"&$file,true)
$array[0]=$array[0]+1
else
dim $array[2]
$array[1]=$device.opensound($path&"/"&$file,true)

$array[0]=1
EndIf
WEnd
FileClose($search)
global $SoundsLoading=0
return $array
endfunc
#cs
SoundRandomize($array)
Plays a random sound inside an array loaded previously using SoundLoadFolder. useful if you have lots of shooting, or crowd cheer sounds or punches that you want to randomize.
#ce
func SoundRandomize($array)
$random=random(1,$array[0],1)
return $array[$random]
endfunc
#cs
SoundFade($sound)
Fades a sound previously loaded with SoundLoad
#ce
func SoundFade($sound)
for $fade=1 to 18
$sound.volume=$sound.volume-0.05
sleep(25)
next
$sound.stop()
EndFunc