package service

type Client interface {
	Add(*string) string
	Get() []byte
	Help() any
}

type CmdClient struct{}

func NewClient() *CmdClient {
	return &CmdClient{}
}
