-- Test if strings truncated before the last character are correctly reported
-- as truncated data.
-- Bug+fix reported by Jorge "xopxe" Visca on 2013-12-07, fixed in 40:1918f698336c

local b = require 'bencode'

local total,fail = 0,0

local broken = {
	"3:a", -- this never worked to begin with. (and it shouldn't)
	"3:ab" -- this wasn't detected properly prior to Dec 2013
}

for _,v in ipairs(broken) do
	total = total + 1
	if b.decode(v) ~= nil then
		fail = fail + 1
		print (v, "FAIL")
	else
		print (v, "OK")
	end
end

return fail,total
