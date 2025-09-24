#!/bin/bash

echo "测试1: 添加学生 - Asice Cloud,18,{read,write}"
echo "期望输出: id:1"
result1=$(./zx -add "Asice Cloud,18,{read,write}")
echo "实际输出: $result1"
echo ""

echo "测试2: 添加学生 - xhh 哥哥是18岁天才美少女,18,{all}"
echo "期望输出: id:2"
result2=$(./zx -add "xhh 哥哥是18岁天才美少女,18,{all}")
echo "实际输出: $result2"
echo ""

echo "测试3: 添加学生 - Test User,20,{read,write,run} (三个权限应该转换为all)"
echo "期望输出: id:3"
result3=$(./zx -add "Test User,20,{read,write,run}")
echo "实际输出: $result3"
echo ""

echo "测试4: 添加学生 - Simple User,25,{read}"
echo "期望输出: id:4"
result4=$(./zx -add "Simple User,25,{read}")
echo "实际输出: $result4"
echo ""

echo "测试5: 错误格式测试 - 缺少参数"
echo "期望输出: Failed"
result5=$(./zx -add "InvalidUser")
echo "实际输出: $result5"
echo ""

echo "测试6: 错误格式测试 - 年龄非数字"
echo "期望输出: Failed"
result6=$(./zx -add "Test,abc,{read}")
echo "实际输出: $result6"
echo ""

echo "=== 添加测试完成 ==="