/* Test Wrapper for Rexx Macrospace */
Parse arg Function Type

Say Center(Type'\'Function' test start...', 40, 'DB'x)
Dependices = '.\'||Type||'\'||Function||'.dep'
Test = '"@.\'||Type||'\'||Function||'.cmd"'
CrLf = '0D0A'x
Say CrLf

Say Center('Loading test dependices', 40, '.') 
CountD = 0
Do While Lines(Dependices) > 0
    CountD = CountD + 1
    Parse Value Linein(Dependices) With Type.CountD '\' Function.CountD
    File = '..\lib\'||Type.CountD||'\'||Function.CountD||'.mac'
    If SysQueryRexxMacro(Function.CountD) Then
        SysDropRexxMacro(Function.CountD)
    Call SysAddRexxMacro Function.CountD, File
    Say Left(CountD'. SysAddRexxMacro  'Function.CountD' status:', 40, '.')||Result
End
Say CrLf

Say Center('Invoke test: 'Function, 40, '.')
Interpret Test
Say CrLf

Say Center('Returned from test', 40, '.')
Say Left('Test status:', 40, '.')||rc
Say CrLf

Say Center('Unloading test dependices', 40, '.')
Do Count = 1 To CountD
    Call SysDropRexxMacro Function.Count
    Say Left(Count'. SysDropRexxMacro  'Function.Count' status:', 40, '.')||Result
End
Say Left('SysDropRexxMacro status:', 40, '.')||Result
Say CrLf

Say Center(Type'\'Function' test stop.', 40, 'DB'x)
Exit Result