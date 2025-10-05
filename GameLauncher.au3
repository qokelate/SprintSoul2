#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=GameLauncher.kxf
Global $Form1 = GUICreate("Form1", 563, 437, 452, 170)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
Global $Group1 = GUICtrlCreateGroup("Group1", 20, 20, 221, 191)
Global $Radio1 = GUICtrlCreateRadio("新游戏-水使", 50, 50, 113, 17)
GUICtrlSetOnEvent(-1, "Radio1Click")
Global $Radio2 = GUICtrlCreateRadio("新游戏-火使", 50, 80, 113, 17)
GUICtrlSetOnEvent(-1, "Radio2Click")
Global $Radio3 = GUICtrlCreateRadio("新游戏-风使", 50, 110, 113, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "Radio3Click")
Global $Radio4 = GUICtrlCreateRadio("新游戏-地使", 50, 140, 113, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "Radio4Click")
Global $Radio5 = GUICtrlCreateRadio("载入存档", 50, 170, 113, 17)
GUICtrlSetOnEvent(-1, "Radio5Click")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Group2 = GUICtrlCreateGroup("选择存档", 270, 20, 280, 355)
Global $List1 = GUICtrlCreateList("", 280, 50, 261, 305)
GUICtrlSetOnEvent(-1, "List1Click")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Button1 = GUICtrlCreateButton("开始游戏", 50, 260, 145, 85)
GUICtrlSetOnEvent(-1, "Button1Click")
Global $Checkbox1 = GUICtrlCreateCheckbox("游戏启动后退出本程序", 40, 220, 177, 27)
GUICtrlSetOnEvent(-1, "Checkbox1Click")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $mode = ''
FileChangeDir(@ScriptDir)
load_save()

While 1
	Sleep(100)
WEnd

Exit

Func load_save()
	Local $h = FileFindFirstFile(StringFormat('%s\\Save\\*.sav', @ScriptDir))
	If @error Then Return
	If - 1 == $h Then Return
	
	While 1
		Local $sav = FileFindNextFile($h)
		If @error Then ExitLoop
		GUICtrlSetData($List1, $sav, 1)
	WEnd
	FileClose($h)
EndFunc   ;==>load_save


Func Form1Close()
	Exit
EndFunc   ;==>Form1Close
Func Form1Maximize()

EndFunc   ;==>Form1Maximize
Func Form1Minimize()

EndFunc   ;==>Form1Minimize
Func Form1Restore()

EndFunc   ;==>Form1Restore
Func List1Click()

EndFunc   ;==>List1Click
Func Radio1Click()
	$mode = 'A'
EndFunc   ;==>Radio1Click
Func Radio2Click()
	$mode = 'N'
EndFunc   ;==>Radio2Click
Func Radio3Click()
	$mode = 'A'
EndFunc   ;==>Radio3Click
Func Radio4Click()
	$mode = 'E'
EndFunc   ;==>Radio4Click
Func Radio5Click()
	$mode = '*'
EndFunc   ;==>Radio5Click
Func Button1Click()
	If '' == $mode Then
		MsgBox(0, 'ERROR', '请选择模式', 0, $Form1)
		Return
	EndIf
	
	Local $arg = $mode
	If '*' == $mode Then
		Local $sav = GUICtrlRead($List1)
		
		If $sav == '' Then
			MsgBox(0, 'ERROR', '请选择存档文件', 0, $Form1)
			Return
		EndIf
		
		Local $f1 = StringFormat('.\\Save\\%s', $sav)
		Local $h = FileOpen($f1, 16)
		FileSetPos($h, 29, 0)
		Local $f2 = FileRead($h, 1)
		FileClose($h)
		
		If '0x00' == String($f2) Then
			$arg = StringFormat('2 %s', $f1)
		Else
			$arg = StringFormat('1 %s', $f1)
		EndIf
	EndIf
	
	Local $cmd = StringFormat('SpiritualSoul2.bin %s', $arg)
	Run($cmd, @ScriptDir, @SW_SHOWDEFAULT, 0x10000)
;~ 	ShellExecute('runner.exe', $arg, @ScriptDir, 'open', @SW_HIDE)
	If 1 == GUICtrlRead($Checkbox1) Then Exit
EndFunc   ;==>Button1Click



