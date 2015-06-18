@ECHO OFF

IF "%1"=="" GOTO NO_ARG

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('%1'))" 

GOTO EOF

:NO_ARG
ECHO Please supply URL to script

:EOF