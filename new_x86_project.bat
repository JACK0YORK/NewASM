@echo off

set BASEDIR=%~dp0

rem Prompt the lab number
set /p a=Lab #: 

rem Create Correctly named files system.
xcopy /s /i %BASEDIR%%1 "%BASEDIR%workspace\%1"
ren "%BASEDIR%workspace\%1" "Lab_%a%"
ren "%BASEDIR%workspace\Lab_%a%\AddTwo.asm" "Problem_%a%.asm"

rem Removes the auto-generated comments.
findstr /v ";" %BASEDIR%workspace\Lab_%a%\Problem_%a%.asm > "%BASEDIR%workspace\Lab_%a%\temp.txt"
type "%BASEDIR%workspace\Lab_%a%\temp.txt">"%BASEDIR%\workspace\Lab_%a%\Problem_%a%.asm"
del "%BASEDIR%workspace\Lab_%a%\temp.txt"

rem Modifies the Project so it's looking for the correct file.
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=%BASEDIR%workspace\Lab_%a%\Project.vcxproj"
set "OUTTEXTFILE=%BASEDIR%workspace\Lab_%a%\test_out.txt"
set "SEARCHTEXT=AddTwo"
set "REPLACETEXT=Problem_%a%"

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)
del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "Project.vcxproj"
endlocal

rem Opens the project in visual studio
"%BASEDIR%workspace\Lab_%a%\Project.sln"| taskkill /F /IM cmd.exe