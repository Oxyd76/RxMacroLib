/* Test for MkDirBranch macrospace function     */

/*                                              */
/* Init RxMStemInit                             */
/*                                              */

RxM = RxMStemInit()
Interpret RxM

TestPath = '\test1\Test2\Test3\Test4'

/*                                              */
/* Full Path testing                            */
/*                                              */

Path = Directory()||TestPath
Say Center('Full path branch testing', 40, '_')
Say Left('Current path:', 40, '.')||Directory()
Say Left('Path to create:', 40, '.')||Path

Result = MkDirBranch(Path)
If Result \= 0 Then Do
   Say Left('MkDirBranch result:', 40, '.')||Result
   Say Center('Error in MkDirBranch!', 40, '.')
   Exit Result
End
Say Left('MkDirBranch result:', 40, '.')||Result
/* Remove test branch directories               */
Call RmTestBranch
Say RxM.CrLf

/*                                              */
/* From root Path testing                       */
/*                                              */

Say Center('From root path branch testing', 40, '_')
/* Path = FileSpec('Path', Directory())||FileSpec('Name', Directory())||TestPath||TestPath */
Say Left('Current path:', 40, '.')||Directory()
Say Left('Path to create:', 40, '.')||Path

Result = MkDirBranch(Path)
If Result \= 0 Then Do
   Say Left('MkDirBranch result:', 40, '.')||Result
   Say Center('Error in MkDirBranch!', 40, '.')
   Exit Result
End
Say Left('MkDirBranch result:', 40, '.')||Result
Call RmTestBranch
Say RxM.CrLf

/*                                              */
/* Relative, from current dir Path testing      */
/*                                              */

Say Center('Relative path branch testing', 40, '_')
/* Path = Strip(TestPath, 'Leading', RxM.DirSep)||TestPath||TestPath */
Say Left('Current path:', 40, '.')||Directory()
Say Left('Path to create:', 40, '.')||Path

Result = MkDirBranch(Path)
If Result \= 0 Then Do
   Say Left('MkDirBranch result:', 40, '.')||Result
   Say Center('Error in MkDirBranch!', 40, '.')
   Exit Result
End
Say Left('MkDirBranch result:', 40, '.')||Result
Call RmTestBranch

Exit Result

RmTestBranch:
Say Center('Deleting test branch', 40, '.')
Result = RmDirTree(Directory()||'\test1')
Say Left('RmDirTree result:', 40, '.')||Result
Return