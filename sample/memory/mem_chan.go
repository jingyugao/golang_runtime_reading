package main

func f13() chan int {
	var c chan int
	return c
}

func f14() chan int {
	c := make(chan int, 0)
	return c
}

// 返回一个只读的chan
func f15() <-chan int {
	c := make(chan int, 10)
	return c
}
