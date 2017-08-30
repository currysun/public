Const HKEY_CURRENT_USER = &H80000001

strComputer = "."

Set ScriptMe=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
    strComputer & "\root\default:StdRegProv")

'Disable protected mode for local intranet'
strKeyPath = "Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1\"
strValueName = "2500"
dwValue = 1
ScriptMe.SetDWORDValue HKEY_CURRENT_USER,strKeyPath,strValueName,dwValue

'Disable protected mode for trusted pages'
strKeyPath = "Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2\"
strValueName = "2500"
dwValue = 3
ScriptMe.SetDWORDValue HKEY_CURRENT_USER,strKeyPath,strValueName,dwValue

'Disable protected mode for internet'
strKeyPath = "Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3\"
strValueName = "2500"
dwValue = 3
ScriptMe.SetDWORDValue HKEY_CURRENT_USER,strKeyPath,strValueName,dwValue

'Disable protected mode for restricted sites'
strKeyPath = "Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4\"
strValueName = "2500"
dwValue = 3
ScriptMe.SetDWORDValue HKEY_CURRENT_USER,strKeyPath,strValueName,dwValue