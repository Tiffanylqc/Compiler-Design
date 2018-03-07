@echo off
for /f "delims=" %%a in ('dir /a-d/b "\\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\typechecking\*.pika"') do (
 java -jar \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\compiler.jar "\\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\typechecking\%%a" 2>NUL
 \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\ASM_Emulator\ASMEmu.exe .\output\%%~na.asm > \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\typechecking\actual\%%~na.txt
 fc \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\typechecking\actual\%%~na.txt \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\typechecking\expected\%%~na.txt > nul
 if ERRORLEVEL 1 echo Different "%%a"
 )