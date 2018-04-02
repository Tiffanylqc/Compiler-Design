@echo off
for /f "delims=" %%a in ('dir /a-d/b "\\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-4\*.pika"') do (
 java -jar \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\compiler.jar "\\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-4\%%a" 2>NUL
 \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\ASM_Emulator\ASMEmu.exe .\output\%%~na.asm > \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-4\actual\%%~na.txt
fc \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-4\actual\%%~na.txt \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-4\expected\%%~na.txt > nul
 if ERRORLEVEL 1 echo Different "%%a"
 )