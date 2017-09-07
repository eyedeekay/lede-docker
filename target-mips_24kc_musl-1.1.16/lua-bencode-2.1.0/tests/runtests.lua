#!/usr/bin/env lua

local tests = { "compare", "neg_int", "short_string" }
local total, fail = 0,0

for _,x in ipairs(tests) do
	print("Running test:", x)
	io.stdout:flush()
	local f, t = dofile(x..".lua")
	fail = fail + f
	total = total + t
	print()
end 

print("Number of failed tests", fail)
print("Number of total tests", total)
