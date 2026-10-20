@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ===== 开始同步 Obsidian 知识库 =====

echo.
echo [1/3] 拉取远程最新内容...
git pull origin main
if errorlevel 1 (
    echo.
    echo [提示] 拉取失败，可能是网络问题或存在冲突，请检查后再试。
    pause
    exit /b 1
)

echo.
echo [2/3] 提交本地修改...
git add .
git diff --cached --quiet
if not errorlevel 1 (
    echo 没有新的修改，无需提交。
) else (
    git commit -m "sync: %date% %time%"
)

echo.
echo [3/3] 推送到 GitHub...
git push origin main
if errorlevel 1 (
    echo.
    echo [提示] 推送失败，网络可能不稳定，请重新双击运行本脚本重试。
    pause
    exit /b 1
)

echo.
echo ===== 同步完成！=====
pause
