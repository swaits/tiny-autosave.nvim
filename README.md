# tiny-autosave.nvim

A tiny auto-save plugin for Neovim 0.12+. Saves modified buffers on
`InsertLeave` and `FocusLost`.

Zero config. ~15 lines of Lua.

## Features

- Auto-saves on leaving insert mode and losing focus
- Only saves normal file buffers (skips special buffers)
- Configurable trigger events
- Works out of the box — no setup call required

## Requirements

- Neovim >= 0.12

## Installation

Add to your `vim.pack.add()` call:

```lua
"https://github.com/swaits/tiny-autosave.nvim",
```

Done. The plugin auto-loads with sensible defaults.

## Configuration

All options are optional. Call `setup()` only if you want to customize:

```lua
require("tiny-autosave").setup({
  events = { "InsertLeave", "FocusLost" }, -- events that trigger save
})
```

## How it works

On the configured events, the plugin checks if the current buffer is a
normal file buffer (`buftype == ""`) and has unsaved changes. If so, it
runs `silent! wall` to save all modified buffers.

## License

[MIT](LICENSE)
