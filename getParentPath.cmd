@echo off

@rem 获取当前脚本父路径
@rem get current script parent absourlate path 

FOR %%A IN ("%~dp0.") DO set HOME=%%~dpA
echo %HOME%

pause 