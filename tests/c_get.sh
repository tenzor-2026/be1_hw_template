#!/bin/bash

# 清理环境，删除之前的数据文件
rm -f *.json

echo "=== 测试get功能 ==="

echo "测试1: 获取所有学生信息（初始状态，应该为空）"
echo "期望输出: nothing"
result1=$(./zx -get)
echo "实际输出: $result1"
if [ "$result1" != "nothing" ]; then
    echo "❌ 测试1失败: 期望 'nothing', 实际 '$result1'"
    exit 1
fi
echo "✅ 测试1通过"
echo ""

echo "测试2: 添加学生后获取信息"
echo "添加学生1: Asice Cloud,18,{read,write}"
add_result1=$(./zx -add "Asice Cloud,18,{read,write}")
if [ "$add_result1" != "id:1" ]; then
    echo "❌ 添加学生1失败"
    exit 1
fi

echo "添加学生2: xhh 哥哥是18岁天才美少女,18,{all}"
add_result2=$(./zx -add "xhh 哥哥是18岁天才美少女,18,{all}")
if [ "$add_result2" != "id:2" ]; then
    echo "❌ 添加学生2失败"
    exit 1
fi

echo ""
echo "现在获取所有学生信息:"
get_result=$(./zx -get)
echo "实际输出:"
echo "$get_result"

# 检查是否包含JSON格式的关键字段
if ! echo "$get_result" | grep -q '"data"'; then
    echo "❌ 测试2失败: 输出中缺少 'data' 字段"
    exit 1
fi

if ! echo "$get_result" | grep -q '"id":1'; then
    echo "❌ 测试2失败: 输出中缺少学生1的ID"
    exit 1
fi

if ! echo "$get_result" | grep -q '"username":"Asice Cloud"'; then
    echo "❌ 测试2失败: 输出中缺少学生1的姓名"
    exit 1
fi

if ! echo "$get_result" | grep -q '"id":2'; then
    echo "❌ 测试2失败: 输出中缺少学生2的ID"
    exit 1
fi

if ! echo "$get_result" | grep -q '"username":"xhh 哥哥是18岁天才美少女"'; then
    echo "❌ 测试2失败: 输出中缺少学生2的姓名"
    exit 1
fi

echo "✅ 测试2通过"
echo ""

echo "测试3: 添加不同权限组合的学生"
echo "添加学生3: 张三,20,{read}"
add_result3=$(./zx -add "张三,20,{read}")
if [ "$add_result3" != "id:3" ]; then
    echo "❌ 添加学生3失败"
    exit 1
fi

echo "添加学生4: 李四,25,{write}"
add_result4=$(./zx -add "李四,25,{write}")
if [ "$add_result4" != "id:4" ]; then
    echo "❌ 添加学生4失败"
    exit 1
fi

echo "添加学生5: 王五,30,{run}"
add_result5=$(./zx -add "王五,30,{run}")
if [ "$add_result5" != "id:5" ]; then
    echo "❌ 添加学生5失败"
    exit 1
fi

echo "添加学生6: 赵六,22,{read,write,run} (应转换为all)"
add_result6=$(./zx -add "赵六,22,{read,write,run}")
if [ "$add_result6" != "id:6" ]; then
    echo "❌ 添加学生6失败"
    exit 1
fi

echo ""
echo "获取包含多种权限的学生信息:"
get_result3=$(./zx -get)
echo "实际输出:"
echo "$get_result3"

# 验证所有学生都在输出中
for i in {1..6}; do
    if ! echo "$get_result3" | grep -q "\"id\":$i"; then
        echo "❌ 测试3失败: 输出中缺少学生$i的ID"
        exit 1
    fi
done

# 验证权限处理
if ! echo "$get_result3" | grep -q '"permission":\["read"\]'; then
    echo "❌ 测试3失败: 学生3的单一权限格式不正确"
    exit 1
fi

if ! echo "$get_result3" | grep -q '"permission":\["all"\]'; then
    echo "❌ 测试3失败: 三权限转换为all失败"
    exit 1
fi

echo "✅ 测试3通过"
echo ""

echo "测试4: 特殊字符和边界值测试"
echo "添加学生7: User@#$%,1,{read,write}"
add_result7=$(./zx -add "User@#$%,1,{read,write}")
if [ "$add_result7" != "id:7" ]; then
    echo "❌ 添加学生7失败"
    exit 1
fi

echo "添加学生8: 测试 用户,99,{write,run}"
add_result8=$(./zx -add "测试 用户,99,{write,run}")
if [ "$add_result8" != "id:8" ]; then
    echo "❌ 添加学生8失败"
    exit 1
fi

echo ""
echo "获取包含特殊字符的学生信息:"
get_result4=$(./zx -get)

# 验证特殊字符学生
if ! echo "$get_result4" | grep -q '"username":"User@#\$%"'; then
    echo "❌ 测试4失败: 特殊字符用户名处理失败"
    exit 1
fi

if ! echo "$get_result4" | grep -q '"age":1'; then
    echo "❌ 测试4失败: 最小年龄边界值处理失败"
    exit 1
fi

if ! echo "$get_result4" | grep -q '"age":99'; then
    echo "❌ 测试4失败: 大年龄值处理失败"
    exit 1
fi

echo "✅ 测试4通过"
echo ""

echo "测试5: 验证JSON结构完整性"
echo "当前应该有8个学生"
student_count=$(echo "$get_result4" | grep -o '"id":[0-9]*' | wc -l)
if [ "$student_count" != "8" ]; then
    echo "❌ 测试5失败: 期望8个学生，实际$student_count个"
    exit 1
fi

# 验证JSON基本结构
if ! echo "$get_result4" | grep -q '^{"data":\[.*\]}$'; then
    echo "❌ 测试5失败: JSON整体结构不正确"
    exit 1
fi

# 验证每个学生都有必需字段
required_fields=("id" "username" "age" "permission")
for field in "${required_fields[@]}"; do
    field_count=$(echo "$get_result4" | grep -o "\"$field\":" | wc -l)
    if [ "$field_count" != "8" ]; then
        echo "❌ 测试5失败: 字段'$field'数量不正确，期望8个，实际$field_count个"
        exit 1
    fi
done

echo "✅ 测试5通过"
echo ""

echo "测试6: 清空数据后重新测试"
rm -f ./students.json

empty_result=$(./zx -get)
if [ "$empty_result" != "nothing" ]; then
    echo "❌ 测试6失败: 清空数据后应返回'nothing'，实际'$empty_result'"
    exit 1
fi

echo "✅ 测试6通过"
echo ""

echo "🎉 === 所有get测试通过！(共6个测试场景) ==="