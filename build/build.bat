@echo off

echo - Liberation_RX PBO build script -
del /f *.pbo  > nul 2>&1

set GRLIB_file="..\core.liberation\build_info.sqf"
echo //Liberation_RX was build on : > %GRLIB_file%
echo GRLIB_build_date = "%DATE%"; >> %GRLIB_file%
echo GRLIB_build_time = "%TIME:~0,8%"; >> %GRLIB_file%
echo diag_log format ["Build date: %%1", GRLIB_build_date]; >> %GRLIB_file%

for /f %%i in ('dir /B /A:D ..\maps\liberation_RX*') do (
	echo.
	echo Building PBO for map %%i 
	xcopy /Q /E /Y ..\core.liberation .\%%i\
	xcopy /Q /E /Y ..\maps\%%i .\%%i\
	if exist .\custom\ xcopy /Q /E /Y .\custom .\%%i\
	bin\PBOConsole.exe -pack %%i .\%%i.pbo  > nul 2>&1
	rmdir /S /Q %%i
	echo Done.
)

pause