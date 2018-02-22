@echo off
for /f "delims=" %%a in ('dir /a-d/b "*.pika"') do (
java -jar U:\git\pika\compiler.jar "%%~dpnxa"
U:\git\pika\ASM_Emulator\ASMEmu.exe .\output\%%~na.asm > .\actual\%%~na.txt
)