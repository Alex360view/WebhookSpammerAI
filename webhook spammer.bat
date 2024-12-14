@echo off
setlocal enabledelayedexpansion

:MENU
cls
echo ============================
echo       Main Menu
echo ============================
echo 1. Webhook Spammer
echo 2. Exit
echo ============================

set /p "CHOICE=Select an option (1 or 2): "

if "%CHOICE%"=="1" (
    goto SPAMMER
) else if "%CHOICE%"=="2" (
    echo Exiting the program. Goodbye!
    exit /b
) else (
    echo Invalid choice. Please select option 1 or 2.
    timeout /t 2 > nul
    goto MENU
)

:SPAMMER
cls
echo ============================
echo Discord Webhook Message Spammer
echo ============================

:: Ask for the Discord webhook URL
set /p "WEBHOOK_URL=Enter your Discord webhook URL: "

:: Ask for the message
set /p "MESSAGE=Enter the message you want to send: "

:: Ask how many times to send the message
set /p "COUNT=How many times do you want to send the message? "

:: Log file setup
set LOG_FILE=log.txt
echo Logging message sends to %LOG_FILE%
echo Message log started at %date% %time% >> %LOG_FILE%
echo ============================ >> %LOG_FILE%

:: Loop for sending the message
for /l %%i in (1,1,%COUNT%) do (
    curl -H "Content-Type: application/json" -d "{\"content\": \"%MESSAGE%\"}" "!WEBHOOK_URL!"
    if !ERRORLEVEL! neq 0 (
        echo Error sending message: !MESSAGE! >> %LOG_FILE%
        echo Error occurred during sending. Check your webhook URL or message format.
        goto END
    )
    echo Message sent: !MESSAGE!
    echo !MESSAGE! >> %LOG_FILE%
)

echo All messages sent!

:END
:: Ask if the user wants to send more messages
set /p "CONTINUE=Do you want to send more messages? (y/n): "

if /i "!CONTINUE!"=="y" (
    goto SPAMMER
) else (
    echo Exiting the program. Goodbye!
    pause
    exit /b
)