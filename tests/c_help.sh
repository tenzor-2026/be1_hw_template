#!/bin/bash

echo "=== 测试help功能 ==="

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
    echo "✅ 包含add命令说明"
else
    echo "❌ 缺少add命令说明"
    exit 1
fi

# 检查是否包含get命令说明
if echo "$help_output" | grep -i "get" > /dev/null; then
    echo "✅ 包含get命令说明"
else
    echo "❌ 缺少get命令说明"
    exit 1
fi

# 检查是否包含help/h命令说明
if echo "$help_output" | grep -i -E "h" > /dev/null; then
    echo "✅ 包含help命令说明"
else
    echo "❌ 缺少help命令说明"
    exit 1
fi

