#!/bin/bash

# 测试帮助功能
echo "=== 测试帮助功能 ==="

echo "测试1: 显示帮助信息"
echo "执行命令: ./zx -h"
echo ""
echo "实际输出:"
echo "----------------------------------------"
help_output=$(./zx -h)
echo "$help_output"
echo "----------------------------------------"
echo ""

echo "验证帮助信息是否包含所有必要内容:"

# 检查是否包含add命令说明
if echo "$help_output" | grep -i "add" > /dev/null; then
    echo "✓ 包含add命令说明"
else
    echo "✗ 缺少add命令说明"
fi

# 检查是否包含get命令说明
if echo "$help_output" | grep -i "get" > /dev/null; then
    echo "✓ 包含get命令说明"
else
    echo "✗ 缺少get命令说明"
fi

# 检查是否包含help/h命令说明
if echo "$help_output" | grep -i -E "(help|^.*-h)" > /dev/null; then
    echo "✓ 包含help命令说明"
else
    echo "✗ 缺少help命令说明"
fi

# 检查是否包含使用示例
if echo "$help_output" | grep -E "(zx.*-add|zx.*-get|zx.*-h)" > /dev/null; then
    echo "✓ 包含使用示例"
else
    echo "✗ 缺少使用示例"
fi

# 检查是否提到权限相关信息
if echo "$help_output" | grep -i -E "(read|write|run|permission|权限)" > /dev/null; then
    echo "✓ 包含权限说明"
else
    echo "✗ 缺少权限说明"
fi

echo ""

echo "测试2: 无参数运行程序（应该提示查看帮助）"
echo "执行命令: ./zx"
no_arg_output=$(./zx 2>&1)
echo "实际输出: $no_arg_output"

if echo "$no_arg_output" | grep -i -E "(help|帮助|-h)" > /dev/null; then
    echo "✓ 正确提示查看帮助信息"
else
    echo "✗ 未正确提示查看帮助信息"
fi

echo ""
