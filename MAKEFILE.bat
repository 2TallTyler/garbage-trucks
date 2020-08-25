@ECHO OFF

ECHO Running GoRender

rem ECHO Rendering Mack Model R
rem C:\Users\train\Documents\gorender\renderobject.exe -input voxel\mack_model_r.vox -manifest files\manifest.json -output src\gfx\mack_model_r  -8 -s 1,2,4


ECHO Batch: Running Python file merger
python %~dp0\nmlc\merge_nml.py

ECHO Batch: Copying merged file to src/merged directory
copy /y /v %~dp0\nmlc\garbage_trucks.nml %~dp0\src\merged\garbage_trucks.nml

ECHO Batch: Running NMLC compiler
%~dp0\nmlc\nmlc -c -t src\custom_tags.txt -l src\lang --grf garbage_trucks.grf nmlc\garbage_trucks.nml

ECHO Batch: Cleaning up
DEL %~dp0\nmlc\garbage_trucks.nml

set /P c=Complete!
if /I "%c%" EQU "TT" (goto :copy
) else (exit)

:copy
ECHO Copying to NewGRF directory
copy /y /v %~dp0\garbage_trucks.grf C:\Users\train\Documents\OpenTTD\newgrf\
pause
exit
