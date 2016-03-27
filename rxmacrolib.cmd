/* RxMacroLib -- utility for init and management REXX macro space. */
Parse upper arg Command Parameters

ListCommands = 'AUTOLOAD CHECKDEP CHECKTOK INIT LIST LOAD TOKENIZE UNLOAD'
CrLf = '0D0A'x
Usage = 'Usage:'CrLf,
        '  RxMacroLib <AUTOLOAD|CHECKDEP|CHECKTOK|INIT|LIST|LOAD|TOKENIZE|UNLOAD>'CrLf,
        '   RxMacroLib AUTOLOAD -- Autoload feature command.'CrLf,
        '      /Macros  Load .mac files listed in auto_mac.cfg.'CrLf,
        '      /Rxfunc  Load dll extensions files listed in auto_rxf.cfg.'CrLf,
        '      /Tokens  Load .mat files listed in auto_mat.cfg.'CrLf,
        '   RxMacroLib CHECKDEP -- Check scripts and functions dependices.'CrLf,
        '      /Macros -- Check dependices in:'CrLf,
        '           -All -- In All types, all .mac macrofiles, and generate .dep files.'CrLf,
        '           -Function <type\function> -- One .mac function in type,'CrLf,
        '             and generate .dep file.'CrLf,
        '           -Type - <type> -- Check all .mac functions in type,'CrLf,
        '              and generate .dep files.'CrLf,
        '      /File <filename.cmd> [>filename.cfg] -- Check RxML dependices in script.'CrLf,
        '   RxMacroLib CHECKTOK -- Check functions is tokenized.'CrLf,
        '      /All -- Check all functions in all types.'CrLf,
        '      /File <filename.cfg> -- Check function is tokenized, listed in filename.'CrLf,
        '      /Function <type\function> -- Check one function in type is tokenized.'CrLf,
        '      /Type <type_name> -- Check all functions in type.'CrLf,
        '   RxMacroLib INIT -- Initialise RexxMacroLib, generate .dep files,'CrLf,
        '              tokenize Functions, create default autoload, create key, etc.'CrLf,
        '   RxMacroLib LIST -- List loaded functions and DLLs.'CrLf,
        '      /Macros -- List loaded functions.'CrLf,
        '           -All -- List all loaded functions.'CrLf,
        '           -Function <function_name> -- Check function_name is loaded.'CrLf,
        '      /Rxfunc -- List loaded DLLs.'CrLf,
        '           -All -- List all loaded DLLs.'CrLf,
        '           -Dll <dll_name> -- Check one DLL is loaded.'CrLf,
        '   RxMacroLib LOAD -- Load functions, types and DLLs (direct or via configs).'CrLf,
        '      /All -- Load all functions in all types.'CrLf,
        '      /File <filename.cfg> -- Load functions listed in filename.cfg.'CrLf,
        '      /Function <Type\Function> -- Load one function in type.'CrLf,
        '      /Type <Type> -- Load all functions in type.'CrLf,
        '      /Rxfunc <DLL name> -- Load functions from DLL.'CrLf,
        '      /RxfuncF <filename.cfg> -- Load DLLs functions listed in filename.cfg.'CrLf,
        '   RxMacroLib TOKENIZE -- Tokenize .mac macroses to .mat files for better'CrLf,
        '              loading performance.'CrLf,
        '      /All -- Tokenize all functions in all types.'CrLf,
        '      /File <filename.cfg> Tokenize functions listed in filename.cfg.'CrLf,
        '      /Function <type\function> -- Tokenize one function in type.'CrLf,
        '      /Type -- Tokenize all functions in type.'CrLf,
        '   RxMacroLib UNLOAD -- Unload  functions, types and DLLs.'CrLf,
        '      /All -- Unload all functions or DLLs.'CrLf,
        '           -Macros -- Unload all functions.'CrLf,
        '           -Rxfunc -- Unload all DLLs.'CrLf,
        '      /Function <function_name> -- Unload one function.'CrLf,
        '      /Rxfunc <dll_name> -- Unload functions from one DLL.'CrLf,
        '      /Rxfuncf <filename.cfg> -- Unload DLL functions. DLL listed in filename.'CrLf,
        '      /Type <type_name> -- Unload all funcions in type.'CrLf||CrLf,
        'Notice: Only one COMMANDS /Parameters and -keys  use at a time.'CrLf,
        'Use "View RxMacroLib.inf" for get help and get more information.'CrLf
Parse Source Sys.OS Sys.ExecType Sys.ExecName
Sys.RootPath = FileSpec('Drive', Sys.ExecName) || FileSpec('Path', Sys.ExecName)
Func = WordCheck(ListCommands, Command)
Select
    When Func = 'ERROR1' Then Do
        Say Usage
        Say 'Unknown COMMAND!'
        Exit 1
    End
    Otherwise
        Interpret 'Call ' Func || ' ' || C2X(Parameters)
End

Exit 0

AUTOLOAD:
Parse arg ParaKeys
Commands = '/TOKENS /MACROS /RXFUNC'
Tokens = ''
Macros = ''
Rxfunc = ''
Say 'AUTOLOAD: 'ParaKeys
Return 0

CHECKDEP:
Parse arg ParaKeys
Commands = '/FILE /MACROS'
File = '_STRING_'
Macros = '-FUNCTION -TYPE -ALL'
Macros.Function = '_STRING_'
Macros.Type = '_STRING_'
Macros.All = ''
Parse arg ParaKeys
Say 'CHECKDEP: 'ParaKeys
Return 0

CHECKTOK:
Parse arg ParaKeys
Checktok = '/ALL /TYPE /FUNCTION'
All = ''
Type = '_STRING_'
Function = '_STRING_'
Say 'CHECKTOK: 'ParaKeys
Return 0

INIT:
Parse arg ParaKeys
Say 'INIT: 'ParaKeys
Return 0

LIST:
Parse arg ParaKeys
List = '/MACROS /RXFUNC'
Macros = '-ALL -FUNCTION'
Macros.All = ''
Macros.Function = '_STRING_'
Rxfunc = '-ALL -DLL'
Rxfunc.All = ''
Rxfunc.Dll = '_STRING_'
Say 'LIST: 'ParaKeys
Return 0

LOAD:
Parse arg ParaKeys
Load = '/FILE /FUNCTION /TYPE /RXFUNC /RXFUNCF'
File = '_STRING_'
Function = '_STRING_'
Type = '_STRING_'
Rxfunc = '_STRING_'
Rxfuncf = '_STRING_'
Say 'LOAD: 'ParaKeys
Return 0

TOKENIZE:
Parse arg ParaKeys
ParaKeys = X2C(ParaKeys)

Tokenize = '/ALL /FILE /MACROS'
TempMat = SysRootPath'temp\current.mat'
Command = WordCheck(Tokenize, ParaKeys)
CWords = Words(ParaKeys)
/*                                              */
/* Save current rexxmacrospace to temporary     */
/* .mat file and drop current rexxmacrospace    */
/*                                              */
Say Center('Begin TOKENIZE... prepare.', 40, 'DB'x)
Call SysSaveRexxMacroSpace(TempMat)
Call Resulter Result
Say Left('Save current RexxMacroSpace:', 40, '.')||Result
Call SysClearRexxMacroSpace
Say Left('Drop current RexxMacroSpace:', 40, '.')||'Ok'
Select
/* Tokenize All macrofiles in All types         */
    When Command = '/ALL' & CWords = 1 Then Do
        Say Center('Begin TOKENIZE /All', 40, 'DB'x)
        Call SysFileTree Sys.RootPath'lib\*.mac', 'Files', 'FSO', '*****', '*****'
        Do Idx = 1 To Files.0
        say '*** Files.'Idx' 'Files.Idx
            TmpName = FileSpec('Name', Files.Idx)
            Function = Substr(TmpName, 1, LastPos('.', TmpName) - 1)
            TmpName = FileSpec('Drive', Files.Idx) || FileSpec('Path', Files.Idx)

            Say Center('Tokenize 'Function' Begin', 40, '_')
            Call SysAddRexxMacro Function, Files.Idx
            Call Resulter Result
            Say Left('Loading 'Function, 40, '.')||Result
            Call SysSaveRexxMacroSpace TmpName'\'Function'.mat'
            Call Resulter Result
            Say Left('Tokenize 'Function, 40, '.')||Result
            Call SysDropRexxMacro Function
            Call Resulter Result
            Say Left('Dropping 'Function, 40, '.')||Result
            Say Center('Tokenize 'Function' End'CrLf, 40, '_')
        End
        Say Center('End TOKENIZE /All', 40, 'DB'x)
    End
    When Command = '/FILE' & CWords = 2 Then Do
        Say '*** NOP'
    End
    When Command = '/MACROS' & CWords = 2 Then Do
        Say '*** NOP'
    End
    Otherwise
        Say '*** Error!!!'
End
/*                                              */
/* Drop current rexxmacrospace and load         */
/* previous saved rexxmacrospace from temporary */
/* .mat file and delete it                      */
/*                                              */
Say Center('End TOKENIZE... restore previous state.', 40, 'DB'x)
Call SysClearRexxMacroSpace
Say Left('Drop current RexxMacroSpace:', 40, '.')||'Ok'
Call SysLoadRexxMacroSpace(TempMat)
Call Resulter Result
Say Left('Load previous RexxMacroSpace:', 40, '.')||Result
Call SysFileDelete(TempMat)
Call Resulter Result
Say Left('Deleting temporary .mat', 40, '.')||Result
Say Center('TOKENIZE has ended.', 40, 'DB'x)
Return 0

UNLOAD:
Parse arg ParaKeys
Unload = '/ALL /FUNCTION /TYPE /RXFUNC /RXFUNCF'
All = '-MACROS -RXFUNC'
All.Macros = ''
All.Rxfunc = ''
Function = '_STRING_'
Type = '_STRING_'
Rxfunc = '_STRING_'
Rxfuncf = '_STRING_'
Say 'UNLOAD: 'ParaKeys
Return 0

WordCheck:
Parse arg Template, String
If Template \= '_STRING_' Then Do
    Do Count = 1 To Words(Template)
        If Compare(Word(Template, Count), String) = 0 Then
            Return String
    End
    Return 'ERROR1'
End
Else Return Template

Resulter:
Parse Arg Result
If Result = 0 Then
                Result = 'Ok'
            Else
                Result = 'Error! ('Result')'
Return Result