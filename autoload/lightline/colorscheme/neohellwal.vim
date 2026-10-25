let s:p = has("nvim") == 1 ? luaeval('require("neohellwal.theme.plugins.lightline").get()') : luaeval('vim.dict(require("neohellwal.theme.plugins.lightline").get())')
let g:lightline#colorscheme#neohellwal#palette = lightline#colorscheme#fill(s:p)
