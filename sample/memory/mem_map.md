# map和channel

## map的创建

map的语意为一个指向hmap的指针。
(string的语意是stringStruct。字符串为"" 和 长度为0的语意相同，
即`len(str) == 0` 和 `str == ""` 会被编译为相同的汇编代码，只判断长度。
slice的语意为slice。`sli == nil` 意味着{nil,?,?}的slice，
`len(sli) == 0` 意味着{?,0,?}的slice，cgo中需要注意这点。

map的创建方式有三种:
1. m:=map[int]int{}
2. m:=make(map[int]int)
3. var m map[int]int
