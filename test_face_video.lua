require 'torch'
require 'image'
require 'ffmpeg'
require 'sys'
draw = require 'draw'
ffi = require 'ffi'

ffi.cdef
[[
	int detect_face_fromtensor(THFloatTensor* facearray, THFloatTensor* img);
]]

func = ffi.load('./lib/libmyfuncs_c.so')
vid = ffmpeg.Video{path='./video', length=10}

for i = 1, vid.nframes do
  sys.tic()
  local facearray = torch.FloatTensor(40)
  local frame = vid:get_frame(1, i):float()
  --frame = image.rgb2y(frame)
  frame = frame * 255
  facenum = func.detect_face_fromtensor(torch.cdata(facearray), torch.cdata(frame))
  frame = frame / 255
  if facenum > 0 then
    print('Face Number:'..facenum)
    facearray = facearray:reshape(10, 4) + 1
    for j = 1, facenum do
      draw.drawBox(frame, facearray[j][2], facearray[j][1], facearray[j][3], facearray[j][4], 3, {1, 0, 0})
    end
  end
  w = image.display{image=frame, win=w}
  print('FPS: '..1/sys.toc())
end
print('Finish')
