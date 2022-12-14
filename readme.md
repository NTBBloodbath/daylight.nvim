# `daylight.nvim`

`daylight.nvim` is an automatic colorscheme/background switcher for Neovim based on your current local time by using a
LibUV timer to check your current time by using an interval.


## Installation

Using packer:
```lua
use({
  "NTBBloodbath/daylight.nvim",
  config = function()
    require("daylight").setup({
      day = {
        name = vim.g.colors_name,
        time = 8, -- 8 am
      },
      night = {
        name = vim.g.colors_name,
        time = 19, -- 7 pm, changes to dark theme on 07:01
      },
      interval = 60000, -- Time in milliseconds, 1 minute
    })
  end,
})
```


## Usage

`daylight.nvim` should work automatically once it gets loaded. However, if you want to start/stop it manually you can
use the following commands:
- `DaylightStop`
- `DaylightStart`
- `DaylightToggle`

**NOTE**: This only handles `daylight.nvim` timer!


## Acknowledgements

I did take [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) `types/types.d.tl` file to be able to use
Neovim API (`vim` metatable) in Teal.


## License

As always, this project is licensed under [GPLv3](./LICENSE) license.
