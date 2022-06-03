@echo off

echo - Liberation_RX PBO build script -
del /f *.pbo  > nul 2>&1

for /f %%i in ('dir /B /A:D ..\maps-MilSimUnited\liberation_RX*') do (
	echo.
	echo Building PBO for map %%i 
	xcopy /Q /E /Y ..\core.liberation .\%%i\
	xcopy /Q /E /Y ..\maps-MilSimUnited\%%i .\%%i\
	if exist .\custom\ xcopy /Q /E /Y .\custom .\%%i\
	bin\PBOConsole.exe -pack %%i .\%%i.pbo  > nul 2>&1
	rmdir /S /Q %%i
	echo Done.
)

exit