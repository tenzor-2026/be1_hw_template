package cmd

import (
	"fmt"
	"zx/service"
)

var cli service.Client

func init() {
	cli = service.NewClient()
}

func Add(ss *string) {
	fmt.Println(cli.Add(ss))
}

func Get() []byte {
	return cli.Get()
}

func Help() any {
	return cli.Help()
}
