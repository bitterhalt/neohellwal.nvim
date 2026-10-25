local M = {}
local C = require("neohellwal.lib.palette").get()
local O = require("neohellwal.lib.config").options

---@type NeoHellwalPluginsClapOptions
M.default_options = {
    colors = {
        indicator = "color8",
        spinner = "color2",
        selected = "color6",
        current_selection = "color4",
    },
    styles = {
        indicator = { "italic" },
        spinner = { "bold" },
        selected = { "bold", "underline" },
        current_selection = { "bold" },
    },
}
M.options = M.default_options

local did_setup = false
---@param user_config NeoHellwalPluginsClapOptions?
function M.setup(user_config)
    user_config = user_config or {}
    M.options = vim.tbl_deep_extend("keep", user_config, M.default_options)

    for option in pairs(M.options.colors) do
        local default_color = C[M.default_options.colors[option]]
        local final_color = M.options.colors[option]
        if type(final_color) == "function" then final_color = final_color(C) end
        final_color = require("neohellwal.utils.color").validate(final_color, default_color)
        M.options.colors[option] = final_color
    end

    local final_styles = {}
    for section, section_styles in pairs(M.options.styles) do
        local properties = {}

        for _, style in pairs(section_styles) do
            if not O.no_italic and style == "italic" then table.insert(properties, style) end
            if not O.no_bold and style == "bold" then table.insert(properties, style) end
            if not O.no_underline and style == "underline" then table.insert(properties, style) end
            if not O.no_undercurl and style == "undercurl" then table.insert(properties, style) end
            if not O.no_strikethrough and style == "strikethrough" then table.insert(properties, style) end
        end

        final_styles[section] = table.concat(properties, ",")
    end
    M.options.styles = final_styles

    did_setup = true
end

function M.get()
    if not did_setup then M.setup() end

    local neohellwal = {}
    local bg = (O.transparent_background and vim.o.winblend == 0 and vim.o.pumblend == 0) and C.none or C.background
    local colors = M.options.colors
    local styles = M.options.styles

    neohellwal.display = {
        guibg = bg,
        guifg = C.foreground,
        gui = "bold",
    }
    neohellwal.input = neohellwal.display
    neohellwal.preview = neohellwal.display
    neohellwal.search_text = neohellwal.display

    neohellwal.indicator = { guibg = bg, guifg = colors.indicator, gui = styles.indicator or {} }
    neohellwal.spinner = { guibg = bg, guifg = colors.spinner, gui = styles.spinner or {} }

    neohellwal.selected = { guibg = C.cursorline, guifg = colors.selected, gui = styles.selected or {} }
    neohellwal.selected_sign = neohellwal.selected

    neohellwal.current_selection =
        { guibg = C.cursorline, guifg = colors.current_selection, gui = styles.current_selection or {} }
    neohellwal.current_selection_sign = neohellwal.current_selection

    return neohellwal
end

return M
