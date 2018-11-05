package main

func f4() []byte {
	ret := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	return ret
}

func f5() []byte {
	tmp := []byte{'s', 'o', 'm', 'e', ' ', 'b', 'y', 't', 'e', 's'}
	ret := tmp[1:9]
	return ret
}

func f6() []byte {
	var ret []byte
	ret = append(ret, 'x')
	return ret
}

func f7() []byte {
	ret := make([]byte, 10)
	return ret
}

func f8() []byte {
	ret := []byte("literal string")
	return ret
}

func f9() []byte {
	array := [10]byte{'a', 'r', 'r', 'a', 'y'}
	return array[1:5]
}
