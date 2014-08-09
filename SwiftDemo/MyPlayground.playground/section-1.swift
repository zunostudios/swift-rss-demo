// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

func inc(x:Int) -> Int {
    return x + 1;
}

var f:(Int -> Int) = 	{ (x) -> Int in x + 1; };

[1,2,3,4].map(inc)
[1,2,3,4].map(f)

var nums = [1,2,3,4,5];
for(var i:Int = 0; i < nums.count; i++) {
    nums[i] = nums[i] + 1;
}
nums;

var a = 2;
 a = 2.3;


var F:((Int -> Int) -> (Int -> Int)) =
{
    (g) in{(n) in g(g(n))}
};


F(inc)(2);

func double ( f:(Int -> Int) ) -> (Int -> Int) {
    return { (n:Int) in f(f(n)) };
}
