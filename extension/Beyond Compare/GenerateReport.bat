@echo off
if "%~1"=="" (echo Error: No compare file 1 passed with script!) & (goto EXIT)
if "%~2"=="" (echo Error: No compare file 2 passed with script!) & (goto EXIT)
if "%~3"=="" (echo Error: No report file passed with script!) & (goto EXIT)
set FL1=%~1
set FL2=%~2
set FLReport=%~3
pushd "%~dp0"
BComp.com /closescript "@%~dp0GenerateReport.txt" "%FL1%" "%FL2%" "%FLReport%"
BComp.com /fv="Text Compare" /qc /ignoreunimportant "%FL1%" "%FL2%"
goto result%errorlevel%
:result0
echo pass:Success
GOTO :EOF
:result1
echo pass:Binary Same
GOTO :EOF
:result2
echo pass:Rules-Based Same
GOTO :EOF
:result11
echo fail:Binary Difference
GOTO :EOF
:result12
echo fail:Similar
GOTO :EOF
:result13
echo fail:Rules-Based Difference
GOTO :EOF
:result14
echo fail:Conflicts Detected
GOTO :EOF
:result100
echo error:Unknown error
GOTO :EOF
:result101
echo error:Conflicts Detected.  Merge output not written.
GOTO :EOF

:EOF