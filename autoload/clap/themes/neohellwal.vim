let s:p = has("nvim") == 1 ? luaeval('require("neohellwal.theme.plugins.clap").get()') : luaeval('vim.dict(require("neohellwal.theme.plugins.clap").get())')
let g:clap#themes#neohellwal#palette = s:p
