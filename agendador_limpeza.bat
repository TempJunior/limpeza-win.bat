@echo off
title Criando tarefa agendada de limpeza do sistema
echo.
echo Criando tarefa no Agendador para rodar toda segunda-feira às 12h...
echo.

schtasks /create ^
 /tn "Limpeza_Automatica_Sistema" ^
 /tr "cmd /c \"C:\Scripts\limpeza.bat\"" ^
 /sc weekly ^
 /d MON ^
 /st 12:00 ^
 /ru "SYSTEM" ^
 /rl HIGHEST ^
 /f

echo.
echo Tarefa criada com sucesso! Verifique no Agendador de Tarefas.
pause
