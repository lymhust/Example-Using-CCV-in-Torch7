require 'torch'
require 'image'
draw = require 'draw'
ffi = require 'ffi'

ffi.cdef
[[
	int detect_face_fromfile(THFloatTensor* facearray, const char* imname);
]]

func = ffi.load('./lib/libmyfuncs_c.so')

imname = './faceimage2.jpg'
facearray = torch.FloatTensor(40)
facenum = func.detect_face_fromfile(torch.cdata(facearray), imname)
print('Face Number:'..facenum)
facearray = facearray:reshape(10, 4) + 1
print(facearray)

img = image.load(imname)

for i = 1, facenum do
	draw.drawBox(img, facearray[i][2], facearray[i][1], facearray[i][3], facearray[i][4], 3, {1, 0, 0})
end

image.display(img)
image.save(imname..'_results'..'.jpg', img)
