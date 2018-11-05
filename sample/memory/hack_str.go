package main

import "unsafe"

type mStringStruct struct {
	str unsafe.Pointer
	len int
}

func hack_str() {
	str := "a string"

	println(str == "", len(str))

	p := unsafe.Pointer(&str)
	mStr := (*mStringStruct)(p)

	mStr.len = 0
	println(str == "", len(str))

	mStr.len = 100
	mStr.str = unsafe.Pointer(uintptr(0))
	println(str == "", len(str))

}

type mSliceStruct struct {
	array unsafe.Pointer
	len   int
	cap   int
}

func hack_slice() {
	bs := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e'}

	println(bs == nil, len(bs))

	p := unsafe.Pointer(&bs)
	mSlice := (*mSliceStruct)(p)

	mSlice.len = 0
	println(bs == nil, len(bs))

	mSlice.array = unsafe.Pointer(uintptr(0))
	mSlice.len = 10
	println(bs == nil, len(bs))
}
func main() {
	println("hack_str")
	hack_str()
	println("hack_slice")
	hack_slice()

}
