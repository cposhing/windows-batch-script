@echo off

@rem 获取当前脚本绝对路径
@rem get current script absourlate path 

set DP_HOME=%~dp0
echo DP_HOME is %DP_HOME%

set CD_HOME=%CD%
echo CD_HOME is %CD_HOME%

set SCRIPT=%0
for %%I in (%SCRIPT%) do set FOR_HOME=%%~dpI

echo FOR_HOME is %FOR_HOME%


@setlocal EnableExtensions EnableDelayedExpansion
set SCRIPT=%0

for %%I in (%SCRIPT%) do set home=%%~dpI
for %%I in ("%home%.") do set home=%%~dpfI
@endlocal & set SCRPIT_HOME=%home%

echo SCRPIT_HOME %SCRPIT_HOME%

pause 