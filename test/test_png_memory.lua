require 'image'
require 'torch'
have_lfs, lfs = pcall(require, 'lfs')

local fn = 'lane.png' 

local myTests = torch.TestSuite()
local tester = torch.Tester()

function myTests._setUp()
   local lane = image.lena()
   image.save(fn, lane)
end

function myTests.test_pngload()
   file_lena = torch.ByteTensor.libpng.load(fn)
   io_lena = io.open(fn, 'rb')
   str_lena = io_lena:read('*all')
   io_lena:close()   
   mem_lena = torch.ByteTensor.libpng.loads(str_lena)
   tester:assertTensorEq(file_lena, mem_lena, 0, "PNG loads: resulting tensors differ")
end

function myTests._tearDown()
   if have_lfs and lfs.unlink then
      lfs.unlink(fn)
   end
end

tester:add(myTests)
return tester:run()
