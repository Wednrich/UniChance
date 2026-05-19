@echo off
cd /d "%~dp0"
echo Starting UniChance Flutter Web...
echo.
echo Keep this window open while using the site.
echo If Chrome/Edge opens a blank old tab, open: http://localhost:8090
echo.
flutter run -d chrome --web-port 8090
pause
