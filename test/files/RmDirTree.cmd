/* Test for RmDirTree macrospace function       */

/*                                              */
/* Init RxMStemInit                             */
/*                                              */

RxM = RxMStemInit()
Interpret RxM

TestPath = '\test1\Test2\Test3\Test4'
DelPath = ''

/*                                              */
/* Check and create branch if not present       */
/*                                              */

Say Center('Create directory tree with files', 40, '_')
Path = Directory()||TestPath
Say Left('Current path:', 40, '.')||Directory()
Say Left('Path to create:', 40, '.')||Path

Result = MkDirBranch(Path)
If Result \= 0 Then Do
   Say Left('MkDirBranch result:', 40, '.')||Result
   Say Center('Error in MkDirBranch!', 40, '.')
   Exit Result
End
Say Left('MkDirBranch result:', 40, '.')||Result
Say Left('File to create:', 40, '.')||Path||RxM.DirSep||'test.del'
/* Near future override this with RxMTouch()    */
Call Stream Path||RxM.DirSep||'test.del', 'C', 'Open Write'
Call Stream Path||RxM.DirSep||'test.del', 'C', 'Close'
Say Left('Create file result:', 40, '.')||Result
Say RxM.CrLf

/*                                              */
/* Delete directory tree via RmDirTree()        */
/*                                              */

Say Center('Delete directory tree via RmDirTree()', 40, '_')
Result = RmDirTree(Directory()||RxM.DirSep||'test1')
If Result \= 0 Then Do
   Say Left('RmDirTree result:', 40, '.')||Result
   Say Center('Error in MkDirBranch!', 40, '.')
   Exit Result
End
Say Left('RmDirTree result:', 40, '.')||Result

Exit Result