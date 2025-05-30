Esse Script é uma documentação e um passo a passo para fazer uma limpeza nos computadores lentos.

O que esse Script faz? Limpeza das pastas de arquivos temporarios: %TEMP%, C:Windows\Temp, Prefetch.

Execução da limpeza de Disco (clearmgr) com o perfil salvo.

Limpeza automatica da lixeira.

Para seguir com o codigo e ter um melhor uso, crie uma pasta em C:\Scripts\limpeza.bat

### Codigo:

```powershell
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
```

## Importante!

Execute esse arquivo como Administrador.

Na primeira execução, a janela do `cleanmgr /sageset:1` vai aparecer. Marque as opções que deseja limpar e feche.

# Para um melhor aproveitamento e automação da tarefa de limpeza a cada semana.

1. Abra o CMD como ADMINISTRADOR.
    
    Cole o codigo abaixo, modifique conforme a necessidade. Os comando usados estara logo abaixo.
    
    ```powershell
    schtasks /create ^
     /tn "Limpeza_Automatica_Sistema" ^
     /tr "cmd /c \"C:\Scripts\limpeza.bat\"" ^
     /sc weekly ^
     /d MON ^
     /st 12:00 ^
     /ru "SYSTEM" ^
     /rl HIGHEST ^
     /f
    ```
    
- `/tn "Limpeza_Automatica_Sistema"` → nome da tarefa.
- `/tr "cmd /c \"C:\Scripts\limpeza.bat\""` → executa o `.bat` com `cmd /c`.
- `/sc weekly /d SUN /st 12:00` → agenda para **domingo às 12:00h**.
- `/ru "SYSTEM"` → roda como **usuário SYSTEM**, com acesso total e sem pedir senha.
- `/rl HIGHEST` → executa com **nível mais alto de privilégios (admin)**.
- `/f` → força a criação (substitui se já existir).

Podemos verificar se a tarefa realmente foi criada:

```powershell
schtasks /query /tn "Limpeza_Automatica_Sistema"
```

Se quiser excluir a tarefa:

```powershell
schtasks /delete /tn "Limpeza_Automatica_Sistema" /f
```

Esse agendador tambem pode ser executado com um .bat para agendar as tarefa.

Crie ele na pasta de Scripts e execute como admin.

```powershell
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
```
