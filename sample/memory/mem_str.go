package main

import "fmt"

func f1() string {
	ret := "literial string"
	return ret
}
func f2() string {
	bs := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	ret := string(bs)
	return ret
}
func f3() string {
	var ret string
	ret = ret + "from append"
	return ret
}
func main() {
	fmt.Println("vim-go")
}
