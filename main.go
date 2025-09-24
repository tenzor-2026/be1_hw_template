package main

import (
	"flag"
	"fmt"
	"os"
	"zx/cmd"
)

func main() {
	var addStudent = flag.String("add", "", "添加一个学生，格式：\"姓名,年龄,{权限列表}\"")
	var getStudents = flag.Bool("get", false, "查看所有学生")
	var showHelp = flag.Bool("h", false, "显示帮助信息")

	flag.Parse()

	if *showHelp {
		result := cmd.Help()
		fmt.Println(result)
	} else if *addStudent != "" {
		cmd.Add(addStudent)
	} else if *getStudents {
		result := cmd.Get()
		fmt.Println(string(result))
	} else {
		fmt.Println("使用 -h 查看帮助信息")
		os.Exit(1)
	}
}
