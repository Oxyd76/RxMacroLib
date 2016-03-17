/* Test Wrapper for Rexx Macrospace */
Parse arg Function Type

Say Center(Type'\'Function' test start...', 40, 'DB'x)
File = '..\lib\'||Type||'\'||Function||'.mac'
Test = '"@.\'||Type||'\'||Function||'.cmd"'
CrLf = '0D0A'x
Say CrLf

If SysQueryRexxMacro(Function) Then
   SysDropRexxMacro(Function)
Call SysAddRexxMacro Function, File
Say Left('SysAddRexxMacro  'Function' status:', 40, '.')||Result
Say CrLf
Say Center('Invoke test: 'Function, 40, '.')

Interpret Test

Say CrLf
Say Center('Returned from test', 40, '.')
Say Left('Test status:', 40, '.')||rc
Say
Call SysDropRexxMacro Function
Say Left('SysDropRexxMacro status:', 40, '.')||Result
Say CrLf
Say Center(Type'\'Function' test stop.', 40, 'DB'x)
