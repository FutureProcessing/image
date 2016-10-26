--[[
This should look like that: (aggregating tests)
But it doesn't work in my `totem` - instead `torch.Tester` is created,
and `add()` only accepts tables of functions.
   
require 'totem'

local tester = totem.Tester()
tester:add('test_ppm.lua')
tester:add('test_vflip.lua')
(...)
return tester:run()
]]

dofile 'test_decompress_jpg.lua'
dofile 'test_ppm.lua'
dofile 'test_vflip.lua'
