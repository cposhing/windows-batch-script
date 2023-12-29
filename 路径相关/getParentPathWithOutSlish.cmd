@echo off 

set SCRIPT=%0

for %%I in (%SCRIPT%) do set MONGO_HOME=%%~dpI
for %%I in ("%MONGO_HOME%..") do set MONGO_HOME=%%~dpfI

echo %MONGO_HOME%

pause 