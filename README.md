# 后端第一次作业

**/test/\*,/cmd/\* 不允许修改**

## 说明

这次作业你需要编写`model`下面的结构体，`service`下面的逻辑函数，你可以通过下面的方式自行测试

首先你需要执行
```bash
go build . -o zx
```



可用的命令如下：

|命令|说明|示例用法|输出格式|注释|
|--|--|--|--|--|
|add|添加一个学生|zx -add "Asice Cloud,18,{read,write}"|添加成功：`id:1`,添加失败: `Falied`|字段分别表示用户名，年龄，权限，权限的可取值为`read,write,run`的组合，或者如果有`all`，则表示拥有全部权限，如果识别到三个，那么权限也是`all`|
|get|查看所有学生|zx -get|见下方注解|查看所有学生信息|
|help|显示所有命令用法|zx -help|自行设计||

这是上面`get`命令的输出格式，请自行了解`json`格式，并完成格式化

```json
{
    "data":[
        {
            "id":1
            "username":"Asice Cloud",
            "age": 18,
            "permission": ["read","write"]
        }
        // .... 还有其他数据则一样的格式
    ]
}
```



