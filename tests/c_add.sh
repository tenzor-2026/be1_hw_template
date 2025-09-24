#!/bin/bash

rm -f ./students.json

echo "=== 测试add功能 ==="

echo "测试1: 添加学生 - Asice Cloud,18,{read,write}"
echo "期望输出: id:1"
result1=$(./zx -add "Asice Cloud,18,{read,write}")
echo "实际输出: $result1"
if [ "$result1" != "id:1" ]; then
    echo "❌ 测试1失败: 期望 'id:1', 实际 '$result1'"
    exit 1
fi
echo "✅ 测试1通过"
echo ""

echo "测试2: 添加学生 - xhh 哥哥是18岁天才美少女,18,{all}"
echo "期望输出: id:2"
result2=$(./zx -add "xhh 哥哥是18岁天才美少女,18,{all}")
echo "实际输出: $result2"
if [ "$result2" != "id:2" ]; then
    echo "❌ 测试2失败: 期望 'id:2', 实际 '$result2'"
    exit 1
fi
echo "✅ 测试2通过"
echo ""

echo "测试3: 添加学生 - Test User,20,{read,write,run} (三个权限应该转换为all)"
echo "期望输出: id:3"
result3=$(./zx -add "Test User,20,{read,write,run}")
echo "实际输出: $result3"
if [ "$result3" != "id:3" ]; then
    echo "❌ 测试3失败: 期望 'id:3', 实际 '$result3'"
    exit 1
fi
echo "✅ 测试3通过"
echo ""

echo "测试4: 添加学生 - Simple User,25,{read}"
echo "期望输出: id:4"
result4=$(./zx -add "Simple User,25,{read}")
echo "实际输出: $result4"
if [ "$result4" != "id:4" ]; then
    echo "❌ 测试4失败: 期望 'id:4', 实际 '$result4'"
    exit 1
fi
echo "✅ 测试4通过"
echo ""

echo "测试5: 错误格式测试 - 缺少参数"
echo "期望输出: Failed"
result5=$(./zx -add "InvalidUser")
echo "实际输出: $result5"
if [ "$result5" != "Failed" ]; then
    echo "❌ 测试5失败: 期望 'Failed', 实际 '$result5'"
    exit 1
fi
echo "✅ 测试5通过"
echo ""

echo "测试6: 错误格式测试 - 年龄非数字"
echo "期望输出: Failed"
result6=$(./zx -add "Test,abc,{read}")
echo "实际输出: $result6"
if [ "$result6" != "Failed" ]; then
    echo "❌ 测试6失败: 期望 'Failed', 实际 '$result6'"
    exit 1
fi
echo "✅ 测试6通过"
echo ""

echo "🎉 === 所有add测试通过！ ==="