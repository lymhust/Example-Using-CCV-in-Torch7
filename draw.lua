require 'image'
local draw = {}

function draw.drawBox(img, x, y, w, h, lineWidth, color)
  print('Drawing Box')
  if color == nil then
    color = {1, 0, 0}
  end
  local imsize = #img
  local imC, imW, imH = imsize[1], imsize[3], imsize[2]
  local topleft, bottomright = {}, {} 
  topleft.x = x --(x - h/2)
  topleft.y = y --(y - w/2)
  bottomright.x = x + h --(x + h/2)
  bottomright.y = y + w --(y + w/2)
  if imC == 3 then
    -- Line one
    img[1][{ {topleft.x, bottomright.x},{topleft.y, topleft.y+lineWidth} }] = color[1]
    img[2][{ {topleft.x, bottomright.x},{topleft.y, topleft.y+lineWidth} }] = color[2]
    img[3][{ {topleft.x, bottomright.x},{topleft.y, topleft.y+lineWidth} }] = color[3]
    -- Line two
    img[1][{ {topleft.x, bottomright.x},{bottomright.y-lineWidth, bottomright.y} }] = color[1]
    img[2][{ {topleft.x, bottomright.x},{bottomright.y-lineWidth, bottomright.y} }] = color[2]
    img[3][{ {topleft.x, bottomright.x},{bottomright.y-lineWidth, bottomright.y} }] = color[3]
    -- Line three
    img[1][{ {topleft.x, topleft.x+lineWidth},{topleft.y, bottomright.y} }] = color[1]
    img[2][{ {topleft.x, topleft.x+lineWidth},{topleft.y, bottomright.y} }] = color[2]
    img[3][{ {topleft.x, topleft.x+lineWidth},{topleft.y, bottomright.y} }] = color[3]
    -- Line four
    img[1][{ {bottomright.x-lineWidth, bottomright.x},{topleft.y, bottomright.y} }] = color[1]
    img[2][{ {bottomright.x-lineWidth, bottomright.x},{topleft.y, bottomright.y} }] = color[2]
    img[3][{ {bottomright.x-lineWidth, bottomright.x},{topleft.y, bottomright.y} }] = color[3]
  else
    local colorgray
    if type(color) == 'number' then
      colorgray = color
    else
      colorgray = 0.2989*color[1] + 0.5870*color[2] + 0.1140*color[3]
    end
    -- Line one
    img[1][{ {topleft.x, bottomright.x},{topleft.y, topleft.y+lineWidth} }] = colorgray
    -- Line two
    img[1][{ {topleft.x, bottomright.x},{bottomright.y-lineWidth, bottomright.y} }] = colorgray
    -- Line three
    img[1][{ {topleft.x, topleft.x+lineWidth},{topleft.y, bottomright.y} }] = colorgray
    -- Line four
    img[1][{ {bottomright.x-lineWidth, bottomright.x},{topleft.y, bottomright.y} }] = colorgray
  end

  return img
end

return draw
