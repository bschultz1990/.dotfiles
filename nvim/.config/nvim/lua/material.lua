local material = require 'material'
local colors = require 'material.colors'

material.setup {
  custom_highlights = {
    MatchParen = { bg = colors.main.yellow, bold = true }
  }
}
