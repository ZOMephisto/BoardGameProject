@echo off
title Lancement BoardGameProject

:: Chemins absolus pour plus de fiabilité
set PROJECT_ROOT=%cd%
set BACKEND_PATH=%PROJECT_ROOT%\backend
set FRONTEND_PATH=%PROJECT_ROOT%\frontend

:: Vérification Node.js
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js n'est pas installé ou n'est pas dans le PATH
    pause
    exit /b
)

:: Tuer les processus existants sur les ports 8080 et 5173
echo Fermeture des processus existants...
taskkill /F /IM node.exe >nul 2>&1

:: Installation des dépendances frontend
echo Installation des dependances frontend...
cd /d "%FRONTEND_PATH%"
call npm install --silent
cd /d "%PROJECT_ROOT%"

:: Lancement backend dans une nouvelle fenêtre
start "Backend" cmd /k "cd /d "%BACKEND_PATH%" && echo Lancement du backend... && node index.js"

:: Attente pour permettre au backend de démarrer
timeout /t 5 >nul

:: Lancement frontend dans une nouvelle fenêtre
start "Frontend" cmd /k "cd /d "%FRONTEND_PATH%" && echo Lancement du frontend... && npm run dev"

echo.
echo Les deux serveurs ont ete lances dans des fenetres separees
echo - Backend: http://localhost:8080
echo - Frontend: http://localhost:5173
echo.
pause