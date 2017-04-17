@Echo Off
 
Title SublimeText 右键菜单维护
Pushd %~dp0
 
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set a="HKLM\SOFTWARE\Wow6432Node\SublimeText\sublimetext_backwnd" /v&Set b=%SystemRoot%\SysWOW64) Else (Set a="HKLM\SOFTWARE\SublimeText\sublimetext_backwnd" /v&Set b=%SystemRoot%\system32)
Rd "%b%\test_permission" >nul 2>nul
Md "%b%\test_permission" 2>nul||(Echo 请使用右键管理员身份运行&&Pause >nul&&Exit)
Rd "%b%\test_permission" >nul 2>nul
 
:START
CLS
Echo *=========================================================================*
Echo *                                                                         *
Echo *                            [A]添加右键菜单                              *
Echo *                            [D]删除右键菜单                              *
Echo *                            [Q]退出                                      *
Echo *                                                                         *
Echo *=========================================================================*
Echo *注意*请右键管理员权限运行:
Set /P Choice=请选择要进行的操作 (A/D/Q) ，然后按回车：
If /I "%Choice%"=="A" Goto ADD
If /I "%Choice%"=="D" Goto DEL
If /I "%Choice%"=="Q" Exit
Goto START
 
:END
CLS
Echo *=========================================================================*
Echo *                                                                         *
Echo *                            操作完成                                     *
Echo *                            [M]返回主菜单                                *
Echo *                            [Q]退出                                      *
Echo *                                                                         *
Echo *=========================================================================*
Set /P Choice=　　　　　　　请选择要进行的操作 (M/Q) ，然后按回车：
If /I "%Choice%"=="M" Goto :START
If /I "%Choice%"=="Q" Exit
 
:ADD
CLS
REG ADD HKEY_CLASSES_ROOT\*\shell\SublimeText /t REG_SZ /d SublimeText /f
REG ADD HKEY_CLASSES_ROOT\*\shell\SublimeText\Command /t REG_SZ /d "%cd%\sublime_text.exe \"%%1%%\"" /f
REG ADD HKEY_CLASSES_ROOT\Directory\shell\SublimeText /t REG_SZ /d SublimeText /f
REG ADD HKEY_CLASSES_ROOT\Directory\shell\SublimeText\Command /t REG_SZ /d "%cd%\sublime_text.exe -n \"%%1%%\"" /f
GOTO :END
 
:DEL
REG DELETE HKEY_CLASSES_ROOT\*\shell\SublimeText /f
REG DELETE HKEY_CLASSES_ROOT\Directory\shell\SublimeText /f
GOTO :END