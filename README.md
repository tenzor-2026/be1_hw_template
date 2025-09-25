# 后端第一次作业

**test/\*,cmd/\*路径， main.go 均为模板，不允许修改**
**主要在service/ model/下完善数据定义和逻辑设计，service/init.go文件会自动导入不建议更改.**

## 说明

这次作业你需要编写`model`下面的结构体，`service`下面的逻辑函数，你可以通过下面的方式自行测试

首先你需要执行
```bash
go build -o zx .

# 启动程序 程序名 --参数
./zx [args]
```

可用的命令如下：

|命令|说明|示例用法|输出格式|注释|
|--|--|--|--|--|
|add|添加一个学生|zx -add "Asice Cloud,18,{read,write}"|添加成功：`id:1`,添加失败: `Falied`|字段分别表示用户名，年龄，权限，权限的可取值为`read,write,run`的组合，或者如果有`all`，则表示拥有全部权限，如果识别到三个，那么权限也是`all`|
|get|查看所有学生|zx -get|见下方注解|查看所有学生信息,没有学生就显示nothing|
|h|help,显示所有命令用法|zx -h|自行设计|需要包含上面两个命令，其他自己要想设计也可以|

##### 注意，执行了 `./zx [args]`后程序会执行完毕并退出，但是我们要求add的学生信息需要保存下来，以便用get查看。所以你需要思考如何使用json文件来持久化存储信息, json文件请放置在项目根目录下（就是跟main.go在同一级）

这是上面`get`命令的输出格式，请自行了解`json`格式，并完成格式化

```json
{
    "data":[
        {
            "id":1
            "username":"Asice Cloud",
            "age": 5,
            "permission": ["read","write"]
        },
        {
            "id":2
            "username":"xhh 哥哥是18岁天才美少女",
            "age": 18,
            "permission": ["all"]
        }
        // 其他数据....
    ]
}
```

help输出格式为:
```
命令：
./zx -h

输出：
usage:
./zx -add "name,age,{permission}"  : 你可以简单描述命令
./zx -get ： 可以简单描述
./zx -h : 可以简单描述
```



