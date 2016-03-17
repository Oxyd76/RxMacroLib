/* Test for RxMReadCfg macrospace function      */

/*                                              */
/* Init RxMStemInit                             */
/*                                              */
If SysQueryRexxMacro(RxMStemInit) Then
   Call SysDropRexxMacro RxMStemInit
Call SysAddRexxMacro RxMStemInit, '..\lib\rxmacro\RxMStemInit.mac'
Say Left('SysAddRexxMacro RxMStemInit status:', 40, '.')||result
RxM = RxMStemInit()
Interpret RxM

/*                                              */
/* Raw / ARaw Config Testing                    */
/*                                              */
Say Center('(A)Raw Config testing', 40, '_')
RawName = '.\raw.cfg'
RawCfg = '; line1 is comment line'RxM.CrLf,
         'line2'RxM.CrLf,
         ' line3 Cool ;with comment and space'

Call Lineout RawName, RawCfg
Say Left('Create raw.cfg:', 40, '.')||Result
Call Stream RawName, 'C', 'Close'

res = RxMReadCfg(RawName, 'Stem', 'raw')
If Word(res,1) = 'ERROR' Then Do
   Say Left('RxMReadCfg result:', 40, '.')||Word(res, 1)
   Say Center('Error in RxMReadCfg RAW reading!', 40, '.')
   Call SysFileDelete RawName
   Say Left('Delete raw.cfg:', 40, '.')||Result
   Exit 1
End

Interpret res
Say RxM.CrLf

Say Center('Stem RAW lines: 'Stem.0, 40, '.')
Do Count = 1 To Stem.0
   Say Left('Stem.'Count' = ', 40, '.')||Stem.Count
End

/* ARAW                                         */

res = RxMReadCfg(RawName, 'Stem', 'araw')
If Word(res,1) = 'ERROR' Then Do
   Say Left('RxMReadCfg result:', 40, '.')||Word(res, 1)
   Say Center('Error in RxMReadCfg RAW reading!', 40, '.')
   Call SysFileDelete RawName
   Say Left('Delete raw.cfg:', 40, '.')||Result
   Exit 1
End

Interpret res
Say RxM.CrLf

Say Center('Stem ARAW lines: 'Stem.0, 40, '.')
Do Count = 1 To Stem.0
   Say Left('Stem.'Count' = ', 40, '.')||Stem.Count
End


Call SysFileDelete RawName
Say Left('Delete raw.cfg:', 40, '.')||Result
Say Center('_', 40, '_')

Say RxM.CrLf

/*                                              */
/* Named Config Testing                         */
/*                                              */
Say Center('Named Config testing', 40, '_')
NamedName = '.\named.cfg'
NamedCfg = " ; line1 is comment line"RxM.CrLf,
           "Param1 = 1"RxM.CrLf,
           " Param2= 'stRing' ;with comment and leading space"

Call Lineout NamedName, NamedCfg
Say Left('Create named.cfg:', 40, '.')||Result
Call Stream NamedName, 'C', 'Close'

res = RxMReadCfg(NamedName, 'Stem')
If Word(res, 1) = 'ERROR' Then Do
   Say Left('RxMReadCfg result:', 40, '.')||Word(res, 1)
   Say Center('Error in RxMReadCfg reading!', 40, '.')
   Call SysFileDelete NamedName
   Say Left('Delete named.cfg:', 40, '.')||Result
   Exit 1
End

Interpret res
Say RxM.CrLf

Say Center('Stem Named lines: 'Stem.0, 40, '.')
Say Left('Param1 = ', 40, '.')||Stem.Param1
Say Left('Param2 = ', 40, '.')||Stem.Param2

Call SysFileDelete NamedName
Say Left('Delete named.cfg:', 40, '.')||Result
Say Center('_', 40, '_')

Say RxM.CrLf

/*                                              */
/* Exiting from test                            */
/*                                              */

call SysDropRexxMacro 'RxMStemInit'
say Left('SysDropRexxMacro RxMStemInit status:', 40, '.')||Result
Say RxM.CrLf

Say Center('Exiting from RxMReadCfg test', 40, '_')
Exit 0





