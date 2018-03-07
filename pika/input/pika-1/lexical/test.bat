@echo off
rem dir \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\lexical
for /f "delims=" %%a in ('dir /a-d/b "\\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\lexical\*.pika"') do (
 java -jar \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\compiler.jar "\\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\lexical\%%a" 2>NUL
 \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\ASM_Emulator\ASMEmu.exe .\output\%%~na.asm > \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\lexical\actual\%%~na.txt
 fc \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\lexical\actual\%%~na.txt \\Mac\Home\Documents\CMPT379\Compiler-Design\pika\input\pika-1\lexical\expected\%%~na.txt
 if ERRORLEVEL 1 echo Different "%%a"
 )