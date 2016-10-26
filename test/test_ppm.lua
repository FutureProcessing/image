require 'image'

myTests = torch.TestSuite()
local tester = torch.Tester()

function myTests.test_ppmload()
    -- test.ppm is a 100x1 "French flag" like image, i.e the first pixel is blue
    -- the 84 next pixels are white and the 15 last pixels are red.
    -- This makes possible to implement a non regression test vs. the former
    -- PPM loader which had for effect to skip the first 85 pixels because of
    -- a header parser bug
    local img = image.load(paths.concat(sys.fpath(), "test.ppm"))
    local pix = img[{ {}, {1}, {1} }]

    -- Check the first pixel is blue
    local ref = torch.zeros(3, 1, 1); ref[3][1][1] = 1
    tester:assertTensorEq(pix, ref, 0, "PPM load: first pixel check failed")
end

tester:add(myTests)
return tester:run()
