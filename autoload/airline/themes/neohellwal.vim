let s:p = has("nvim") == 1 ? luaeval('require("neohellwal.theme.plugins.airline").get()') : luaeval('vim.dict(require("neohellwal.theme.plugins.airline").get())')
let g:airline#themes#neohellwal#palette = s:p
