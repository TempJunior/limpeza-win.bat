@echo off
title Limpeza de Arquivos Temporários e Lixeira
echo.
echo Limpando pastas TEMP, %TEMP%, PREFETCH e Lixeira...
echo.

:: Limpar %TEMP%
echo Limpando %%TEMP%%...
del /s /q "%TEMP%\*.*" 2>nul
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" 2>nul

:: Limpar C:\Windows\Temp
echo Limpando C:\Windows\Temp...
del /s /q "C:\Windows\Temp\*.*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

:: Limpar C:\Windows\Prefetch
echo Limpando PREFETCH...
del /s /q "C:\Windows\Prefetch\*.*" 2>nul
for /d %%i in ("C:\Windows\Prefetch\*") do rd /s /q "%%i" 2>nul

:: Limpar a Lixeira
echo Limpando Lixeira...
PowerShell.exe -Command "Clear-RecycleBin -Force"

:: Executar Limpeza de Disco com perfil salvo
echo.
echo Executando Limpeza de Disco com perfil salvo...

:: Criar perfil se ainda não existir
if not exist "%systemdrive%\cleanmgr.sageset.txt" (
    cleanmgr /sageset:1
    echo Salve as opções desejadas (Arquivos Temporários, Miniaturas, etc.) e depois feche a janela.
    pause
)

cleanmgr /sagerun:1

echo.
echo LIMPEZA COMPLETA!
pause