@echo off
cd /d "%~dp0"
echo Building UniChance Web...
flutter build web
if errorlevel 1 (
  echo Build failed.
  pause
  exit /b 1
)
cd build\web
echo.
echo Serving UniChance at http://127.0.0.1:8090
echo Keep this window open while using the site.
echo.
python -m http.server 8090 --bind 127.0.0.1
pause
