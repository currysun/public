' XML_to_XLS.vbs
'
' Converts an Excel XML Spreadsheet to an Excel workbook.  Requires Microsoft Excel.
' Usage:
'  WScript XML_to_XLS.vbs <input file> <output file>

Option Explicit

' MsoAutomationSecurity
Const msoAutomationSecurityForceDisable = 3
' XlFileFormat
Const xlWorkbookNormal = -4143 ' Workbook

Dim App, AutoSec, Doc, FileSys
Set FileSys = CreateObject("Scripting.FileSystemObject")
If FileSys.FileExists(WScript.Arguments(1)) Then
	FileSys.DeleteFile WScript.Arguments(1)
End If
Set App = CreateObject("Excel.Application")

On Error Resume Next

App.DisplayAlerts = False
AutoSec = App.AutomationSecurity
App.AutomationSecurity = msoAutomationSecurityForceDisable
Err.Clear

Set Doc = App.Workbooks.Open(WScript.Arguments(0), False, True)
If Err = 0 Then
	Doc.SaveAs WScript.Arguments(1), xlWorkbookNormal
	Doc.Close False
End If

App.AutomationSecurity = AutoSec
App.Quit