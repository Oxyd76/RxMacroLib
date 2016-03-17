/* System stemmed vars for many scripts and macros */
/* Vars is stored in RxM. stem (System Stem)       */

Stem = RxMStemInit()
Interpret Stem
If RxM.RxMVer = 'RXM.RXMVER' Then
   Do
      Say Center('Error in RxMStemInit!', 40, '.')
      Exit 1
   End

Say Center('Print RxM stem values', 40, '_')
Say
Say Left('RxM.RxMVer   = ', 40, '.')||RxM.RxMVer
Say Left('RxM.DirSep   = ', 40, '.')||RxM.DirSep
Say Left('RxM.UxDirSep = ', 40, '.')||RxM.UxDirSep
Say Left('RxM.Space    = ', 40, '.')||RxM.Space
Say Left('RxM.None     = ', 40, '.')||RxM.None
Say Left('RxM.CrLf     = ', 40, '.')||RxM.CrLf
Say Left('RxM.Cr       = ', 40, '.')||RxM.Cr
Say Left('RxM.Lf       = ', 40, '.')||RxM.Lf
Say Left('RxM.Bell     = ', 40, '.')||RxM.Bell
Say Left('RxM.SemCol   = ', 40, '.')||RxM.SemCol

Exit 0



