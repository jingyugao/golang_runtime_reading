package main

var F string
var G string
var H []byte

func sem() string {
	var s string
	if F == "" {
		return "nil"
	}
	if len(F) == 1 {
		return "1"
	}
	if F == G {
		return "nil"
	}
	return s + "x"
}

func sem2() []byte {
	var b []byte
	if len(H) == 0 {
		return nil
	}
	if H == nil {
		return nil
	}
	return b
}
