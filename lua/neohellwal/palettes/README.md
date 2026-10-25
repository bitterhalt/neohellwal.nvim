# 🎨 Alternative Palettes

This folder contains the built-in palette files used by the `use_palette` option.

To use any palette present in this directory, set `use_palette` to the palette name in NeoHellwal's `setup()` function. See the [palette documentation](../../../docs/neohellwal-palettes.md) for details.

```lua
require("neohellwal").setup({
    use_palette = "catppuccin-mocha"

    -- or

    use_palette = {
        dark = "catppuccin-mocha"
        light = "tokyonight"
    }
})
```
