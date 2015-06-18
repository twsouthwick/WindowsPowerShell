@ECHO OFF

IF "%1"=="" GOTO NO_ARG

@powershell -NoProfile -ExecutionPolicy ByPass -Command "Invoke-WebRequest '%1' | Invoke-Expression" 

GOTO EOF

:NO_ARG
ECHO Please supply URL to script

:EOF