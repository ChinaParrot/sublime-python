@Echo Off
 
Title SublimeText �Ҽ��˵�ά��
Pushd %~dp0
 
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set a="HKLM\SOFTWARE\Wow6432Node\SublimeText\sublimetext_backwnd" /v&Set b=%SystemRoot%\SysWOW64) Else (Set a="HKLM\SOFTWARE\SublimeText\sublimetext_backwnd" /v&Set b=%SystemRoot%\system32)
Rd "%b%\test_permission" >nul 2>nul
Md "%b%\test_permission" 2>nul||(Echo ��ʹ���Ҽ�����Ա�������&&Pause >nul&&Exit)
Rd "%b%\test_permission" >nul 2>nul
 
:START
CLS
Echo *=========================================================================*
Echo *                                                                         *
Echo *                            [A]����Ҽ��˵�                              *
Echo *                            [D]ɾ���Ҽ��˵�                              *
Echo *                            [Q]�˳�                                      *
Echo *                                                                         *
Echo *=========================================================================*
Echo *ע��*���Ҽ�����ԱȨ������:
Set /P Choice=��ѡ��Ҫ���еĲ��� (A/D/Q) ��Ȼ�󰴻س���
If /I "%Choice%"=="A" Goto ADD
If /I "%Choice%"=="D" Goto DEL
If /I "%Choice%"=="Q" Exit
Goto START
 
:END
CLS
Echo *=========================================================================*
Echo *                                                                         *
Echo *                            �������                                     *
Echo *                            [M]�������˵�                                *
Echo *                            [Q]�˳�                                      *
Echo *                                                                         *
Echo *=========================================================================*
Set /P Choice=����������������ѡ��Ҫ���еĲ��� (M/Q) ��Ȼ�󰴻س���
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