# 声明和初始化语意

1. 对于slice: `s := []int{}` 和 `var s []int`
对于前者，结果为一个 `slice{ ptr=data, len=0, cap=0 }`
对于后者，结果为一个 `slice{ ptr=nil, len=0 ,cap=0 }`
2. 对于string，`s := ""` 和 `var s string` 两者相同，都是stringStruct{nil,0}
3. 对于map，chan这种指针语意的结构，
`m := map[int]int{}` 意味着指向空map的指针，
`var m map[int]int` 意味着空指针。

# nil的语意

在go里面，常常用 nil 来判断一个变量是否初始化，但是对于不同的变量，nil的语意是不同的。
对于指针类型，nil即表示指针的值为0 。未初始化的指针即为 nil (chan 和 map都是指针语意)

对于非指针类型，即slice和string，情况有些特殊，
首先string不能和nil比较，string要和""比较，比较的语意为stringStruct.len==0
而slice可以和nil比较，`sli == nil` 意味着`slice.ptr == nil`，

# len(var) == 0 和 var == nil
* slice:`len(sli) == 0` 意味着 `slice.len == 0`, 
`sli == nil` 意味着 `slice.ptr == nil` 。
* string:两者意思相同(string 的nil对应 "")，即 `string.len == 0` 。
* map: `len(m) == 0` 会先判断 `m == nil` ，非nil则继续判断 `map.size == 0`, 
`m == nil` 只会判断是否为空指针。 chan同理。