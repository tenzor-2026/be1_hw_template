#!/bin/bash

# 测试获取学生信息功能
echo "=== 测试获取学生信息功能 ==="


echo "测试1: 获取所有学生信息（初始状态，应该为空）"
echo "期望输出: nothing"
result1=$(./zx -get)
echo "实际输出: $result1"
echo ""

echo "测试2: 添加学生后获取信息"
echo "添加学生1: Asice Cloud,18,{read,write}"
./zx -add "Asice Cloud,18,{read,write}"

echo "添加学生2: xhh 哥哥是18岁天才美少女,18,{all}"
./zx -add "xhh 哥哥是18岁天才美少女,18,{all}"

echo "添加学生3: Test User,20,{read,write,run}"
./zx -add "Test User,20,{read,write,run}"

echo ""
echo "现在获取所有学生信息:"
echo "期望输出格式:"
echo '{'
echo '    "data":['
echo '        {'
echo '            "id":1,'
echo '            "username":"Asice Cloud",'
echo '            "age": 18,'
echo '            "permission": ["read","write"]'
echo '        },'
echo '        ..'
echo '    ]'
echo '}'
echo ""
echo "实际输出:"
./zx -get
echo ""

echo "=== 获取信息测试完成 ==="