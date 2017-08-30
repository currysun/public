AutoItSetOption("WinTitleMatchMode","2") ; set the select mode to select using substring
;sample downloadfile.exe "File Download" "Save" "C:\1.xls"
if $CmdLine[0] < 2 then
   ; Arguments are not enough
   msgbox(0,"Error","Supply all the arguments, Dialog title,Open/Save/Cancel and Path to save(optional)")
   Exit
EndIf

$ie_version = FileGetVersion(@ProgramFilesDir & "\Internet Explorer\iexplore.exe")
ConsoleWrite("ie version " & $ie_version & @CRLF)
If StringCompare(StringLeft($ie_version, 1), "8") = 0 Then
   ConsoleWrite("download with ie 8" & @CRLF)
   ConsoleWrite("wait Until dialog box appears" & @CRLF)
   ;WinWait($CmdLine[1]) ; match the window with substring
   $title1 = $CmdLine[1] ; retrives whole window title
   WinWait($title1, "", 30)
   WinActivate($title1)
   WinWaitActive($title1, "", 30)

   If (StringCompare($CmdLine[2],"Open",0) = 0) Then
	  ConsoleWrite("click on open button" & @CRLF)
	  ControlClick($title1,"","Button1")
   EndIf

   If (StringCompare($CmdLine[2],"Save",0) = 0) Then
	  ConsoleWrite("click on save button" & @CRLF)
	  ControlClick($title1,"","Button2")

	  $title2 = "Save As"
	  WinWait($title2, "", 2)
	  WinActivate($title2)
	  WinWaitActive($title2, "", 30)
	  if ($CmdLine[0] > 2) Then
		 ConsoleWrite("set path and save file" & @CRLF)
		 ControlFocus($title2,"","[CLASS:Edit;INSTANCE:1]")
		 ConsoleWrite("set path to save the file is passed as command line arugment" & @CRLF)
		 ;ControlSetText($title2,"","Edit1",$CmdLine[3]) ;set path and save file
		 Send($CmdLine[3])
		 sleep(500)
	  EndIf
	  ConsoleWrite("click on save button" & @CRLF)
	  ControlClick($title2,"","Button1")

	  $title3 = "Confirm Save As"
	  WinWait($title3, "", 2)
	  If WinExists($title3) Then
		 ConsoleWrite("wait confirm save as dialog exists" & @CRLF)
		 WinActivate($title3)
		 WinWaitActive($title3, "", 30)
		 ConsoleWrite("click on yes button" & @CRLF)
		 ControlClick($title3,"","Button1")
	  EndIf

	  $title4 = "Download complete"
	  WinWait($title4, "", 2)
	  If WinExists($title4) Then
		 ConsoleWrite("wait download complete dialog exists" & @CRLF)
		 WinActivate($title4)
		 WinWaitActive($title4, "", 30)
		 ConsoleWrite("click on close button" & @CRLF)
		 ControlClick($title4,"","Button4")
	  EndIf
   EndIf

   If (StringCompare($CmdLine[2],"Cancel",0) = 0) Then
	  ConsoleWrite("click on cancel button" & @CRLF)
	  ControlClick($title1,"","Button3")
   EndIf
Else
   ConsoleWrite("download with ie 9, 10 or 11" & @CRLF)
   $windHandle = WinGetHandle("[Class:IEFrame]", "")
   ConsoleWrite("get the handle of main window " & $windHandle & @CRLF)
   $title1 = "[HANDLE:" & $windHandle & "]"
   ;get coordinates of default HWND
   $ctlText=ControlGetPos($title1, "", "[Class:DirectUIHWND;INSTANCE:1]")
   ;MsgBox(0, "Title", $ctlText)

   ConsoleWrite("wait till the notification bar is displayed" & @CRLF)
   $color= PixelGetColor ($ctlText[0],$ctlText[1])
   ;MsgBox(0, "Title", $color)
   while $color <> 0
	  sleep(500)
	  $ctlText=ControlGetPos ($title1, "", "[Class:DirectUIHWND;INSTANCE:1]")
	  $color = PixelGetColor ($ctlText[0],$ctlText[1])
   wend

   ConsoleWrite("activate the main window" & @CRLF)
   WinWait($title1, "", 30)
   WinActivate ($title1, "")
   WinWaitActive($title1, "", 30)
   ConsoleWrite("focus on open button" & @CRLF)
   Send("{F6}")
   sleep(500)

   If (StringCompare($CmdLine[2],"Open",0) = 0) Then
	  ConsoleWrite("click on open button" & @CRLF)
	  Send("{ENTER}")
   EndIf

   If (StringCompare($CmdLine[2],"Save",0) = 0) Then
	  ConsoleWrite("switch to save button" & @CRLF)
	  Send("{TAB}")
	  sleep(500)
	  ConsoleWrite("select save as button" & @CRLF)
	  Send("{DOWN}")
	  sleep(500)
	  Send("a")

	  $title2 = "Save As"
	  ConsoleWrite("wait for Save As window" & @CRLF)
	  WinWait($title2, "", 2)
	  ConsoleWrite("activate Save As window" & @CRLF)
	  WinActivate($title2)
	  WinWaitActive($title2, "", 30)
	  if ($CmdLine[0] > 2) Then
		 ConsoleWrite("set path and save file")
		 ConsoleWrite("path to save the file is passed as command line arugment")
		 ControlFocus($title2,"","[CLASS:Edit;INSTANCE:1]")
		 Send($CmdLine[3])
		 sleep(500)
	  EndIf
	  ConsoleWrite("click on save button" & @CRLF)
	  ControlClick($title2,"","Button1")
	  ;ControlClick("Save As","","[TEXT:&Save]")	;click on save button

	  $title3 = "Confirm Save As"
	  WinWait($title3, "", 2)
	  If WinExists($title3) Then
		 ConsoleWrite("wait confirm save as dialog exists" & @CRLF)
		 WinActivate($title3)
		 WinWaitActive($title3, "", 30)
		 ConsoleWrite("click on yes button" & @CRLF)
		 ControlClick($title3,"","Button1")
	  EndIf

 	  ConsoleWrite("wait till the download completes" & @CRLF)
 	  $sAttribute = FileGetAttrib($CmdLine[3]);
 	  while $sAttribute = ""
		 sleep(500)
		 $sAttribute = FileGetAttrib($CmdLine[3])
 	  wend
 	  sleep(2000)

	  ConsoleWrite("close the notification bar" & @CRLF)
	  WinActivate ($title1, "")
	  Send("{F6}")
	  sleep(500)
	  Send("{TAB}")
	  sleep(500)
	  Send("{TAB}")
	  sleep(500)
	  Send("{TAB}")
	  sleep(500)
	  Send("{ENTER}")
   EndIf

   If (StringCompare($CmdLine[2],"Cancel",0) = 0) Then
	  Send("{TAB}")
	  sleep(500)
	  Send("{TAB}")
	  sleep(500)
	  ConsoleWrite("click on cancel button" & @CRLF)
	  Send("{ENTER}")
   EndIf
EndIf