-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- Credit itchyny, jackno (lightline)
-- stylua: ignore
local colors = {
  black   = '#000000',
  maroon  = '#800000',
  green   = '#008000',
  olive   = '#808000',
  navy    = '#000080',
  purple  = '#800080',
  teal    = '#008080',
  silver  = '#c0c0c0',
  gray    = '#808080',
  red     = '#ff0000',
  lime    = '#00ff00',
  yellow  = '#ffff00',
  blue    = '#0000ff',
  fuchsia = '#ff00ff',
  aqua    = '#00ffff',
  white   = '#ffffff',
}

return {
  normal = {
    a = { fg = colors.fuchsia, bg = colors.default },
    b = { fg = colors.olive, bg = colors.default },
--  b = { fg = colors.green, bg = colors.black },
    c = { fg = colors.olive, bg = colors.default },
--  c = { fg = colors.green, bg = colors.black },
  },
  insert = { a = { fg = colors.maroon, bg = colors.default } },
  visual = { a = { fg = colors.olive, bg = colors.default } },
  replace = { a = { fg = colors.teal, bg = colors.default } },
  inactive = {
    a = { fg = colors.silver, bg = colors.gray, },
    b = { fg = colors.gray, bg = colors.black },
    c = { fg = colors.silver, bg = colors.black },
  },
}
