@echo off
setlocal

echo ====================== Git 发布脚本 ======================

:: 检查参数
if "%1"=="" (
    set commit_msg="发布"
) else (
    set commit_msg=%1
)

:: 检查当前目录是否为 Git 仓库
git rev-parse --is-inside-work-tree >nul 2>&1
if %errorLevel% neq 0 (
    echo 错误：当前目录不是 Git 仓库，请先执行 git init
    goto :end
)

:: 交互式选择操作
:menu
cls
echo 1. 仅添加文件 (git add .)
echo 2. 添加并提交 (git add . && git commit)
echo 3. 完整发布 (add + commit + push)
echo 4. 仅推送 (git push)
echo 0. 退出

set /p choice=请选择操作 (0-4): 
if %choice%==0 goto :end
if %choice%==1 goto :add
if %choice%==2 goto :add_commit
if %choice%==3 goto :publish
if %choice%==4 goto :push
goto :menu

:add
echo 正在添加所有文件...
git add .
goto :end

:add_commit
echo 正在添加所有文件...
git add .
echo 正在提交更改 (消息: %commit_msg%)...
git commit -m %commit_msg%
goto :end

:publish
echo 正在拉取远程最新代码...
git pull origin main
echo 正在添加所有文件...
git add .
echo 正在提交更改 (消息: %commit_msg%)...
git commit -m %commit_msg%
echo 正在推送至远程仓库...
git push origin main
goto :end

:push
echo 正在推送至远程仓库...
git push origin main
goto :end

:end
echo ====================== 操作完成 ======================
pause