package main

import (
	"fmt"
	"math"
	"sort"
)

// Asks the user for two positive integers
// and returns the 10 happy numbers between them
// with the greatest norms, sorted descending by the norms

// by Nate Jackson for CSC330

func main() {
	var x, y int

	fmt.Print("First Argument: ")
	fmt.Scanln(&x)
	fmt.Print("Second Argument: ")
	fmt.Scanln(&y)

	if x == y {
		fmt.Println("NOBODYS HAPPY")
		return
	}
	sortNorms(filter(createArray(x, y)))

}

//filles a slice with numbers between entered values
func createArray(x int, y int) []int {
	nums := []int{}
	if x > y {
		n := x
		x = y
		y = n
	}

	for i := x; i < y; i++ {
		nums = append(nums, i)
	}
	return nums
}

//returns a slice with numbers that are not happy removed
func filter(nums []int) []int {
	output := []int{}
	for _, i := range nums {
		if happy(i) {
			output = append(output, i)
		}
	}
	return output
}

//determines whether a number is happy
func happy(n int) bool {
	m := make(map[int]bool)
	for n > 1 {
		m[n] = true
		var x int
		for x, n = n, 0; x > 0; x /= 10 {
			d := x % 10
			n += d * d
		}
		if m[n] {
			return false
		}
	}
	return true
}

//takes in the list of happy numbers, calculates each's norm,
//sorts the list based on the norm, then prints the list of happy numbers
func sortNorms(nums []int) {
	if len(nums) == 0 {
		fmt.Println("NOBODYS HAPPY")
		return
	}
	normMap := make(map[int]float64)
	for _, i := range nums {
		n := norm(i)
		normMap[i] = n
	}
	keys := make([]int, 0, len(normMap))
	for k := range normMap {
		keys = append(keys, k)
	}
	sort.SliceStable(keys, func(i, j int) bool {
		return normMap[keys[i]] > normMap[keys[j]]
	})

	//limiting output to top 10 values
	for j := 0; j < 10 && j < len(keys); j++ {
		fmt.Println(keys[j])
	}
}

//calculates the norm of a given happy number
func norm(num int) float64 {
	cache := make(map[int]bool)

	norm := 0.0
	for num > 1 {
		cache[num] = true
		var x int
		for x, num = num, 0; x > 0; x /= 10 {
			d := x % 10
			num += d * d
		}
	}
	keys := make([]int, 0, len(cache))
	for k := range cache {
		keys = append(keys, k)
	}
	for _, x := range keys {
		y := x
		y *= y
		norm += float64(y)
	}
	norm = math.Sqrt(norm)
	return norm
}

//contains method for slice/array
func contains(sl []int, name int) bool {
	for _, value := range sl {
		if value == name {
			return true
		}
	}
	return false
}
