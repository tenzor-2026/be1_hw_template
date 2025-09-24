#!/bin/bash

if [ -f "go.mod" ]; then
    echo "找到go.mod文件,执行go mod tidy..."
    go mod tidy
    if [ $? -ne 0 ]; then
        echo "go mod tidy执行失败!退出..."
        exit 1
    fi
else
    echo "未找到go.mod文件,初始化Go模块..."
    MODULE_NAME=$(basename "$PWD")
    echo "执行: go mod init $MODULE_NAME"
    go mod init "$MODULE_NAME"
    if [ $? -ne 0 ]; then
        echo "go mod init执行失败!退出..."
        exit 1
    fi
    echo "Go模块初始化成功"
fi

echo "go build ."
go build .

if [ $? -ne 0 ]; then
    echo "编译失败！退出..."
    exit 1
fi

echo "编译成功！"
exit 0