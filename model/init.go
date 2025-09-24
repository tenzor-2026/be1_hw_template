package model

import "fmt"

// 在model层新建其他文件用来设计你的结构体

func connectToDB() {
	// 以后用来连接数据库,现在留空
	fmt.Println("连接数据库")
}

func init() {
	connectToDB()
}
