@echo off
echo 开始执行Git提交和推送操作...
git add .
if %errorlevel% neq 0 (
    echo Git add 命令执行失败！
    goto :end
)
git commit -m "发布"
if %errorlevel% neq 0 (
    echo Git commit 命令执行失败！
    goto :end
)
git push
if %errorlevel% neq 0 (
    echo Git push 命令执行失败！
    goto :end
)
echo 所有Git操作已成功完成！
:end