$arreglo = StringSplit("5 minutes before|10 minutes before|15 minutes before|30 minutes before|45 minutes before|one hour before", "|")
If @Error Then return 0
$selection = $arreglo[2]
for $I = 1 to $arreglo[0]
msgbox(0, $arreglo[0], $arreglo[$I])
next
msgBox(0, "Done", "Finished")